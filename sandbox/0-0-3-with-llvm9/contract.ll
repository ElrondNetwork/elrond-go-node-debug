; ModuleID = '/home/andrei/Desktop/workspaces/sampleforide/erc-sol-llvm9/contract.sol'
source_filename = "/home/andrei/Desktop/workspaces/sampleforide/erc-sol-llvm9/contract.sol"
target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32-unknown-unknown-wasm"

%bytes = type { i256, i8* }

@totalSupply = internal local_unnamed_addr constant i256 0, align 256
@name = internal local_unnamed_addr constant i256 1, align 256
@symbol = internal local_unnamed_addr constant i256 2, align 256
@balances = internal local_unnamed_addr constant i256 3, align 256
@solidity.event.Transfer.address.address.uint256 = internal local_unnamed_addr constant i32 -1387072803, align 1
@0 = private unnamed_addr constant [23 x i8] c"Function is not payable", align 1
@1 = private unnamed_addr constant [27 x i8] c"SafeMath: addition overflow", align 1
@2 = private unnamed_addr constant [23 x i8] c"Function is not payable", align 1
@3 = private unnamed_addr constant [30 x i8] c"SafeMath: subtraction overflow", align 1
@4 = private unnamed_addr constant [23 x i8] c"Function is not payable", align 1
@5 = private unnamed_addr constant [23 x i8] c"Function is not payable", align 1
@6 = private unnamed_addr constant [23 x i8] c"Function is not payable", align 1
@7 = private unnamed_addr constant [14 x i8] c"ERC20TokenDemo", align 1
@8 = private unnamed_addr constant [3 x i8] c"ETD", align 1
@deploy.size = external hidden local_unnamed_addr constant i32, align 8
@deploy.data = external hidden constant i8, align 1

; Function Attrs: nounwind writeonly
declare void @ethereum.callDataCopy(i8* writeonly, i32, i32) #0

; Function Attrs: nounwind
declare i32 @ethereum.callStatic(i64, i160* readonly, i8* readonly, i32) #1

; Function Attrs: nounwind writeonly
declare void @ethereum.finish(i8* readonly, i32) #2

; Function Attrs: nounwind readonly
declare i32 @ethereum.getCallDataSize() #3

declare void @ethereum.getCallValue(i128*) #4

; Function Attrs: argmemonly nounwind
declare void @ethereum.getCaller(i160* writeonly) #5

; Function Attrs: nounwind
declare i64 @ethereum.getGasLeft() #6

; Function Attrs: nounwind
declare void @ethereum.log(i8* readonly, i32, i32, i256* readonly, i256* readonly, i256* readonly, i256* readonly) #7

; Function Attrs: nounwind
declare void @ethereum.returnDataCopy(i8* writeonly, i32, i32) #8

; Function Attrs: nounwind writeonly
declare void @ethereum.revert(i8* readonly, i32) #9

; Function Attrs: nounwind
declare void @ethereum.storageLoad(i256* readonly, i256* writeonly) #10

; Function Attrs: nounwind
declare void @ethereum.storageStore(i256* readonly, i256* readonly) #11

declare void @ethereum.getTxGasPrice(i128*) #12

declare void @ethereum.getTxOrigin(i160*) #13

declare void @ethereum.getBlockCoinbase(i160*) #14

declare void @ethereum.getBlockDifficulty(i256*) #15

declare i64 @ethereum.getBlockGasLimit() #16

declare i64 @ethereum.getBlockNumber() #17

declare i64 @ethereum.getBlockTimestamp() #18

declare i32 @ethereum.getBlockHash(i64, i256*) #19

; Function Attrs: nounwind readonly
declare void @ethereum.print32(i32) #20

