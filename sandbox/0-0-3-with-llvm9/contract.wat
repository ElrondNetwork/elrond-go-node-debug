(module
  (type (;0;) (func (param i32 i32)))
  (type (;1;) (func (param i32)))
  (type (;2;) (func (result i64)))
  (type (;3;) (func (param i64 i32 i32 i32) (result i32)))
  (type (;4;) (func (param i32 i32 i32)))
  (type (;5;) (func (result i32)))
  (type (;6;) (func (param i32 i32 i32 i32 i32 i32 i32)))
  (type (;7;) (func (param i32 i64 i64 i64 i64)))
  (type (;8;) (func (param i32 i64 i64 i64)))
  (type (;9;) (func (param i64 i64 i64 i64 i64 i64 i64)))
  (type (;10;) (func))
  (import "ethereum" "finish" (func $ethereum.finish (type 0)))
  (import "ethereum" "getCallValue" (func $ethereum.getCallValue (type 1)))
  (import "ethereum" "revert" (func $ethereum.revert (type 0)))
  (import "ethereum" "storageStore" (func $ethereum.storageStore (type 0)))
  (import "ethereum" "getGasLeft" (func $ethereum.getGasLeft (type 2)))
  (import "ethereum" "callStatic" (func $ethereum.callStatic (type 3)))
  (import "ethereum" "returnDataCopy" (func $ethereum.returnDataCopy (type 4)))
  (import "ethereum" "getCaller" (func $ethereum.getCaller (type 1)))
  (import "ethereum" "storageLoad" (func $ethereum.storageLoad (type 0)))
  (import "ethereum" "getCallDataSize" (func $ethereum.getCallDataSize (type 5)))
  (import "ethereum" "callDataCopy" (func $ethereum.callDataCopy (type 4)))
  (import "ethereum" "log" (func $ethereum.log (type 6)))
  (func $solidity.bswapi256 (type 7) (param i32 i64 i64 i64 i64)
    local.get 0
    local.get 4
    i64.const 56
    i64.shr_u
    local.get 4
    i64.const 56
    i64.shl
    i64.or
    local.get 4
    i64.const 40
    i64.shl
    i64.const 71776119061217280
    i64.and
    i64.or
    local.get 4
    i64.const 24
    i64.shl
    i64.const 280375465082880
    i64.and
    i64.or
    local.get 4
    i64.const 8
    i64.shl
    i64.const 1095216660480
    i64.and
    i64.or
    local.get 4
    i64.const 8
    i64.shr_u
    i64.const 4278190080
    i64.and
    i64.or
    local.get 4
    i64.const 24
    i64.shr_u
    i64.const 16711680
    i64.and
    i64.or
    local.get 4
    i64.const 40
    i64.shr_u
    i64.const 65280
    i64.and
    i64.or
    i64.store
    local.get 0
    i32.const 24
    i32.add
    local.get 1
    i64.const 56
    i64.shl
    local.get 1
    i64.const 40
    i64.shl
    i64.const 71776119061217280
    i64.and
    i64.or
    local.get 1
    i64.const 24
    i64.shl
    i64.const 280375465082880
    i64.and
    i64.or
    local.get 1
    i64.const 8
    i64.shl
    i64.const 1095216660480
    i64.and
    i64.or
    local.get 1
    i64.const 8
    i64.shr_u
    i64.const 4278190080
    i64.and
    i64.or
    local.get 1
    i64.const 24
    i64.shr_u
    i64.const 16711680
    i64.and
    i64.or
    local.get 1
    i64.const 40
    i64.shr_u
    i64.const 65280
    i64.and
    i64.or
    local.get 1
    i64.const 56
    i64.shr_u
    i64.or
    i64.store
    local.get 0
    local.get 2
    i64.const 56
    i64.shl
    local.get 2
    i64.const 40
    i64.shl
    i64.const 71776119061217280
    i64.and
    i64.or
    local.get 2
    i64.const 24
    i64.shl
    i64.const 280375465082880
    i64.and
    i64.or
    local.get 2
    i64.const 8
    i64.shl
    i64.const 1095216660480
    i64.and
    i64.or
    local.get 2
    i64.const 8
    i64.shr_u
    i64.const 4278190080
    i64.and
    i64.or
    local.get 2
    i64.const 24
    i64.shr_u
    i64.const 16711680
    i64.and
    i64.or
    local.get 2
    i64.const 40
    i64.shr_u
    i64.const 65280
    i64.and
    i64.or
    local.get 2
    i64.const 56
    i64.shr_u
    i64.or
    i64.store offset=16
    local.get 0
    local.get 3
    i64.const 56
    i64.shl
    local.get 3
    i64.const 40
    i64.shl
    i64.const 71776119061217280
    i64.and
    i64.or
    local.get 3
    i64.const 24
    i64.shl
    i64.const 280375465082880
    i64.and
    i64.or
    local.get 3
    i64.const 8
    i64.shl
    i64.const 1095216660480
    i64.and
    i64.or
    local.get 3
    i64.const 8
    i64.shr_u
    i64.const 4278190080
    i64.and
    i64.or
    local.get 3
    i64.const 24
    i64.shr_u
    i64.const 16711680
    i64.and
    i64.or
    local.get 3
    i64.const 40
    i64.shr_u
    i64.const 65280
    i64.and
    i64.or
    local.get 3
    i64.const 56
    i64.shr_u
    i64.or
    i64.store offset=8)
  (func $balanceOf.address (type 8) (param i32 i64 i64 i64)
    (local i32 i32 i64 i32)
    global.get 0
    i32.const 208
    i32.sub
    local.tee 4
    global.set 0
    local.get 4
    local.tee 5
    i32.const 136
    i32.add
    call $ethereum.getCallValue
    block  ;; label = @1
      local.get 5
      i64.load offset=136
      local.get 5
      i32.const 136
      i32.add
      i32.const 8
      i32.add
      i64.load
      i64.or
      i64.const 0
      i64.ne
      br_if 0 (;@1;)
      local.get 5
      i32.const 104
      i32.add
      local.get 1
      local.get 2
      local.get 3
      i64.const 4294967295
      i64.and
      i64.const 0
      call $solidity.bswapi256
      local.get 5
      i32.const 104
      i32.add
      i32.const 8
      i32.add
      i64.load
      local.set 1
      local.get 5
      i32.const 104
      i32.add
      i32.const 16
      i32.add
      i64.load
      local.set 2
      local.get 5
      i32.const 104
      i32.add
      i32.const 24
      i32.add
      i64.load
      local.set 3
      local.get 5
      i64.load offset=104
      local.set 6
      local.get 4
      i32.const -64
      i32.add
      local.tee 4
      local.tee 7
      global.set 0
      local.get 4
      i32.const 56
      i32.add
      i64.const 216172782113783808
      i64.store
      local.get 4
      i32.const 48
      i32.add
      i64.const 0
      i64.store
      local.get 4
      i32.const 40
      i32.add
      i64.const 0
      i64.store
      local.get 4
      i64.const 0
      i64.store offset=32
      local.get 4
      i32.const 24
      i32.add
      local.get 3
      i64.store
      local.get 4
      local.get 2
      i64.store offset=16
      local.get 4
      local.get 1
      i64.store offset=8
      local.get 4
      local.get 6
      i64.store
      local.get 5
      i64.const 0
      i64.store offset=192
      local.get 5
      i64.const 0
      i64.store offset=184
      local.get 5
      i64.const 33554432
      i64.store32 offset=200
      call $ethereum.getGasLeft
      local.get 5
      i32.const 184
      i32.add
      local.get 4
      i32.const 64
      call $ethereum.callStatic
      drop
      local.get 5
      i32.const 152
      i32.add
      i32.const 0
      i32.const 32
      call $ethereum.returnDataCopy
      local.get 5
      i32.const 72
      i32.add
      local.get 5
      i64.load offset=152
      local.get 5
      i32.const 152
      i32.add
      i32.const 8
      i32.add
      i64.load
      local.get 5
      i32.const 152
      i32.add
      i32.const 16
      i32.add
      i64.load
      local.get 5
      i32.const 152
      i32.add
      i32.const 24
      i32.add
      i64.load
      call $solidity.bswapi256
      local.get 5
      i32.const 40
      i32.add
      local.get 5
      i64.load offset=72
      local.get 5
      i32.const 72
      i32.add
      i32.const 8
      i32.add
      i64.load
      local.get 5
      i32.const 72
      i32.add
      i32.const 16
      i32.add
      i64.load
      local.get 5
      i32.const 72
      i32.add
      i32.const 24
      i32.add
      i64.load
      call $solidity.bswapi256
      local.get 5
      i32.const 40
      i32.add
      i32.const 8
      i32.add
      i64.load
      local.set 1
      local.get 5
      i32.const 40
      i32.add
      i32.const 16
      i32.add
      i64.load
      local.set 2
      local.get 5
      i32.const 40
      i32.add
      i32.const 24
      i32.add
      i64.load
      local.set 3
      local.get 5
      i64.load offset=40
      local.set 6
      local.get 7
      i32.const -32
      i32.add
      local.tee 4
      local.tee 7
      global.set 0
      local.get 7
      i32.const -32
      i32.add
      local.tee 7
      global.set 0
      local.get 4
      i32.const 24
      i32.add
      local.get 3
      i64.store
      local.get 4
      local.get 2
      i64.store offset=16
      local.get 4
      local.get 1
      i64.store offset=8
      local.get 4
      local.get 6
      i64.store
      local.get 4
      local.get 7
      call $ethereum.storageLoad
      local.get 5
      i32.const 8
      i32.add
      local.get 7
      i64.load
      local.get 7
      i32.const 8
      i32.add
      i64.load
      local.get 7
      i32.const 16
      i32.add
      i64.load
      local.get 7
      i32.const 24
      i32.add
      i64.load
      call $solidity.bswapi256
      local.get 5
      i32.const 8
      i32.add
      i32.const 8
      i32.add
      i64.load
      local.set 1
      local.get 5
      i32.const 8
      i32.add
      i32.const 24
      i32.add
      i64.load
      local.set 2
      local.get 5
      i64.load offset=8
      local.set 3
      local.get 0
      local.get 5
      i32.const 8
      i32.add
      i32.const 16
      i32.add
      i64.load
      i64.store offset=16
      local.get 0
      i32.const 24
      i32.add
      local.get 2
      i64.store
      local.get 0
      local.get 3
      i64.store
      local.get 0
      local.get 1
      i64.store offset=8
      local.get 5
      i32.const 208
      i32.add
      global.set 0
      return
    end
    i32.const 1085
    i32.const 23
    call $ethereum.revert
    unreachable)
  (func $transfer.address.uint256 (type 9) (param i64 i64 i64 i64 i64 i64 i64)
    (local i32 i32 i32 i64 i64 i64 i64 i32 i32 i32 i64 i64 i64 i64 i64 i64 i64)
    global.get 0
    i32.const 720
    i32.sub
    local.tee 7
    global.set 0
    local.get 7
    local.tee 8
    i32.const 648
    i32.add
    call $ethereum.getCallValue
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 8
              i64.load offset=648
              local.get 8
              i32.const 648
              i32.add
              i32.const 8
              i32.add
              i64.load
              i64.or
              i64.const 0
              i64.ne
              br_if 0 (;@5;)
              local.get 7
              i32.const -32
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 7
              call $ethereum.getCaller
              local.get 8
              i32.const 616
              i32.add
              i64.const 0
              local.get 7
              i64.load
              local.tee 10
              i64.const 32
              i64.shl
              local.get 10
              i64.const 32
              i64.shr_u
              local.get 7
              i32.const 8
              i32.add
              i64.load
              local.tee 10
              i64.const 32
              i64.shl
              i64.or
              local.get 7
              i32.const 16
              i32.add
              i64.load32_u
              i64.const 32
              i64.shl
              local.get 10
              i64.const 32
              i64.shr_u
              i64.or
              call $solidity.bswapi256
              local.get 8
              i32.const 584
              i32.add
              local.get 8
              i64.load offset=616
              local.get 8
              i32.const 616
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.get 8
              i32.const 616
              i32.add
              i32.const 16
              i32.add
              i64.load32_u
              i64.const 0
              call $solidity.bswapi256
              local.get 8
              i32.const 584
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 10
              local.get 8
              i32.const 584
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 11
              local.get 8
              i32.const 584
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 12
              local.get 8
              i64.load offset=584
              local.set 13
              local.get 9
              i32.const -64
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 7
              i32.const 56
              i32.add
              i64.const 216172782113783808
              i64.store
              local.get 7
              i32.const 48
              i32.add
              i64.const 0
              i64.store
              local.get 7
              i32.const 40
              i32.add
              i64.const 0
              i64.store
              local.get 7
              i64.const 0
              i64.store offset=32
              local.get 7
              i32.const 24
              i32.add
              local.get 12
              i64.store
              local.get 7
              local.get 11
              i64.store offset=16
              local.get 7
              local.get 10
              i64.store offset=8
              local.get 7
              local.get 13
              i64.store
              local.get 8
              i64.const 0
              i64.store offset=704
              local.get 8
              i64.const 0
              i64.store offset=696
              local.get 8
              i64.const 33554432
              i64.store32 offset=712
              call $ethereum.getGasLeft
              local.get 8
              i32.const 696
              i32.add
              local.get 7
              i32.const 64
              call $ethereum.callStatic
              drop
              local.get 8
              i32.const 664
              i32.add
              i32.const 0
              i32.const 32
              call $ethereum.returnDataCopy
              local.get 8
              i32.const 552
              i32.add
              local.get 8
              i64.load offset=664
              local.get 8
              i32.const 664
              i32.add
              i32.const 8
              i32.add
              local.tee 14
              i64.load
              local.get 8
              i32.const 664
              i32.add
              i32.const 16
              i32.add
              local.tee 15
              i64.load
              local.get 8
              i32.const 664
              i32.add
              i32.const 24
              i32.add
              local.tee 16
              i64.load
              call $solidity.bswapi256
              local.get 8
              i32.const 552
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 17
              local.get 8
              i32.const 552
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 18
              local.get 8
              i32.const 552
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 19
              local.get 8
              i64.load offset=552
              local.set 20
              local.get 9
              i32.const -32
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 7
              call $ethereum.getCaller
              local.get 8
              i32.const 520
              i32.add
              i64.const 0
              local.get 7
              i64.load
              local.tee 10
              i64.const 32
              i64.shl
              local.get 10
              i64.const 32
              i64.shr_u
              local.get 7
              i32.const 8
              i32.add
              i64.load
              local.tee 10
              i64.const 32
              i64.shl
              i64.or
              local.get 7
              i32.const 16
              i32.add
              i64.load32_u
              i64.const 32
              i64.shl
              local.get 10
              i64.const 32
              i64.shr_u
              i64.or
              call $solidity.bswapi256
              local.get 8
              i32.const 488
              i32.add
              local.get 8
              i64.load offset=520
              local.get 8
              i32.const 520
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.get 8
              i32.const 520
              i32.add
              i32.const 16
              i32.add
              i64.load32_u
              i64.const 0
              call $solidity.bswapi256
              local.get 8
              i32.const 488
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 10
              local.get 8
              i32.const 488
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 11
              local.get 8
              i32.const 488
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 12
              local.get 8
              i64.load offset=488
              local.set 13
              local.get 9
              i32.const -64
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 7
              i32.const 56
              i32.add
              i64.const 216172782113783808
              i64.store
              local.get 7
              i32.const 48
              i32.add
              i64.const 0
              i64.store
              local.get 7
              i32.const 40
              i32.add
              i64.const 0
              i64.store
              local.get 7
              i64.const 0
              i64.store offset=32
              local.get 7
              i32.const 24
              i32.add
              local.get 12
              i64.store
              local.get 7
              local.get 11
              i64.store offset=16
              local.get 7
              local.get 10
              i64.store offset=8
              local.get 7
              local.get 13
              i64.store
              local.get 8
              i64.const 0
              i64.store offset=704
              local.get 8
              i64.const 0
              i64.store offset=696
              local.get 8
              i64.const 33554432
              i64.store32 offset=712
              call $ethereum.getGasLeft
              local.get 8
              i32.const 696
              i32.add
              local.get 7
              i32.const 64
              call $ethereum.callStatic
              drop
              local.get 8
              i32.const 664
              i32.add
              i32.const 0
              i32.const 32
              call $ethereum.returnDataCopy
              local.get 8
              i32.const 456
              i32.add
              local.get 8
              i64.load offset=664
              local.get 14
              i64.load
              local.get 15
              i64.load
              local.get 16
              i64.load
              call $solidity.bswapi256
              local.get 8
              i32.const 424
              i32.add
              local.get 8
              i64.load offset=456
              local.get 8
              i32.const 456
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.get 8
              i32.const 456
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.get 8
              i32.const 456
              i32.add
              i32.const 24
              i32.add
              i64.load
              call $solidity.bswapi256
              local.get 8
              i32.const 424
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 10
              local.get 8
              i32.const 424
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 11
              local.get 8
              i32.const 424
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 12
              local.get 8
              i64.load offset=424
              local.set 13
              local.get 9
              i32.const -32
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 9
              i32.const -32
              i32.add
              local.tee 9
              local.tee 15
              global.set 0
              local.get 7
              i32.const 24
              i32.add
              local.get 12
              i64.store
              local.get 7
              local.get 11
              i64.store offset=16
              local.get 7
              local.get 10
              i64.store offset=8
              local.get 7
              local.get 13
              i64.store
              local.get 7
              local.get 9
              call $ethereum.storageLoad
              local.get 8
              i32.const 392
              i32.add
              local.get 9
              i64.load
              local.get 9
              i32.const 8
              i32.add
              i64.load
              local.get 9
              i32.const 16
              i32.add
              i64.load
              local.get 9
              i32.const 24
              i32.add
              i64.load
              call $solidity.bswapi256
              local.get 8
              i32.const 392
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 10
              local.get 8
              i32.const 392
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 11
              local.get 8
              i32.const 392
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 12
              local.get 8
              i64.load offset=392
              local.set 13
              local.get 8
              i32.const 664
              i32.add
              call $ethereum.getCallValue
              local.get 8
              i64.load offset=664
              local.get 14
              i64.load
              i64.or
              i64.const 0
              i64.ne
              br_if 1 (;@4;)
              local.get 13
              local.get 3
              i64.lt_u
              local.tee 7
              local.get 12
              local.get 4
              i64.lt_u
              local.get 12
              local.get 4
              i64.eq
              select
              local.tee 9
              local.get 11
              local.get 5
              i64.lt_u
              local.tee 14
              local.get 10
              local.get 6
              i64.lt_u
              local.get 10
              local.get 6
              i64.eq
              select
              local.get 11
              local.get 5
              i64.xor
              local.get 10
              local.get 6
              i64.xor
              i64.or
              i64.eqz
              select
              br_if 2 (;@3;)
              local.get 8
              i32.const 360
              i32.add
              local.get 20
              local.get 19
              local.get 18
              local.get 17
              call $solidity.bswapi256
              local.get 8
              i32.const 360
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 17
              local.get 8
              i32.const 360
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 18
              local.get 8
              i32.const 360
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 19
              local.get 8
              i64.load offset=360
              local.set 20
              local.get 8
              i32.const 328
              i32.add
              local.get 13
              local.get 3
              i64.sub
              local.get 12
              local.get 4
              i64.sub
              local.get 7
              i64.extend_i32_u
              i64.sub
              local.get 11
              local.get 5
              i64.sub
              local.tee 11
              local.get 9
              i64.extend_i32_u
              local.tee 12
              i64.sub
              local.get 10
              local.get 6
              i64.sub
              local.get 14
              i64.extend_i32_u
              i64.sub
              local.get 11
              local.get 12
              i64.lt_u
              i64.extend_i32_u
              i64.sub
              call $solidity.bswapi256
              local.get 8
              i32.const 328
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 10
              local.get 8
              i32.const 328
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 11
              local.get 8
              i32.const 328
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 12
              local.get 8
              i64.load offset=328
              local.set 13
              local.get 15
              i32.const -32
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 9
              i32.const -32
              i32.add
              local.tee 9
              local.tee 14
              global.set 0
              local.get 9
              i32.const 24
              i32.add
              local.get 12
              i64.store
              local.get 9
              local.get 11
              i64.store offset=16
              local.get 9
              local.get 10
              i64.store offset=8
              local.get 9
              local.get 13
              i64.store
              local.get 7
              i32.const 24
              i32.add
              local.get 19
              i64.store
              local.get 7
              local.get 18
              i64.store offset=16
              local.get 7
              local.get 17
              i64.store offset=8
              local.get 7
              local.get 20
              i64.store
              local.get 7
              local.get 9
              call $ethereum.storageStore
              local.get 8
              i32.const 296
              i32.add
              local.get 0
              local.get 1
              local.get 2
              i64.const 4294967295
              i64.and
              i64.const 0
              call $solidity.bswapi256
              local.get 8
              i32.const 296
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 12
              local.get 8
              i32.const 296
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 13
              local.get 8
              i32.const 296
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 0
              local.get 8
              i64.load offset=296
              local.set 1
              local.get 14
              i32.const -64
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 7
              i32.const 56
              i32.add
              i64.const 216172782113783808
              i64.store
              local.get 7
              i32.const 48
              i32.add
              i64.const 0
              i64.store
              local.get 7
              i32.const 40
              i32.add
              i64.const 0
              i64.store
              local.get 7
              i64.const 0
              i64.store offset=32
              local.get 7
              i32.const 24
              i32.add
              local.get 0
              i64.store
              local.get 7
              local.get 13
              i64.store offset=16
              local.get 7
              local.get 12
              i64.store offset=8
              local.get 7
              local.get 1
              i64.store
              local.get 8
              i64.const 0
              i64.store offset=704
              local.get 8
              i64.const 0
              i64.store offset=696
              local.get 8
              i64.const 33554432
              i64.store32 offset=712
              call $ethereum.getGasLeft
              local.get 8
              i32.const 696
              i32.add
              local.get 7
              i32.const 64
              call $ethereum.callStatic
              drop
              local.get 8
              i32.const 664
              i32.add
              i32.const 0
              i32.const 32
              call $ethereum.returnDataCopy
              local.get 8
              i32.const 264
              i32.add
              local.get 8
              i64.load offset=664
              local.get 8
              i32.const 664
              i32.add
              i32.const 8
              i32.add
              local.tee 14
              i64.load
              local.get 8
              i32.const 664
              i32.add
              i32.const 16
              i32.add
              local.tee 15
              i64.load
              local.get 8
              i32.const 664
              i32.add
              i32.const 24
              i32.add
              local.tee 16
              i64.load
              call $solidity.bswapi256
              local.get 8
              i32.const 264
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 19
              local.get 8
              i32.const 264
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 20
              local.get 8
              i32.const 264
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 21
              local.get 8
              i64.load offset=264
              local.set 22
              local.get 9
              i32.const -64
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 7
              i32.const 56
              i32.add
              i64.const 216172782113783808
              i64.store
              local.get 7
              i32.const 48
              i32.add
              i64.const 0
              i64.store
              local.get 7
              i32.const 40
              i32.add
              i64.const 0
              i64.store
              local.get 7
              i64.const 0
              i64.store offset=32
              local.get 7
              i32.const 24
              i32.add
              local.get 0
              i64.store
              local.get 7
              local.get 13
              i64.store offset=16
              local.get 7
              local.get 12
              i64.store offset=8
              local.get 7
              local.get 1
              i64.store
              local.get 8
              i64.const 0
              i64.store offset=704
              local.get 8
              i64.const 0
              i64.store offset=696
              local.get 8
              i64.const 33554432
              i64.store32 offset=712
              call $ethereum.getGasLeft
              local.get 8
              i32.const 696
              i32.add
              local.get 7
              i32.const 64
              call $ethereum.callStatic
              drop
              local.get 8
              i32.const 664
              i32.add
              i32.const 0
              i32.const 32
              call $ethereum.returnDataCopy
              local.get 8
              i32.const 232
              i32.add
              local.get 8
              i64.load offset=664
              local.get 14
              i64.load
              local.get 15
              i64.load
              local.get 16
              i64.load
              call $solidity.bswapi256
              local.get 8
              i32.const 200
              i32.add
              local.get 8
              i64.load offset=232
              local.get 8
              i32.const 232
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.get 8
              i32.const 232
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.get 8
              i32.const 232
              i32.add
              i32.const 24
              i32.add
              i64.load
              call $solidity.bswapi256
              local.get 8
              i32.const 200
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 10
              local.get 8
              i32.const 200
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 11
              local.get 8
              i32.const 200
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 2
              local.get 8
              i64.load offset=200
              local.set 17
              local.get 9
              i32.const -32
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 9
              i32.const -32
              i32.add
              local.tee 9
              local.tee 15
              global.set 0
              local.get 7
              i32.const 24
              i32.add
              local.get 2
              i64.store
              local.get 7
              local.get 11
              i64.store offset=16
              local.get 7
              local.get 10
              i64.store offset=8
              local.get 7
              local.get 17
              i64.store
              local.get 7
              local.get 9
              call $ethereum.storageLoad
              local.get 8
              i32.const 168
              i32.add
              local.get 9
              i64.load
              local.get 9
              i32.const 8
              i32.add
              i64.load
              local.get 9
              i32.const 16
              i32.add
              i64.load
              local.get 9
              i32.const 24
              i32.add
              i64.load
              call $solidity.bswapi256
              local.get 8
              i32.const 168
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 10
              local.get 8
              i32.const 168
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 11
              local.get 8
              i32.const 168
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 2
              local.get 8
              i64.load offset=168
              local.set 17
              local.get 8
              i32.const 664
              i32.add
              call $ethereum.getCallValue
              local.get 8
              i64.load offset=664
              local.get 14
              i64.load
              i64.or
              i64.const 0
              i64.ne
              br_if 3 (;@2;)
              local.get 17
              local.get 3
              i64.add
              local.tee 23
              local.get 17
              i64.lt_u
              local.tee 7
              local.get 2
              local.get 4
              i64.add
              local.get 7
              i64.extend_i32_u
              i64.add
              local.tee 18
              local.get 2
              i64.lt_u
              local.get 18
              local.get 2
              i64.eq
              select
              local.tee 7
              local.get 11
              local.get 5
              i64.add
              local.tee 17
              local.get 7
              i64.extend_i32_u
              i64.add
              local.tee 2
              local.get 11
              i64.lt_u
              local.get 10
              local.get 6
              i64.add
              local.get 17
              local.get 11
              i64.lt_u
              i64.extend_i32_u
              i64.add
              local.get 2
              local.get 17
              i64.lt_u
              i64.extend_i32_u
              i64.add
              local.tee 17
              local.get 10
              i64.lt_u
              local.get 17
              local.get 10
              i64.eq
              select
              local.get 2
              local.get 11
              i64.xor
              local.get 17
              local.get 10
              i64.xor
              i64.or
              i64.eqz
              select
              br_if 4 (;@1;)
              local.get 8
              i32.const 136
              i32.add
              local.get 22
              local.get 21
              local.get 20
              local.get 19
              call $solidity.bswapi256
              local.get 8
              i32.const 136
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 10
              local.get 8
              i32.const 136
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 11
              local.get 8
              i32.const 136
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 19
              local.get 8
              i64.load offset=136
              local.set 20
              local.get 8
              i32.const 104
              i32.add
              local.get 23
              local.get 18
              local.get 2
              local.get 17
              call $solidity.bswapi256
              local.get 8
              i32.const 104
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 2
              local.get 8
              i32.const 104
              i32.add
              i32.const 16
              i32.add
              i64.load
              local.set 17
              local.get 8
              i32.const 104
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 18
              local.get 8
              i64.load offset=104
              local.set 21
              local.get 15
              i32.const -32
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 9
              i32.const -32
              i32.add
              local.tee 9
              local.tee 14
              global.set 0
              local.get 9
              i32.const 24
              i32.add
              local.get 18
              i64.store
              local.get 9
              local.get 17
              i64.store offset=16
              local.get 9
              local.get 2
              i64.store offset=8
              local.get 9
              local.get 21
              i64.store
              local.get 7
              i32.const 24
              i32.add
              local.get 19
              i64.store
              local.get 7
              local.get 11
              i64.store offset=16
              local.get 7
              local.get 10
              i64.store offset=8
              local.get 7
              local.get 20
              i64.store
              local.get 7
              local.get 9
              call $ethereum.storageStore
              local.get 14
              i32.const -32
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 7
              call $ethereum.getCaller
              local.get 8
              i32.const 72
              i32.add
              i64.const 0
              local.get 7
              i64.load
              local.tee 10
              i64.const 32
              i64.shl
              local.get 10
              i64.const 32
              i64.shr_u
              local.get 7
              i32.const 8
              i32.add
              i64.load
              local.tee 10
              i64.const 32
              i64.shl
              i64.or
              local.get 7
              i32.const 16
              i32.add
              i64.load32_u
              i64.const 32
              i64.shl
              local.get 10
              i64.const 32
              i64.shr_u
              i64.or
              call $solidity.bswapi256
              local.get 8
              i32.const 72
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 10
              local.get 8
              i32.const 72
              i32.add
              i32.const 16
              i32.add
              i64.load32_u
              local.set 11
              local.get 8
              i64.load offset=72
              local.set 2
              local.get 9
              i32.const -32
              i32.add
              local.tee 7
              local.tee 9
              global.set 0
              local.get 8
              i32.const 40
              i32.add
              local.get 2
              local.get 10
              local.get 11
              i64.const 0
              call $solidity.bswapi256
              local.get 8
              i32.const 40
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 10
              local.get 8
              i32.const 40
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 11
              local.get 8
              i64.load offset=40
              local.set 2
              local.get 7
              local.get 8
              i32.const 40
              i32.add
              i32.const 16
              i32.add
              i64.load
              i64.store offset=16
              local.get 7
              i32.const 24
              i32.add
              local.get 11
              i64.store
              local.get 7
              local.get 2
              i64.store
              local.get 7
              local.get 10
              i64.store offset=8
              local.get 9
              i32.const -32
              i32.add
              local.tee 9
              local.tee 14
              global.set 0
              local.get 9
              i32.const 24
              i32.add
              local.get 0
              i64.store
              local.get 9
              local.get 13
              i64.store offset=16
              local.get 9
              local.get 12
              i64.store offset=8
              local.get 9
              local.get 1
              i64.store
              local.get 14
              i32.const -32
              i32.add
              local.tee 14
              global.set 0
              local.get 8
              i32.const 8
              i32.add
              local.get 3
              local.get 4
              local.get 5
              local.get 6
              call $solidity.bswapi256
              local.get 8
              i32.const 8
              i32.add
              i32.const 8
              i32.add
              i64.load
              local.set 6
              local.get 8
              i32.const 8
              i32.add
              i32.const 24
              i32.add
              i64.load
              local.set 4
              local.get 8
              i64.load offset=8
              local.set 5
              local.get 14
              local.get 8
              i32.const 8
              i32.add
              i32.const 16
              i32.add
              i64.load
              i64.store offset=16
              local.get 14
              i32.const 24
              i32.add
              local.get 4
              i64.store
              local.get 14
              local.get 5
              i64.store
              local.get 14
              local.get 6
              i64.store offset=8
              local.get 14
              i32.const 32
              i32.const 4
              i32.const 1024
              local.get 7
              local.get 9
              i32.const 0
              call $ethereum.log
              local.get 8
              i32.const 720
              i32.add
              global.set 0
              return
            end
            i32.const 1085
            i32.const 23
            call $ethereum.revert
            unreachable
          end
          i32.const 1085
          i32.const 23
          call $ethereum.revert
          unreachable
        end
        i32.const 1055
        i32.const 30
        call $ethereum.revert
        unreachable
      end
      i32.const 1085
      i32.const 23
      call $ethereum.revert
      unreachable
    end
    i32.const 1028
    i32.const 27
    call $ethereum.revert
    unreachable)
  (func $main (type 10)
    (local i32 i32 i32 i64 i64 i64 i64)
    global.get 0
    i32.const 160
    i32.sub
    local.tee 0
    local.set 1
    local.get 0
    global.set 0
    block  ;; label = @1
      block  ;; label = @2
        call $ethereum.getCallDataSize
        i32.const 3
        i32.le_u
        br_if 0 (;@2;)
        local.get 0
        i32.const -16
        i32.add
        local.tee 0
        local.tee 2
        global.set 0
        local.get 0
        i32.const 0
        i32.const 4
        call $ethereum.callDataCopy
        block  ;; label = @3
          local.get 0
          i32.load
          local.tee 0
          i32.const -1147402839
          i32.eq
          br_if 0 (;@3;)
          local.get 0
          i32.const 830644336
          i32.ne
          br_if 1 (;@2;)
          local.get 2
          i32.const -32
          i32.add
          local.tee 0
          local.tee 2
          global.set 0
          local.get 0
          i32.const 4
          i32.const 32
          call $ethereum.callDataCopy
          local.get 1
          i32.const 64
          i32.add
          local.get 0
          i64.load
          local.get 0
          i32.const 8
          i32.add
          i64.load
          local.get 0
          i32.const 16
          i32.add
          i64.load
          local.get 0
          i32.const 24
          i32.add
          i64.load
          call $solidity.bswapi256
          local.get 1
          i32.const 32
          i32.add
          local.get 1
          i64.load offset=64
          local.get 1
          i32.const 64
          i32.add
          i32.const 8
          i32.add
          i64.load
          local.get 1
          i32.const 64
          i32.add
          i32.const 16
          i32.add
          i64.load32_u
          call $balanceOf.address
          local.get 1
          local.get 1
          i64.load offset=32
          local.get 1
          i32.const 32
          i32.add
          i32.const 8
          i32.add
          i64.load
          local.get 1
          i32.const 32
          i32.add
          i32.const 16
          i32.add
          i64.load
          local.get 1
          i32.const 32
          i32.add
          i32.const 24
          i32.add
          i64.load
          call $solidity.bswapi256
          local.get 1
          i32.const 8
          i32.add
          i64.load
          local.set 3
          local.get 1
          i32.const 16
          i32.add
          i64.load
          local.set 4
          local.get 1
          i32.const 24
          i32.add
          i64.load
          local.set 5
          local.get 1
          i64.load
          local.set 6
          local.get 2
          i32.const -32
          i32.add
          local.tee 0
          global.set 0
          local.get 0
          i32.const 24
          i32.add
          local.get 5
          i64.store
          local.get 0
          local.get 4
          i64.store offset=16
          local.get 0
          local.get 3
          i64.store offset=8
          local.get 0
          local.get 6
          i64.store
          local.get 0
          i32.const 32
          call $ethereum.finish
          br 2 (;@1;)
        end
        local.get 2
        i32.const -64
        i32.add
        local.tee 0
        local.tee 2
        global.set 0
        local.get 0
        i32.const 4
        i32.const 64
        call $ethereum.callDataCopy
        local.get 1
        i32.const 128
        i32.add
        local.get 0
        i64.load
        local.get 0
        i32.const 8
        i32.add
        i64.load
        local.get 0
        i32.const 16
        i32.add
        i64.load
        local.get 0
        i32.const 24
        i32.add
        i64.load
        call $solidity.bswapi256
        local.get 1
        i32.const 96
        i32.add
        local.get 0
        i64.load offset=32
        local.get 0
        i32.const 40
        i32.add
        i64.load
        local.get 0
        i32.const 48
        i32.add
        i64.load
        local.get 0
        i32.const 56
        i32.add
        i64.load
        call $solidity.bswapi256
        local.get 1
        i64.load offset=128
        local.get 1
        i32.const 128
        i32.add
        i32.const 8
        i32.add
        i64.load
        local.get 1
        i32.const 128
        i32.add
        i32.const 16
        i32.add
        i64.load32_u
        local.get 1
        i64.load offset=96
        local.get 1
        i32.const 96
        i32.add
        i32.const 8
        i32.add
        i64.load
        local.get 1
        i32.const 96
        i32.add
        i32.const 16
        i32.add
        i64.load
        local.get 1
        i32.const 96
        i32.add
        i32.const 24
        i32.add
        i64.load
        call $transfer.address.uint256
        local.get 2
        i32.const -32
        i32.add
        local.tee 0
        global.set 0
        local.get 0
        i32.const 24
        i32.add
        i64.const 72057594037927936
        i64.store
        local.get 0
        i64.const 0
        i64.store offset=16
        local.get 0
        i64.const 0
        i64.store offset=8
        local.get 0
        i64.const 0
        i64.store
        local.get 0
        i32.const 32
        call $ethereum.finish
        br 1 (;@1;)
      end
      i32.const 0
      i32.const 0
      call $ethereum.finish
    end
    local.get 1
    i32.const 160
    i32.add
    global.set 0)
  (table (;0;) 1 1 funcref)
  (memory (;0;) 2)
  (global (;0;) (mut i32) (i32.const 66656))
  (export "memory" (memory 0))
  (export "main" (func $main))
  (data (;0;) (i32.const 1024) "\dd\f2R\adSafeMath: addition overflowSafeMath: subtraction overflowFunction is not payable"))
