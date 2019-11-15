const { readFileSync } = require("fs");
const crypto = require('crypto');
const fs = require('fs')
const {keccak256} = require('ethereumjs-util')

let memory = {};
let memoryBytes = [];
let callData = {
    functionSignature: "",

};

let importObject = {
    ethereum: {
        finish: function () {
        },
        getCallValue: function () { return 1; },
        storageStore: function () {
        },
        getGasLeft: function () { return 1000; },
        callStatic: function () {
        },
        returnDataCopy: function () {
        },
        getCaller: function () {
        },
        storageLoad: function () {
        },
        revert: function () {
        },
        getCallDataSize: function () { return 36; }, callDataCopy: callDataCopy, log: function () {
        }
    }, my: { dumpi32: function () { console.log(arguments); } }
}

function callDataCopy(resultOffset, dataOffset, length) {
    console.log(`callDataCopy(${JSON.stringify(arguments, null, 1)})`);

    if (dataOffset == 0 && length == 4) {
        let methodSelector = getFunctionHash(callData.functionSignature);
        methodSelector.copy(memoryBytes, resultOffset)
    }
}

function getFunctionHash(signature) {
    let hash = keccak256(signature);
    console.log("Hex:" + hash.toString("hex"));
    let prefix = hash.slice(0, 4)
    console.log(prefix);
    return prefix;
}

const run = async () => {
    const buffer = readFileSync("./0-0-3-with-llvm9/contract.wasm"); const module = await WebAssembly.compile(buffer);
    const instance = await WebAssembly.instantiate(module, importObject);

    memory = instance.exports.memory;
    memoryBytes = new Uint8Array(memory.buffer);

    callData.functionSignature = "balanceOf(address)"; // 70a08231b98ef4ca268c9cc3f6b4590e4bfec28280db06bb5d45e689f2a360be
    console.log(instance.exports.main());

    //console.log(memory.buffer);    // var view = new Uint8Array(memory.buffer);
    // for (var i = 0; i < 100; i++) {    //     console.log(view[i]);    // }
};

run();