; Function Attrs: nounwind
define internal i256 @solidity.bswapi256(i256) #21 {
entry:
  %1 = shl i256 %0, 248
  %2 = shl i256 %0, 232
  %3 = and i256 %2, 450546001518488004043740862689444221536008393703282834321009581329618042880
  %4 = shl i256 %0, 216
  %5 = and i256 %4, 1759945318431593765795862744880641490375032787903448571566443677068820480
  %6 = shl i256 %0, 200
  %7 = and i256 %6, 6874786400123413147640088847190005821777471827747845982681420613550080
  %8 = shl i256 %0, 184
  %9 = and i256 %8, 26854634375482082607969097059335960241318249327140023369849299271680
  %10 = shl i256 %0, 168
  %11 = and i256 %10, 104900915529226885187379285388031094692649411434140716288473825280
  %12 = shl i256 %0, 152
  %13 = and i256 %12, 409769201286042520263200333546996463643161763414612173001850880
  %14 = shl i256 %0, 136
  %15 = and i256 %14, 1600660942523603594778126302917954936106100638338328800788480
  %16 = shl i256 %0, 120
  %17 = and i256 %16, 6252581806732826542102055870773261469164455618509096878080
  %18 = shl i256 %0, 104
  %19 = and i256 %18, 24424147682550103680086155745208052613923654759801159680
  %20 = shl i256 %0, 88
  %21 = and i256 %20, 95406826884961342500336545879718955523139276405473280
  %22 = shl i256 %0, 72
  %23 = and i256 %22, 372682917519380244141939632342652170012262798458880
  %24 = shl i256 %0, 56
  %25 = and i256 %24, 1455792646560079078679451688838485039110401556480
  %26 = shl i256 %0, 40
  %27 = and i256 %26, 5686690025625308901091608159525332184025006080
  %28 = shl i256 %0, 24
  %29 = and i256 %28, 22213632912598862894889094373145828843847680
  %30 = shl i256 %0, 8
  %31 = and i256 %30, 86772003564839308183160524895100893921280
  %32 = lshr i256 %0, 8
  %33 = and i256 %32, 338953138925153547590470800371487866880
  %34 = lshr i256 %0, 24
  %35 = and i256 %34, 1324035698926381045275276563951124480
  %36 = lshr i256 %0, 40
  %37 = and i256 %36, 5172014448931175958106549077934080
  %38 = lshr i256 %0, 56
  %39 = and i256 %38, 20203181441137406086353707335680
  %40 = lshr i256 %0, 72
  %41 = and i256 %40, 78918677504442992524819169280
  %42 = lshr i256 %0, 88
  %43 = and i256 %42, 308276084001730439550074880
  %44 = lshr i256 %0, 104
  %45 = and i256 %44, 1204203453131759529492480
  %46 = lshr i256 %0, 120
  %47 = and i256 %46, 4703919738795935662080
  %48 = lshr i256 %0, 136
  %49 = and i256 %48, 18374686479671623680
  %50 = lshr i256 %0, 152
  %51 = and i256 %50, 71776119061217280
  %52 = lshr i256 %0, 168
  %53 = and i256 %52, 280375465082880
  %54 = lshr i256 %0, 184
  %55 = and i256 %54, 1095216660480
  %56 = lshr i256 %0, 200
  %57 = and i256 %56, 4278190080
  %58 = lshr i256 %0, 216
  %59 = and i256 %58, 16711680
  %60 = lshr i256 %0, 232
  %61 = and i256 %60, 65280
  %62 = lshr i256 %0, 248
  %63 = or i256 %1, %3
  %64 = or i256 %63, %5
  %65 = or i256 %64, %7
  %66 = or i256 %65, %9
  %67 = or i256 %66, %11
  %68 = or i256 %67, %13
  %69 = or i256 %68, %15
  %70 = or i256 %69, %17
  %71 = or i256 %70, %19
  %72 = or i256 %71, %21
  %73 = or i256 %72, %23
  %74 = or i256 %73, %25
  %75 = or i256 %74, %27
  %76 = or i256 %75, %29
  %77 = or i256 %76, %31
  %78 = or i256 %77, %33
  %79 = or i256 %78, %35
  %80 = or i256 %79, %37
  %81 = or i256 %80, %39
  %82 = or i256 %81, %41
  %83 = or i256 %82, %43
  %84 = or i256 %83, %45
  %85 = or i256 %84, %47
  %86 = or i256 %85, %49
  %87 = or i256 %86, %51
  %88 = or i256 %87, %53
  %89 = or i256 %88, %55
  %90 = or i256 %89, %57
  %91 = or i256 %90, %59
  %92 = or i256 %91, %61
  %93 = or i256 %92, %62
  ret i256 %93
}

; Function Attrs: nounwind
define internal i8* @solidity.memcpy(i8* %dst, i8* %src, i32 %length) #21 {
entry:
  %0 = icmp ne i32 %length, 0
  br i1 %0, label %loop, label %return

loop:                                             ; preds = %loop, %entry
  %1 = phi i8* [ %src, %entry ], [ %5, %loop ]
  %2 = phi i8* [ %dst, %entry ], [ %6, %loop ]
  %3 = phi i32 [ %length, %entry ], [ %7, %loop ]
  %4 = load i8, i8* %1
  store i8 %4, i8* %2
  %5 = getelementptr inbounds i8, i8* %1, i32 1
  %6 = getelementptr inbounds i8, i8* %2, i32 1
  %7 = sub i32 %3, 1
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %loop, label %return

return:                                           ; preds = %loop, %entry
  ret i8* %dst
}

; Function Attrs: nounwind
define internal i256 @solidity.keccak256(%bytes %memory) #21 {
entry:
  %0 = extractvalue %bytes %memory, 0
  %length = trunc i256 %0 to i32
  %ptr = extractvalue %bytes %memory, 1
  %address.ptr = alloca i160
  store i160 51380916937414555718098294900181824909778878464, i160* %address.ptr
  %1 = call i64 @ethereum.getGasLeft()
  %2 = call i32 @ethereum.callStatic(i64 %1, i160* %address.ptr, i8* %ptr, i32 %length)
  %result.ptr = alloca i256
  %result.vptr = bitcast i256* %result.ptr to i8*
  call void @ethereum.returnDataCopy(i8* %result.vptr, i32 0, i32 32)
  %3 = load i256, i256* %result.ptr
  %reverse = call i256 @solidity.bswapi256(i256 %3)
  ret i256 %reverse
}

; Function Attrs: nounwind
define internal i256 @solidity.sha256(%bytes %memory) #21 {
entry:
  %0 = extractvalue %bytes %memory, 0
  %length = trunc i256 %0 to i32
  %ptr = extractvalue %bytes %memory, 1
  %address.ptr = alloca i160
  store i160 11417981541647679048466287755595961091061972992, i160* %address.ptr
  %1 = call i64 @ethereum.getGasLeft()
  %2 = call i32 @ethereum.callStatic(i64 %1, i160* %address.ptr, i8* %ptr, i32 %length)
  %result.ptr = alloca i256
  %result.vptr = bitcast i256* %result.ptr to i8*
  call void @ethereum.returnDataCopy(i8* %result.vptr, i32 0, i32 32)
  %3 = load i256, i256* %result.ptr
  %reverse = call i256 @solidity.bswapi256(i256 %3)
  ret i256 %reverse
}

define internal i256 @add.uint256.uint256(i256 %a, i256 %b) {
entry:
  %0 = alloca i128
  call void @ethereum.getCallValue(i128* %0)
  %1 = load i128, i128* %0
  %2 = icmp ne i128 %1, 0
  br i1 %2, label %revert, label %continue

return:                                           ; preds = %return.after, %continue1
  %3 = load i256, i256* %retval
  ret i256 %3

continue:                                         ; preds = %entry
  %a.addr = alloca i256
  store i256 %a, i256* %a.addr
  %b.addr = alloca i256
  store i256 %b, i256* %b.addr
  %retval = alloca i256
  %c.addr = alloca i256
  %4 = load i256, i256* %a.addr
  %5 = load i256, i256* %b.addr
  %BO_ADD = add i256 %4, %5
  store i256 %BO_ADD, i256* %c.addr
  %6 = load i256, i256* %c.addr
  %7 = load i256, i256* %a.addr
  %BO_GE = icmp uge i256 %6, %7
  br i1 %BO_GE, label %continue1, label %revert2

revert:                                           ; preds = %entry
  call void @ethereum.revert(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @0, i32 0, i32 0), i32 23)
  unreachable

continue1:                                        ; preds = %continue
  %8 = load i256, i256* %c.addr
  store i256 %8, i256* %retval
  br label %return

revert2:                                          ; preds = %continue
  call void @ethereum.revert(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @1, i32 0, i32 0), i32 27)
  unreachable

return.after:                                     ; No predecessors!
  br label %return
}

define internal i256 @sub.uint256.uint256(i256 %a, i256 %b) {
entry:
  %0 = alloca i128
  call void @ethereum.getCallValue(i128* %0)
  %1 = load i128, i128* %0
  %2 = icmp ne i128 %1, 0
  br i1 %2, label %revert, label %continue

return:                                           ; preds = %return.after, %continue1
  %3 = load i256, i256* %retval
  ret i256 %3

continue:                                         ; preds = %entry
  %a.addr = alloca i256
  store i256 %a, i256* %a.addr
  %b.addr = alloca i256
  store i256 %b, i256* %b.addr
  %retval = alloca i256
  %4 = load i256, i256* %b.addr
  %5 = load i256, i256* %a.addr
  %BO_LE = icmp ule i256 %4, %5
  br i1 %BO_LE, label %continue1, label %revert2

revert:                                           ; preds = %entry
  call void @ethereum.revert(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @2, i32 0, i32 0), i32 23)
  unreachable

continue1:                                        ; preds = %continue
  %c.addr = alloca i256
  %6 = load i256, i256* %a.addr
  %7 = load i256, i256* %b.addr
  %BO_SUB = sub i256 %6, %7
  store i256 %BO_SUB, i256* %c.addr
  %8 = load i256, i256* %c.addr
  store i256 %8, i256* %retval
  br label %return

revert2:                                          ; preds = %continue
  call void @ethereum.revert(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @3, i32 0, i32 0), i32 30)
  unreachable

return.after:                                     ; No predecessors!
  br label %return
}

define internal i256 @balanceOf.address(i160 %account) {
entry:
  %0 = alloca i128
  call void @ethereum.getCallValue(i128* %0)
  %1 = load i128, i128* %0
  %2 = icmp ne i128 %1, 0
  br i1 %2, label %revert, label %continue

return:                                           ; preds = %return.after, %continue
  %3 = load i256, i256* %retval
  ret i256 %3

continue:                                         ; preds = %entry
  %account.addr = alloca i160
  store i160 %account, i160* %account.addr
  %retval = alloca i256
  %4 = load i160, i160* %account.addr
  %5 = load i256, i256* @balances
  %6 = zext i160 %4 to i256
  %reverse = call i256 @solidity.bswapi256(i256 %6)
  %reverse1 = call i256 @solidity.bswapi256(i256 %5)
  %concat = alloca i256, i32 2
  %7 = getelementptr inbounds i256, i256* %concat, i32 0
  store i256 %reverse, i256* %7
  %8 = getelementptr inbounds i256, i256* %concat, i32 1
  store i256 %reverse1, i256* %8
  %9 = bitcast i256* %concat to i8*
  %10 = insertvalue %bytes { i256 64, i8* null }, i8* %9, 1
  %11 = alloca i256
  %12 = call i256 @solidity.sha256(%bytes %10)
  store i256 %12, i256* %11
  %13 = load i256, i256* %11
  %reverse2 = call i256 @solidity.bswapi256(i256 %13)
  %14 = alloca i256
  %15 = alloca i256
  store i256 %reverse2, i256* %14
  call void @ethereum.storageLoad(i256* %14, i256* %15)
  %16 = load i256, i256* %15
  %reverse3 = call i256 @solidity.bswapi256(i256 %16)
  store i256 %reverse3, i256* %retval
  br label %return

revert:                                           ; preds = %entry
  call void @ethereum.revert(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @4, i32 0, i32 0), i32 23)
  unreachable

return.after:                                     ; No predecessors!
  br label %return
}

define internal i1 @transfer.address.uint256(i160 %to, i256 %amount) {
entry:
  %0 = alloca i128
  call void @ethereum.getCallValue(i128* %0)
  %1 = load i128, i128* %0
  %2 = icmp ne i128 %1, 0
  br i1 %2, label %revert, label %continue

return:                                           ; preds = %return.after, %continue
  %3 = load i1, i1* %retval
  ret i1 %3

continue:                                         ; preds = %entry
  %to.addr = alloca i160
  store i160 %to, i160* %to.addr
  %amount.addr = alloca i256
  store i256 %amount, i256* %amount.addr
  %retval = alloca i1
  %4 = alloca i160
  call void @ethereum.getCaller(i160* %4)
  %5 = load i160, i160* %4
  %extend_256 = zext i160 %5 to i256
  %shift_left = shl i256 %extend_256, 96
  %reverse = call i256 @solidity.bswapi256(i256 %shift_left)
  %trunc = trunc i256 %reverse to i160
  %6 = load i256, i256* @balances
  %7 = zext i160 %trunc to i256
  %reverse1 = call i256 @solidity.bswapi256(i256 %7)
  %reverse2 = call i256 @solidity.bswapi256(i256 %6)
  %concat = alloca i256, i32 2
  %8 = getelementptr inbounds i256, i256* %concat, i32 0
  store i256 %reverse1, i256* %8
  %9 = getelementptr inbounds i256, i256* %concat, i32 1
  store i256 %reverse2, i256* %9
  %10 = bitcast i256* %concat to i8*
  %11 = insertvalue %bytes { i256 64, i8* null }, i8* %10, 1
  %12 = alloca i256
  %13 = call i256 @solidity.sha256(%bytes %11)
  store i256 %13, i256* %12
  %14 = alloca i160
  call void @ethereum.getCaller(i160* %14)
  %15 = load i160, i160* %14
  %extend_2563 = zext i160 %15 to i256
  %shift_left4 = shl i256 %extend_2563, 96
  %reverse5 = call i256 @solidity.bswapi256(i256 %shift_left4)
  %trunc6 = trunc i256 %reverse5 to i160
  %16 = load i256, i256* @balances
  %17 = zext i160 %trunc6 to i256
  %reverse7 = call i256 @solidity.bswapi256(i256 %17)
  %reverse8 = call i256 @solidity.bswapi256(i256 %16)
  %concat9 = alloca i256, i32 2
  %18 = getelementptr inbounds i256, i256* %concat9, i32 0
  store i256 %reverse7, i256* %18
  %19 = getelementptr inbounds i256, i256* %concat9, i32 1
  store i256 %reverse8, i256* %19
  %20 = bitcast i256* %concat9 to i8*
  %21 = insertvalue %bytes { i256 64, i8* null }, i8* %20, 1
  %22 = alloca i256
  %23 = call i256 @solidity.sha256(%bytes %21)
  store i256 %23, i256* %22
  %24 = load i256, i256* %22
  %reverse10 = call i256 @solidity.bswapi256(i256 %24)
  %25 = alloca i256
  %26 = alloca i256
  store i256 %reverse10, i256* %25
  call void @ethereum.storageLoad(i256* %25, i256* %26)
  %27 = load i256, i256* %26
  %reverse11 = call i256 @solidity.bswapi256(i256 %27)
  %28 = load i256, i256* %amount.addr
  %29 = call i256 @sub.uint256.uint256(i256 %reverse11, i256 %28)
  %30 = load i256, i256* %12
  %reverse12 = call i256 @solidity.bswapi256(i256 %30)
  %reverse13 = call i256 @solidity.bswapi256(i256 %29)
  %31 = alloca i256
  %32 = alloca i256
  store i256 %reverse12, i256* %31
  store i256 %reverse13, i256* %32
  call void @ethereum.storageStore(i256* %31, i256* %32)
  %33 = load i160, i160* %to.addr
  %34 = load i256, i256* @balances
  %35 = zext i160 %33 to i256
  %reverse14 = call i256 @solidity.bswapi256(i256 %35)
  %reverse15 = call i256 @solidity.bswapi256(i256 %34)
  %concat16 = alloca i256, i32 2
  %36 = getelementptr inbounds i256, i256* %concat16, i32 0
  store i256 %reverse14, i256* %36
  %37 = getelementptr inbounds i256, i256* %concat16, i32 1
  store i256 %reverse15, i256* %37
  %38 = bitcast i256* %concat16 to i8*
  %39 = insertvalue %bytes { i256 64, i8* null }, i8* %38, 1
  %40 = alloca i256
  %41 = call i256 @solidity.sha256(%bytes %39)
  store i256 %41, i256* %40
  %42 = load i160, i160* %to.addr
  %43 = load i256, i256* @balances
  %44 = zext i160 %42 to i256
  %reverse17 = call i256 @solidity.bswapi256(i256 %44)
  %reverse18 = call i256 @solidity.bswapi256(i256 %43)
  %concat19 = alloca i256, i32 2
  %45 = getelementptr inbounds i256, i256* %concat19, i32 0
  store i256 %reverse17, i256* %45
  %46 = getelementptr inbounds i256, i256* %concat19, i32 1
  store i256 %reverse18, i256* %46
  %47 = bitcast i256* %concat19 to i8*
  %48 = insertvalue %bytes { i256 64, i8* null }, i8* %47, 1
  %49 = alloca i256
  %50 = call i256 @solidity.sha256(%bytes %48)
  store i256 %50, i256* %49
  %51 = load i256, i256* %49
  %reverse20 = call i256 @solidity.bswapi256(i256 %51)
  %52 = alloca i256
  %53 = alloca i256
  store i256 %reverse20, i256* %52
  call void @ethereum.storageLoad(i256* %52, i256* %53)
  %54 = load i256, i256* %53
  %reverse21 = call i256 @solidity.bswapi256(i256 %54)
  %55 = load i256, i256* %amount.addr
  %56 = call i256 @add.uint256.uint256(i256 %reverse21, i256 %55)
  %57 = load i256, i256* %40
  %reverse22 = call i256 @solidity.bswapi256(i256 %57)
  %reverse23 = call i256 @solidity.bswapi256(i256 %56)
  %58 = alloca i256
  %59 = alloca i256
  store i256 %reverse22, i256* %58
  store i256 %reverse23, i256* %59
  call void @ethereum.storageStore(i256* %58, i256* %59)
  %60 = alloca i160
  call void @ethereum.getCaller(i160* %60)
  %61 = load i160, i160* %60
  %extend_25624 = zext i160 %61 to i256
  %shift_left25 = shl i256 %extend_25624, 96
  %reverse26 = call i256 @solidity.bswapi256(i256 %shift_left25)
  %trunc27 = trunc i256 %reverse26 to i160
  %62 = load i160, i160* %to.addr
  %63 = load i256, i256* %amount.addr
  %64 = alloca i256
  %65 = zext i160 %trunc27 to i256
  %reverse28 = call i256 @solidity.bswapi256(i256 %65)
  store i256 %reverse28, i256* %64
  %66 = alloca i256
  %67 = zext i160 %62 to i256
  %reverse29 = call i256 @solidity.bswapi256(i256 %67)
  store i256 %reverse29, i256* %66
  %68 = alloca i256
  %reverse30 = call i256 @solidity.bswapi256(i256 %63)
  store i256 %reverse30, i256* %68
  %69 = bitcast i256* %68 to i8*
  call void @ethereum.log(i8* %69, i32 32, i32 4, i256* bitcast (i32* @solidity.event.Transfer.address.address.uint256 to i256*), i256* %64, i256* %66, i256* null)
  store i1 true, i1* %retval
  br label %return

revert:                                           ; preds = %entry
  call void @ethereum.revert(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @5, i32 0, i32 0), i32 23)
  unreachable

return.after:                                     ; No predecessors!
  br label %return
}

define internal void @solidity.constructor() {
entry:
  %0 = alloca i128
  call void @ethereum.getCallValue(i128* %0)
  %1 = load i128, i128* %0
  %2 = icmp ne i128 %1, 0
  br i1 %2, label %revert, label %continue

return:                                           ; preds = %loop_end5
  ret void

continue:                                         ; preds = %entry
  %3 = load i256, i256* @totalSupply
  %reverse = call i256 @solidity.bswapi256(i256 %3)
  %reverse1 = call i256 @solidity.bswapi256(i256 100000000)
  %4 = alloca i256
  %5 = alloca i256
  store i256 %reverse, i256* %4
  store i256 %reverse1, i256* %5
  call void @ethereum.storageStore(i256* %4, i256* %5)
  %reverse2 = call i256 @solidity.bswapi256(i256 14)
  %6 = load i256, i256* @name
  %7 = alloca i256
  %8 = alloca i256
  store i256 %6, i256* %7
  store i256 %reverse2, i256* %8
  call void @ethereum.storageStore(i256* %7, i256* %8)
  br label %loop_init

revert:                                           ; preds = %entry
  call void @ethereum.revert(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @6, i32 0, i32 0), i32 23)
  unreachable

loop_init:                                        ; preds = %continue
  %9 = load i256, i256* @name
  %concat = alloca [32 x i8]
  %10 = getelementptr inbounds [32 x i8], [32 x i8]* %concat, i32 0, i32 0
  %11 = bitcast i8* %10 to i256*
  store i256 %9, i256* %11
  %12 = getelementptr inbounds [32 x i8], [32 x i8]* %concat, i32 0, i32 0
  %13 = insertvalue %bytes { i256 32, i8* null }, i8* %12, 1
  %14 = call i256 @solidity.keccak256(%bytes %13)
  %15 = alloca i256
  store i256 %14, i256* %15
  br label %loop

loop:                                             ; preds = %loop, %loop_init
  %16 = phi i256 [ 32, %loop_init ], [ %24, %loop ]
  %17 = phi [32 x i8]* [ bitcast ([14 x i8]* @7 to [32 x i8]*), %loop_init ], [ %27, %loop ]
  %18 = bitcast [32 x i8]* %17 to i256*
  %19 = load i256, i256* %18
  %20 = load i256, i256* %15
  %21 = alloca i256
  %22 = alloca i256
  store i256 %20, i256* %21
  store i256 %19, i256* %22
  call void @ethereum.storageStore(i256* %21, i256* %22)
  %23 = load i256, i256* %15
  %24 = sub i256 %16, 32
  %25 = add i256 %23, 32
  store i256 %25, i256* %15
  %26 = getelementptr inbounds [32 x i8], [32 x i8]* %17, i32 0, i32 32
  %27 = bitcast i8* %26 to [32 x i8]*
  %28 = icmp ne i256 %24, 0
  br i1 %28, label %loop, label %loop_end

loop_end:                                         ; preds = %loop
  %reverse6 = call i256 @solidity.bswapi256(i256 3)
  %29 = load i256, i256* @symbol
  %30 = alloca i256
  %31 = alloca i256
  store i256 %29, i256* %30
  store i256 %reverse6, i256* %31
  call void @ethereum.storageStore(i256* %30, i256* %31)
  br label %loop_init3

loop_init3:                                       ; preds = %loop_end
  %32 = load i256, i256* @symbol
  %concat7 = alloca [32 x i8]
  %33 = getelementptr inbounds [32 x i8], [32 x i8]* %concat7, i32 0, i32 0
  %34 = bitcast i8* %33 to i256*
  store i256 %32, i256* %34
  %35 = getelementptr inbounds [32 x i8], [32 x i8]* %concat7, i32 0, i32 0
  %36 = insertvalue %bytes { i256 32, i8* null }, i8* %35, 1
  %37 = call i256 @solidity.keccak256(%bytes %36)
  %38 = alloca i256
  store i256 %37, i256* %38
  br label %loop4

loop4:                                            ; preds = %loop4, %loop_init3
  %39 = phi i256 [ 32, %loop_init3 ], [ %47, %loop4 ]
  %40 = phi [32 x i8]* [ bitcast ([3 x i8]* @8 to [32 x i8]*), %loop_init3 ], [ %50, %loop4 ]
  %41 = bitcast [32 x i8]* %40 to i256*
  %42 = load i256, i256* %41
  %43 = load i256, i256* %38
  %44 = alloca i256
  %45 = alloca i256
  store i256 %43, i256* %44
  store i256 %42, i256* %45
  call void @ethereum.storageStore(i256* %44, i256* %45)
  %46 = load i256, i256* %38
  %47 = sub i256 %39, 32
  %48 = add i256 %46, 32
  store i256 %48, i256* %38
  %49 = getelementptr inbounds [32 x i8], [32 x i8]* %40, i32 0, i32 32
  %50 = bitcast i8* %49 to [32 x i8]*
  %51 = icmp ne i256 %47, 0
  br i1 %51, label %loop4, label %loop_end5

loop_end5:                                        ; preds = %loop4
  %52 = alloca i160
  call void @ethereum.getCaller(i160* %52)
  %53 = load i160, i160* %52
  %extend_256 = zext i160 %53 to i256
  %shift_left = shl i256 %extend_256, 96
  %reverse8 = call i256 @solidity.bswapi256(i256 %shift_left)
  %trunc = trunc i256 %reverse8 to i160
  %54 = load i256, i256* @balances
  %55 = zext i160 %trunc to i256
  %reverse9 = call i256 @solidity.bswapi256(i256 %55)
  %reverse10 = call i256 @solidity.bswapi256(i256 %54)
  %concat11 = alloca i256, i32 2
  %56 = getelementptr inbounds i256, i256* %concat11, i32 0
  store i256 %reverse9, i256* %56
  %57 = getelementptr inbounds i256, i256* %concat11, i32 1
  store i256 %reverse10, i256* %57
  %58 = bitcast i256* %concat11 to i8*
  %59 = insertvalue %bytes { i256 64, i8* null }, i8* %58, 1
  %60 = alloca i256
  %61 = call i256 @solidity.sha256(%bytes %59)
  store i256 %61, i256* %60
  %62 = load i256, i256* @totalSupply
  %reverse12 = call i256 @solidity.bswapi256(i256 %62)
  %63 = alloca i256
  %64 = alloca i256
  store i256 %reverse12, i256* %63
  call void @ethereum.storageLoad(i256* %63, i256* %64)
  %65 = load i256, i256* %64
  %reverse13 = call i256 @solidity.bswapi256(i256 %65)
  %66 = load i256, i256* %60
  %reverse14 = call i256 @solidity.bswapi256(i256 %66)
  %reverse15 = call i256 @solidity.bswapi256(i256 %reverse13)
  %67 = alloca i256
  %68 = alloca i256
  store i256 %reverse14, i256* %67
  store i256 %reverse15, i256* %68
  call void @ethereum.storageStore(i256* %67, i256* %68)
  br label %return
}

define internal void @solidity.fallback() {
entry:
  br label %return

return:                                           ; preds = %entry
  ret void
}

; Function Attrs: alwaysinline
define hidden void @solidity.ctor() #22 {
entry:
  call void @solidity.constructor()
  %0 = load i32, i32* @deploy.size
  call void @ethereum.finish(i8* @deploy.data, i32 %0)
  ret void
}

; Function Attrs: alwaysinline
define hidden void @solidity.main() #22 {
entry:
  %size = call i32 @ethereum.getCallDataSize()
  %cmp = icmp uge i32 %size, 4
  br i1 %cmp, label %switch, label %error

error:                                            ; preds = %switch, %entry
  call void @solidity.fallback()
  call void @ethereum.finish(i8* null, i32 0)
  ret void

switch:                                           ; preds = %entry
  %hash.vptr = alloca i8, i32 4
  call void @ethereum.callDataCopy(i8* %hash.vptr, i32 0, i32 4)
  %hash.ptr = bitcast i8* %hash.vptr to i32*
  %hash = load i32, i32* %hash.ptr
  switch i32 %hash, label %error [
    i32 830644336, label %balanceOf.address
    i32 -1147402839, label %transfer.address.uint256
  ]

balanceOf.address:                                ; preds = %switch
  %balanceOf.address.args.buf = alloca i8, i32 32
  call void @ethereum.callDataCopy(i8* %balanceOf.address.args.buf, i32 4, i32 32)
  %balanceOf.address.account.cptr = getelementptr inbounds i8, i8* %balanceOf.address.args.buf, i32 0
  %balanceOf.address.account.ptr = bitcast i8* %balanceOf.address.account.cptr to i256*
  %balanceOf.address.account.b = load i256, i256* %balanceOf.address.account.ptr
  %reverse = call i256 @solidity.bswapi256(i256 %balanceOf.address.account.b)
  %balanceOf.address.account = trunc i256 %reverse to i160
  %balanceOf.address.ret = call i256 @balanceOf.address(i160 %balanceOf.address.account)
  %reverse1 = call i256 @solidity.bswapi256(i256 %balanceOf.address.ret)
  %balanceOf.address.ret.ptr = alloca i256
  store i256 %reverse1, i256* %balanceOf.address.ret.ptr
  %balanceOf.address.ret.vptr = bitcast i256* %balanceOf.address.ret.ptr to i8*
  call void @ethereum.finish(i8* %balanceOf.address.ret.vptr, i32 32)
  ret void

transfer.address.uint256:                         ; preds = %switch
  %transfer.address.uint256.args.buf = alloca i8, i32 64
  call void @ethereum.callDataCopy(i8* %transfer.address.uint256.args.buf, i32 4, i32 64)
  %transfer.address.uint256.to.cptr = getelementptr inbounds i8, i8* %transfer.address.uint256.args.buf, i32 0
  %transfer.address.uint256.to.ptr = bitcast i8* %transfer.address.uint256.to.cptr to i256*
  %transfer.address.uint256.to.b = load i256, i256* %transfer.address.uint256.to.ptr
  %reverse2 = call i256 @solidity.bswapi256(i256 %transfer.address.uint256.to.b)
  %transfer.address.uint256.to = trunc i256 %reverse2 to i160
  %transfer.address.uint256.amount.cptr = getelementptr inbounds i8, i8* %transfer.address.uint256.args.buf, i32 32
  %transfer.address.uint256.amount.ptr = bitcast i8* %transfer.address.uint256.amount.cptr to i256*
  %transfer.address.uint256.amount.b = load i256, i256* %transfer.address.uint256.amount.ptr
  %reverse3 = call i256 @solidity.bswapi256(i256 %transfer.address.uint256.amount.b)
  %transfer.address.uint256.ret = call i1 @transfer.address.uint256(i160 %transfer.address.uint256.to, i256 %reverse3)
  %0 = zext i1 %transfer.address.uint256.ret to i256
  %reverse4 = call i256 @solidity.bswapi256(i256 %0)
  %transfer.address.uint256.ret.ptr = alloca i256
  store i256 %reverse4, i256* %transfer.address.uint256.ret.ptr
  %transfer.address.uint256.ret.vptr = bitcast i256* %transfer.address.uint256.ret.ptr to i8*
  call void @ethereum.finish(i8* %transfer.address.uint256.ret.vptr, i32 32)
  ret void
}

attributes #0 = { nounwind writeonly "wasm-import-module"="ethereum" "wasm-import-name"="callDataCopy" }
attributes #1 = { nounwind "wasm-import-module"="ethereum" "wasm-import-name"="callStatic" }
attributes #2 = { nounwind writeonly "wasm-import-module"="ethereum" "wasm-import-name"="finish" }
attributes #3 = { nounwind readonly "wasm-import-module"="ethereum" "wasm-import-name"="getCallDataSize" }
attributes #4 = { "wasm-import-module"="ethereum" "wasm-import-name"="getCallValue" }
attributes #5 = { argmemonly nounwind "wasm-import-module"="ethereum" "wasm-import-name"="getCaller" }
attributes #6 = { nounwind "wasm-import-module"="ethereum" "wasm-import-name"="getGasLeft" }
attributes #7 = { nounwind "wasm-import-module"="ethereum" "wasm-import-name"="log" }
attributes #8 = { nounwind "wasm-import-module"="ethereum" "wasm-import-name"="returnDataCopy" }
attributes #9 = { nounwind writeonly "wasm-import-module"="ethereum" "wasm-import-name"="revert" }
attributes #10 = { nounwind "wasm-import-module"="ethereum" "wasm-import-name"="storageLoad" }
attributes #11 = { nounwind "wasm-import-module"="ethereum" "wasm-import-name"="storageStore" }
attributes #12 = { "wasm-import-module"="ethereum" "wasm-import-name"="getTxGasPrice" }
attributes #13 = { "wasm-import-module"="ethereum" "wasm-import-name"="getTxOrigin" }
attributes #14 = { "wasm-import-module"="ethereum" "wasm-import-name"="getBlockCoinbase" }
attributes #15 = { "wasm-import-module"="ethereum" "wasm-import-name"="getBlockDifficulty" }
attributes #16 = { "wasm-import-module"="ethereum" "wasm-import-name"="getBlockGasLimit" }
attributes #17 = { "wasm-import-module"="ethereum" "wasm-import-name"="getBlockNumber" }
attributes #18 = { "wasm-import-module"="ethereum" "wasm-import-name"="getBlockTimestamp" }
attributes #19 = { "wasm-import-module"="ethereum" "wasm-import-name"="getBlockHash" }
attributes #20 = { nounwind readonly "wasm-import-module"="debug" "wasm-import-name"="print32" }
attributes #21 = { nounwind }
attributes #22 = { alwaysinline }
