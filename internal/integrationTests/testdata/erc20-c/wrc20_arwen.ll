; ModuleID = '/home/andrei/Desktop/workspaces/go/elrond-go-node-debug/internal/integrationTests/testdata/erc20-c/wrc20_arwen.c'
source_filename = "/home/andrei/Desktop/workspaces/go/elrond-go-node-debug/internal/integrationTests/testdata/erc20-c/wrc20_arwen.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32-unknown-unknown-wasm"

@ERR_NUM_ARGS_LEN = local_unnamed_addr constant i32 25, align 4
@ERR_NUM_ARGS = global [26 x i8] c"wrong number of arguments\00", align 16
@ERR_NOT_PAYABLE_LEN = local_unnamed_addr constant i32 54, align 4
@ERR_NOT_PAYABLE = global [55 x i8] c"attempted to transfer funds via a non-payable function\00", align 16
@sender = global [32 x i8] zeroinitializer, align 16
@recipient = global [32 x i8] zeroinitializer, align 16
@caller = global [32 x i8] zeroinitializer, align 16
@currentKey = global [32 x i8] zeroinitializer, align 16
@balanceKeyRaw = global [33 x i8] zeroinitializer, align 16
@allowanceKeyRaw = global [65 x i8] zeroinitializer, align 16
@approveEvent = global [32 x i8] c"q4i+#\0B\9E\1F\FA9\09\89\04r!4\15\96R\B0\9C[\C4\1D\88\D6i\87y\D2(\FF", align 16
@transferEvent = global [32 x i8] c"\F0\99\CD\8B\DEUx\14\84*1!\E8\DD\FDC:S\9B\8C\9F\14\BF1\EB\F1\08\D1.a\96\E9", align 16
@currentTopics = global [96 x i8] zeroinitializer, align 16
@currentLogVal = global [32 x i8] zeroinitializer, align 16
@ERR_TRANSFER_NEG_LEN = local_unnamed_addr constant i32 34, align 4
@ERR_TRANSFER_NEG = global [35 x i8] c"transfer amount cannot be negative\00", align 16
@ERR_ALLOWANCE_NEG_LEN = local_unnamed_addr constant i32 33, align 4
@ERR_ALLOWANCE_NEG = global [34 x i8] c"approve amount cannot be negative\00", align 16
@ERR_ALLOWANCE_EXCEEDED_LEN = local_unnamed_addr constant i32 18, align 4
@ERR_ALLOWANCE_EXCEEDED = global [19 x i8] c"allowance exceeded\00", align 16
@ERR_INSUFFICIENT_FUNDS_LEN = local_unnamed_addr constant i32 18, align 4
@ERR_INSUFFICIENT_FUNDS = global [19 x i8] c"insufficient funds\00", align 16
@selector = local_unnamed_addr global [1 x i32] zeroinitializer, align 4

; Function Attrs: nofree norecurse nounwind writeonly
define void @computeTotalSupplyKey(i8* nocapture %destination) local_unnamed_addr #0 {
entry:
  call void @llvm.memset.p0i8.i32(i8* align 1 %destination, i8 0, i32 32, i1 false)
  ret void
}

; Function Attrs: nounwind
define void @computeBalanceKey(i8* %destination, i8* nocapture readonly %address) local_unnamed_addr #1 {
entry:
  store i8 1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), align 16, !tbaa !2
  %0 = load i8, i8* %address, align 1, !tbaa !2
  store i8 %0, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 1), align 1, !tbaa !2
  %arrayidx.1 = getelementptr inbounds i8, i8* %address, i32 1
  %1 = load i8, i8* %arrayidx.1, align 1, !tbaa !2
  store i8 %1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 2), align 2, !tbaa !2
  %arrayidx.2 = getelementptr inbounds i8, i8* %address, i32 2
  %2 = load i8, i8* %arrayidx.2, align 1, !tbaa !2
  store i8 %2, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 3), align 1, !tbaa !2
  %arrayidx.3 = getelementptr inbounds i8, i8* %address, i32 3
  %3 = load i8, i8* %arrayidx.3, align 1, !tbaa !2
  store i8 %3, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 4), align 4, !tbaa !2
  %arrayidx.4 = getelementptr inbounds i8, i8* %address, i32 4
  %4 = load i8, i8* %arrayidx.4, align 1, !tbaa !2
  store i8 %4, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 5), align 1, !tbaa !2
  %arrayidx.5 = getelementptr inbounds i8, i8* %address, i32 5
  %5 = load i8, i8* %arrayidx.5, align 1, !tbaa !2
  store i8 %5, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 6), align 2, !tbaa !2
  %arrayidx.6 = getelementptr inbounds i8, i8* %address, i32 6
  %6 = load i8, i8* %arrayidx.6, align 1, !tbaa !2
  store i8 %6, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 7), align 1, !tbaa !2
  %arrayidx.7 = getelementptr inbounds i8, i8* %address, i32 7
  %7 = load i8, i8* %arrayidx.7, align 1, !tbaa !2
  store i8 %7, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 8), align 8, !tbaa !2
  %arrayidx.8 = getelementptr inbounds i8, i8* %address, i32 8
  %8 = load i8, i8* %arrayidx.8, align 1, !tbaa !2
  store i8 %8, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 9), align 1, !tbaa !2
  %arrayidx.9 = getelementptr inbounds i8, i8* %address, i32 9
  %9 = load i8, i8* %arrayidx.9, align 1, !tbaa !2
  store i8 %9, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 10), align 2, !tbaa !2
  %arrayidx.10 = getelementptr inbounds i8, i8* %address, i32 10
  %10 = load i8, i8* %arrayidx.10, align 1, !tbaa !2
  store i8 %10, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 11), align 1, !tbaa !2
  %arrayidx.11 = getelementptr inbounds i8, i8* %address, i32 11
  %11 = load i8, i8* %arrayidx.11, align 1, !tbaa !2
  store i8 %11, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 12), align 4, !tbaa !2
  %arrayidx.12 = getelementptr inbounds i8, i8* %address, i32 12
  %12 = load i8, i8* %arrayidx.12, align 1, !tbaa !2
  store i8 %12, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 13), align 1, !tbaa !2
  %arrayidx.13 = getelementptr inbounds i8, i8* %address, i32 13
  %13 = load i8, i8* %arrayidx.13, align 1, !tbaa !2
  store i8 %13, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 14), align 2, !tbaa !2
  %arrayidx.14 = getelementptr inbounds i8, i8* %address, i32 14
  %14 = load i8, i8* %arrayidx.14, align 1, !tbaa !2
  store i8 %14, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 15), align 1, !tbaa !2
  %arrayidx.15 = getelementptr inbounds i8, i8* %address, i32 15
  %15 = load i8, i8* %arrayidx.15, align 1, !tbaa !2
  store i8 %15, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 16), align 16, !tbaa !2
  %arrayidx.16 = getelementptr inbounds i8, i8* %address, i32 16
  %16 = load i8, i8* %arrayidx.16, align 1, !tbaa !2
  store i8 %16, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 17), align 1, !tbaa !2
  %arrayidx.17 = getelementptr inbounds i8, i8* %address, i32 17
  %17 = load i8, i8* %arrayidx.17, align 1, !tbaa !2
  store i8 %17, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 18), align 2, !tbaa !2
  %arrayidx.18 = getelementptr inbounds i8, i8* %address, i32 18
  %18 = load i8, i8* %arrayidx.18, align 1, !tbaa !2
  store i8 %18, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 19), align 1, !tbaa !2
  %arrayidx.19 = getelementptr inbounds i8, i8* %address, i32 19
  %19 = load i8, i8* %arrayidx.19, align 1, !tbaa !2
  store i8 %19, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 20), align 4, !tbaa !2
  %arrayidx.20 = getelementptr inbounds i8, i8* %address, i32 20
  %20 = load i8, i8* %arrayidx.20, align 1, !tbaa !2
  store i8 %20, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 21), align 1, !tbaa !2
  %arrayidx.21 = getelementptr inbounds i8, i8* %address, i32 21
  %21 = load i8, i8* %arrayidx.21, align 1, !tbaa !2
  store i8 %21, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 22), align 2, !tbaa !2
  %arrayidx.22 = getelementptr inbounds i8, i8* %address, i32 22
  %22 = load i8, i8* %arrayidx.22, align 1, !tbaa !2
  store i8 %22, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 23), align 1, !tbaa !2
  %arrayidx.23 = getelementptr inbounds i8, i8* %address, i32 23
  %23 = load i8, i8* %arrayidx.23, align 1, !tbaa !2
  store i8 %23, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 24), align 8, !tbaa !2
  %arrayidx.24 = getelementptr inbounds i8, i8* %address, i32 24
  %24 = load i8, i8* %arrayidx.24, align 1, !tbaa !2
  store i8 %24, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 25), align 1, !tbaa !2
  %arrayidx.25 = getelementptr inbounds i8, i8* %address, i32 25
  %25 = load i8, i8* %arrayidx.25, align 1, !tbaa !2
  store i8 %25, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 26), align 2, !tbaa !2
  %arrayidx.26 = getelementptr inbounds i8, i8* %address, i32 26
  %26 = load i8, i8* %arrayidx.26, align 1, !tbaa !2
  store i8 %26, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 27), align 1, !tbaa !2
  %arrayidx.27 = getelementptr inbounds i8, i8* %address, i32 27
  %27 = load i8, i8* %arrayidx.27, align 1, !tbaa !2
  store i8 %27, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 28), align 4, !tbaa !2
  %arrayidx.28 = getelementptr inbounds i8, i8* %address, i32 28
  %28 = load i8, i8* %arrayidx.28, align 1, !tbaa !2
  store i8 %28, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 29), align 1, !tbaa !2
  %arrayidx.29 = getelementptr inbounds i8, i8* %address, i32 29
  %29 = load i8, i8* %arrayidx.29, align 1, !tbaa !2
  store i8 %29, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 30), align 2, !tbaa !2
  %arrayidx.30 = getelementptr inbounds i8, i8* %address, i32 30
  %30 = load i8, i8* %arrayidx.30, align 1, !tbaa !2
  store i8 %30, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 31), align 1, !tbaa !2
  %arrayidx.31 = getelementptr inbounds i8, i8* %address, i32 31
  %31 = load i8, i8* %arrayidx.31, align 1, !tbaa !2
  store i8 %31, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 32), align 16, !tbaa !2
  %call = tail call i32 @keccak256(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), i32 33, i8* %destination) #6
  ret void
}

declare i32 @keccak256(i8*, i32, i8*) local_unnamed_addr #2

; Function Attrs: nounwind
define void @computeAllowanceKey(i8* %destination, i8* nocapture readonly %from, i8* nocapture readonly %to) local_unnamed_addr #1 {
entry:
  store i8 2, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 0), align 16, !tbaa !2
  %0 = load i8, i8* %from, align 1, !tbaa !2
  store i8 %0, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 1), align 1, !tbaa !2
  %arrayidx.1 = getelementptr inbounds i8, i8* %from, i32 1
  %1 = load i8, i8* %arrayidx.1, align 1, !tbaa !2
  store i8 %1, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 2), align 2, !tbaa !2
  %arrayidx.2 = getelementptr inbounds i8, i8* %from, i32 2
  %2 = load i8, i8* %arrayidx.2, align 1, !tbaa !2
  store i8 %2, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 3), align 1, !tbaa !2
  %arrayidx.3 = getelementptr inbounds i8, i8* %from, i32 3
  %3 = load i8, i8* %arrayidx.3, align 1, !tbaa !2
  store i8 %3, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 4), align 4, !tbaa !2
  %arrayidx.4 = getelementptr inbounds i8, i8* %from, i32 4
  %4 = load i8, i8* %arrayidx.4, align 1, !tbaa !2
  store i8 %4, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 5), align 1, !tbaa !2
  %arrayidx.5 = getelementptr inbounds i8, i8* %from, i32 5
  %5 = load i8, i8* %arrayidx.5, align 1, !tbaa !2
  store i8 %5, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 6), align 2, !tbaa !2
  %arrayidx.6 = getelementptr inbounds i8, i8* %from, i32 6
  %6 = load i8, i8* %arrayidx.6, align 1, !tbaa !2
  store i8 %6, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 7), align 1, !tbaa !2
  %arrayidx.7 = getelementptr inbounds i8, i8* %from, i32 7
  %7 = load i8, i8* %arrayidx.7, align 1, !tbaa !2
  store i8 %7, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 8), align 8, !tbaa !2
  %arrayidx.8 = getelementptr inbounds i8, i8* %from, i32 8
  %8 = load i8, i8* %arrayidx.8, align 1, !tbaa !2
  store i8 %8, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 9), align 1, !tbaa !2
  %arrayidx.9 = getelementptr inbounds i8, i8* %from, i32 9
  %9 = load i8, i8* %arrayidx.9, align 1, !tbaa !2
  store i8 %9, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 10), align 2, !tbaa !2
  %arrayidx.10 = getelementptr inbounds i8, i8* %from, i32 10
  %10 = load i8, i8* %arrayidx.10, align 1, !tbaa !2
  store i8 %10, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 11), align 1, !tbaa !2
  %arrayidx.11 = getelementptr inbounds i8, i8* %from, i32 11
  %11 = load i8, i8* %arrayidx.11, align 1, !tbaa !2
  store i8 %11, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 12), align 4, !tbaa !2
  %arrayidx.12 = getelementptr inbounds i8, i8* %from, i32 12
  %12 = load i8, i8* %arrayidx.12, align 1, !tbaa !2
  store i8 %12, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 13), align 1, !tbaa !2
  %arrayidx.13 = getelementptr inbounds i8, i8* %from, i32 13
  %13 = load i8, i8* %arrayidx.13, align 1, !tbaa !2
  store i8 %13, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 14), align 2, !tbaa !2
  %arrayidx.14 = getelementptr inbounds i8, i8* %from, i32 14
  %14 = load i8, i8* %arrayidx.14, align 1, !tbaa !2
  store i8 %14, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 15), align 1, !tbaa !2
  %arrayidx.15 = getelementptr inbounds i8, i8* %from, i32 15
  %15 = load i8, i8* %arrayidx.15, align 1, !tbaa !2
  store i8 %15, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 16), align 16, !tbaa !2
  %arrayidx.16 = getelementptr inbounds i8, i8* %from, i32 16
  %16 = load i8, i8* %arrayidx.16, align 1, !tbaa !2
  store i8 %16, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 17), align 1, !tbaa !2
  %arrayidx.17 = getelementptr inbounds i8, i8* %from, i32 17
  %17 = load i8, i8* %arrayidx.17, align 1, !tbaa !2
  store i8 %17, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 18), align 2, !tbaa !2
  %arrayidx.18 = getelementptr inbounds i8, i8* %from, i32 18
  %18 = load i8, i8* %arrayidx.18, align 1, !tbaa !2
  store i8 %18, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 19), align 1, !tbaa !2
  %arrayidx.19 = getelementptr inbounds i8, i8* %from, i32 19
  %19 = load i8, i8* %arrayidx.19, align 1, !tbaa !2
  store i8 %19, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 20), align 4, !tbaa !2
  %arrayidx.20 = getelementptr inbounds i8, i8* %from, i32 20
  %20 = load i8, i8* %arrayidx.20, align 1, !tbaa !2
  store i8 %20, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 21), align 1, !tbaa !2
  %arrayidx.21 = getelementptr inbounds i8, i8* %from, i32 21
  %21 = load i8, i8* %arrayidx.21, align 1, !tbaa !2
  store i8 %21, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 22), align 2, !tbaa !2
  %arrayidx.22 = getelementptr inbounds i8, i8* %from, i32 22
  %22 = load i8, i8* %arrayidx.22, align 1, !tbaa !2
  store i8 %22, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 23), align 1, !tbaa !2
  %arrayidx.23 = getelementptr inbounds i8, i8* %from, i32 23
  %23 = load i8, i8* %arrayidx.23, align 1, !tbaa !2
  store i8 %23, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 24), align 8, !tbaa !2
  %arrayidx.24 = getelementptr inbounds i8, i8* %from, i32 24
  %24 = load i8, i8* %arrayidx.24, align 1, !tbaa !2
  store i8 %24, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 25), align 1, !tbaa !2
  %arrayidx.25 = getelementptr inbounds i8, i8* %from, i32 25
  %25 = load i8, i8* %arrayidx.25, align 1, !tbaa !2
  store i8 %25, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 26), align 2, !tbaa !2
  %arrayidx.26 = getelementptr inbounds i8, i8* %from, i32 26
  %26 = load i8, i8* %arrayidx.26, align 1, !tbaa !2
  store i8 %26, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 27), align 1, !tbaa !2
  %arrayidx.27 = getelementptr inbounds i8, i8* %from, i32 27
  %27 = load i8, i8* %arrayidx.27, align 1, !tbaa !2
  store i8 %27, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 28), align 4, !tbaa !2
  %arrayidx.28 = getelementptr inbounds i8, i8* %from, i32 28
  %28 = load i8, i8* %arrayidx.28, align 1, !tbaa !2
  store i8 %28, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 29), align 1, !tbaa !2
  %arrayidx.29 = getelementptr inbounds i8, i8* %from, i32 29
  %29 = load i8, i8* %arrayidx.29, align 1, !tbaa !2
  store i8 %29, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 30), align 2, !tbaa !2
  %arrayidx.30 = getelementptr inbounds i8, i8* %from, i32 30
  %30 = load i8, i8* %arrayidx.30, align 1, !tbaa !2
  store i8 %30, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 31), align 1, !tbaa !2
  %arrayidx.31 = getelementptr inbounds i8, i8* %from, i32 31
  %31 = load i8, i8* %arrayidx.31, align 1, !tbaa !2
  store i8 %31, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 32), align 16, !tbaa !2
  %32 = load i8, i8* %to, align 1, !tbaa !2
  store i8 %32, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 33), align 1, !tbaa !2
  %arrayidx7.1 = getelementptr inbounds i8, i8* %to, i32 1
  %33 = load i8, i8* %arrayidx7.1, align 1, !tbaa !2
  store i8 %33, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 34), align 2, !tbaa !2
  %arrayidx7.2 = getelementptr inbounds i8, i8* %to, i32 2
  %34 = load i8, i8* %arrayidx7.2, align 1, !tbaa !2
  store i8 %34, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 35), align 1, !tbaa !2
  %arrayidx7.3 = getelementptr inbounds i8, i8* %to, i32 3
  %35 = load i8, i8* %arrayidx7.3, align 1, !tbaa !2
  store i8 %35, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 36), align 4, !tbaa !2
  %arrayidx7.4 = getelementptr inbounds i8, i8* %to, i32 4
  %36 = load i8, i8* %arrayidx7.4, align 1, !tbaa !2
  store i8 %36, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 37), align 1, !tbaa !2
  %arrayidx7.5 = getelementptr inbounds i8, i8* %to, i32 5
  %37 = load i8, i8* %arrayidx7.5, align 1, !tbaa !2
  store i8 %37, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 38), align 2, !tbaa !2
  %arrayidx7.6 = getelementptr inbounds i8, i8* %to, i32 6
  %38 = load i8, i8* %arrayidx7.6, align 1, !tbaa !2
  store i8 %38, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 39), align 1, !tbaa !2
  %arrayidx7.7 = getelementptr inbounds i8, i8* %to, i32 7
  %39 = load i8, i8* %arrayidx7.7, align 1, !tbaa !2
  store i8 %39, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 40), align 8, !tbaa !2
  %arrayidx7.8 = getelementptr inbounds i8, i8* %to, i32 8
  %40 = load i8, i8* %arrayidx7.8, align 1, !tbaa !2
  store i8 %40, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 41), align 1, !tbaa !2
  %arrayidx7.9 = getelementptr inbounds i8, i8* %to, i32 9
  %41 = load i8, i8* %arrayidx7.9, align 1, !tbaa !2
  store i8 %41, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 42), align 2, !tbaa !2
  %arrayidx7.10 = getelementptr inbounds i8, i8* %to, i32 10
  %42 = load i8, i8* %arrayidx7.10, align 1, !tbaa !2
  store i8 %42, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 43), align 1, !tbaa !2
  %arrayidx7.11 = getelementptr inbounds i8, i8* %to, i32 11
  %43 = load i8, i8* %arrayidx7.11, align 1, !tbaa !2
  store i8 %43, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 44), align 4, !tbaa !2
  %arrayidx7.12 = getelementptr inbounds i8, i8* %to, i32 12
  %44 = load i8, i8* %arrayidx7.12, align 1, !tbaa !2
  store i8 %44, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 45), align 1, !tbaa !2
  %arrayidx7.13 = getelementptr inbounds i8, i8* %to, i32 13
  %45 = load i8, i8* %arrayidx7.13, align 1, !tbaa !2
  store i8 %45, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 46), align 2, !tbaa !2
  %arrayidx7.14 = getelementptr inbounds i8, i8* %to, i32 14
  %46 = load i8, i8* %arrayidx7.14, align 1, !tbaa !2
  store i8 %46, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 47), align 1, !tbaa !2
  %arrayidx7.15 = getelementptr inbounds i8, i8* %to, i32 15
  %47 = load i8, i8* %arrayidx7.15, align 1, !tbaa !2
  store i8 %47, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 48), align 16, !tbaa !2
  %arrayidx7.16 = getelementptr inbounds i8, i8* %to, i32 16
  %48 = load i8, i8* %arrayidx7.16, align 1, !tbaa !2
  store i8 %48, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 49), align 1, !tbaa !2
  %arrayidx7.17 = getelementptr inbounds i8, i8* %to, i32 17
  %49 = load i8, i8* %arrayidx7.17, align 1, !tbaa !2
  store i8 %49, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 50), align 2, !tbaa !2
  %arrayidx7.18 = getelementptr inbounds i8, i8* %to, i32 18
  %50 = load i8, i8* %arrayidx7.18, align 1, !tbaa !2
  store i8 %50, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 51), align 1, !tbaa !2
  %arrayidx7.19 = getelementptr inbounds i8, i8* %to, i32 19
  %51 = load i8, i8* %arrayidx7.19, align 1, !tbaa !2
  store i8 %51, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 52), align 4, !tbaa !2
  %arrayidx7.20 = getelementptr inbounds i8, i8* %to, i32 20
  %52 = load i8, i8* %arrayidx7.20, align 1, !tbaa !2
  store i8 %52, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 53), align 1, !tbaa !2
  %arrayidx7.21 = getelementptr inbounds i8, i8* %to, i32 21
  %53 = load i8, i8* %arrayidx7.21, align 1, !tbaa !2
  store i8 %53, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 54), align 2, !tbaa !2
  %arrayidx7.22 = getelementptr inbounds i8, i8* %to, i32 22
  %54 = load i8, i8* %arrayidx7.22, align 1, !tbaa !2
  store i8 %54, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 55), align 1, !tbaa !2
  %arrayidx7.23 = getelementptr inbounds i8, i8* %to, i32 23
  %55 = load i8, i8* %arrayidx7.23, align 1, !tbaa !2
  store i8 %55, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 56), align 8, !tbaa !2
  %arrayidx7.24 = getelementptr inbounds i8, i8* %to, i32 24
  %56 = load i8, i8* %arrayidx7.24, align 1, !tbaa !2
  store i8 %56, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 57), align 1, !tbaa !2
  %arrayidx7.25 = getelementptr inbounds i8, i8* %to, i32 25
  %57 = load i8, i8* %arrayidx7.25, align 1, !tbaa !2
  store i8 %57, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 58), align 2, !tbaa !2
  %arrayidx7.26 = getelementptr inbounds i8, i8* %to, i32 26
  %58 = load i8, i8* %arrayidx7.26, align 1, !tbaa !2
  store i8 %58, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 59), align 1, !tbaa !2
  %arrayidx7.27 = getelementptr inbounds i8, i8* %to, i32 27
  %59 = load i8, i8* %arrayidx7.27, align 1, !tbaa !2
  store i8 %59, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 60), align 4, !tbaa !2
  %arrayidx7.28 = getelementptr inbounds i8, i8* %to, i32 28
  %60 = load i8, i8* %arrayidx7.28, align 1, !tbaa !2
  store i8 %60, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 61), align 1, !tbaa !2
  %arrayidx7.29 = getelementptr inbounds i8, i8* %to, i32 29
  %61 = load i8, i8* %arrayidx7.29, align 1, !tbaa !2
  store i8 %61, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 62), align 2, !tbaa !2
  %arrayidx7.30 = getelementptr inbounds i8, i8* %to, i32 30
  %62 = load i8, i8* %arrayidx7.30, align 1, !tbaa !2
  store i8 %62, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 63), align 1, !tbaa !2
  %arrayidx7.31 = getelementptr inbounds i8, i8* %to, i32 31
  %63 = load i8, i8* %arrayidx7.31, align 1, !tbaa !2
  store i8 %63, i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 64), align 16, !tbaa !2
  %call = tail call i32 @keccak256(i8* getelementptr inbounds ([65 x i8], [65 x i8]* @allowanceKeyRaw, i32 0, i32 0), i32 65, i8* %destination) #6
  ret void
}

; Function Attrs: nounwind
define void @saveLogWith3Topics(i8* nocapture readonly %topic1, i8* nocapture readonly %topic2, i8* nocapture readonly %topic3, i32 %value) local_unnamed_addr #1 {
entry:
  %0 = load i8, i8* %topic1, align 1, !tbaa !2
  store i8 %0, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 0), align 16, !tbaa !2
  %arrayidx.1 = getelementptr inbounds i8, i8* %topic1, i32 1
  %1 = load i8, i8* %arrayidx.1, align 1, !tbaa !2
  store i8 %1, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 1), align 1, !tbaa !2
  %arrayidx.2 = getelementptr inbounds i8, i8* %topic1, i32 2
  %2 = load i8, i8* %arrayidx.2, align 1, !tbaa !2
  store i8 %2, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 2), align 2, !tbaa !2
  %arrayidx.3 = getelementptr inbounds i8, i8* %topic1, i32 3
  %3 = load i8, i8* %arrayidx.3, align 1, !tbaa !2
  store i8 %3, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 3), align 1, !tbaa !2
  %arrayidx.4 = getelementptr inbounds i8, i8* %topic1, i32 4
  %4 = load i8, i8* %arrayidx.4, align 1, !tbaa !2
  store i8 %4, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 4), align 4, !tbaa !2
  %arrayidx.5 = getelementptr inbounds i8, i8* %topic1, i32 5
  %5 = load i8, i8* %arrayidx.5, align 1, !tbaa !2
  store i8 %5, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 5), align 1, !tbaa !2
  %arrayidx.6 = getelementptr inbounds i8, i8* %topic1, i32 6
  %6 = load i8, i8* %arrayidx.6, align 1, !tbaa !2
  store i8 %6, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 6), align 2, !tbaa !2
  %arrayidx.7 = getelementptr inbounds i8, i8* %topic1, i32 7
  %7 = load i8, i8* %arrayidx.7, align 1, !tbaa !2
  store i8 %7, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 7), align 1, !tbaa !2
  %arrayidx.8 = getelementptr inbounds i8, i8* %topic1, i32 8
  %8 = load i8, i8* %arrayidx.8, align 1, !tbaa !2
  store i8 %8, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 8), align 8, !tbaa !2
  %arrayidx.9 = getelementptr inbounds i8, i8* %topic1, i32 9
  %9 = load i8, i8* %arrayidx.9, align 1, !tbaa !2
  store i8 %9, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 9), align 1, !tbaa !2
  %arrayidx.10 = getelementptr inbounds i8, i8* %topic1, i32 10
  %10 = load i8, i8* %arrayidx.10, align 1, !tbaa !2
  store i8 %10, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 10), align 2, !tbaa !2
  %arrayidx.11 = getelementptr inbounds i8, i8* %topic1, i32 11
  %11 = load i8, i8* %arrayidx.11, align 1, !tbaa !2
  store i8 %11, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 11), align 1, !tbaa !2
  %arrayidx.12 = getelementptr inbounds i8, i8* %topic1, i32 12
  %12 = load i8, i8* %arrayidx.12, align 1, !tbaa !2
  store i8 %12, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 12), align 4, !tbaa !2
  %arrayidx.13 = getelementptr inbounds i8, i8* %topic1, i32 13
  %13 = load i8, i8* %arrayidx.13, align 1, !tbaa !2
  store i8 %13, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 13), align 1, !tbaa !2
  %arrayidx.14 = getelementptr inbounds i8, i8* %topic1, i32 14
  %14 = load i8, i8* %arrayidx.14, align 1, !tbaa !2
  store i8 %14, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 14), align 2, !tbaa !2
  %arrayidx.15 = getelementptr inbounds i8, i8* %topic1, i32 15
  %15 = load i8, i8* %arrayidx.15, align 1, !tbaa !2
  store i8 %15, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 15), align 1, !tbaa !2
  %arrayidx.16 = getelementptr inbounds i8, i8* %topic1, i32 16
  %16 = load i8, i8* %arrayidx.16, align 1, !tbaa !2
  store i8 %16, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 16), align 16, !tbaa !2
  %arrayidx.17 = getelementptr inbounds i8, i8* %topic1, i32 17
  %17 = load i8, i8* %arrayidx.17, align 1, !tbaa !2
  store i8 %17, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 17), align 1, !tbaa !2
  %arrayidx.18 = getelementptr inbounds i8, i8* %topic1, i32 18
  %18 = load i8, i8* %arrayidx.18, align 1, !tbaa !2
  store i8 %18, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 18), align 2, !tbaa !2
  %arrayidx.19 = getelementptr inbounds i8, i8* %topic1, i32 19
  %19 = load i8, i8* %arrayidx.19, align 1, !tbaa !2
  store i8 %19, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 19), align 1, !tbaa !2
  %arrayidx.20 = getelementptr inbounds i8, i8* %topic1, i32 20
  %20 = load i8, i8* %arrayidx.20, align 1, !tbaa !2
  store i8 %20, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 20), align 4, !tbaa !2
  %arrayidx.21 = getelementptr inbounds i8, i8* %topic1, i32 21
  %21 = load i8, i8* %arrayidx.21, align 1, !tbaa !2
  store i8 %21, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 21), align 1, !tbaa !2
  %arrayidx.22 = getelementptr inbounds i8, i8* %topic1, i32 22
  %22 = load i8, i8* %arrayidx.22, align 1, !tbaa !2
  store i8 %22, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 22), align 2, !tbaa !2
  %arrayidx.23 = getelementptr inbounds i8, i8* %topic1, i32 23
  %23 = load i8, i8* %arrayidx.23, align 1, !tbaa !2
  store i8 %23, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 23), align 1, !tbaa !2
  %arrayidx.24 = getelementptr inbounds i8, i8* %topic1, i32 24
  %24 = load i8, i8* %arrayidx.24, align 1, !tbaa !2
  store i8 %24, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 24), align 8, !tbaa !2
  %arrayidx.25 = getelementptr inbounds i8, i8* %topic1, i32 25
  %25 = load i8, i8* %arrayidx.25, align 1, !tbaa !2
  store i8 %25, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 25), align 1, !tbaa !2
  %arrayidx.26 = getelementptr inbounds i8, i8* %topic1, i32 26
  %26 = load i8, i8* %arrayidx.26, align 1, !tbaa !2
  store i8 %26, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 26), align 2, !tbaa !2
  %arrayidx.27 = getelementptr inbounds i8, i8* %topic1, i32 27
  %27 = load i8, i8* %arrayidx.27, align 1, !tbaa !2
  store i8 %27, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 27), align 1, !tbaa !2
  %arrayidx.28 = getelementptr inbounds i8, i8* %topic1, i32 28
  %28 = load i8, i8* %arrayidx.28, align 1, !tbaa !2
  store i8 %28, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 28), align 4, !tbaa !2
  %arrayidx.29 = getelementptr inbounds i8, i8* %topic1, i32 29
  %29 = load i8, i8* %arrayidx.29, align 1, !tbaa !2
  store i8 %29, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 29), align 1, !tbaa !2
  %arrayidx.30 = getelementptr inbounds i8, i8* %topic1, i32 30
  %30 = load i8, i8* %arrayidx.30, align 1, !tbaa !2
  store i8 %30, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 30), align 2, !tbaa !2
  %arrayidx.31 = getelementptr inbounds i8, i8* %topic1, i32 31
  %31 = load i8, i8* %arrayidx.31, align 1, !tbaa !2
  store i8 %31, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 31), align 1, !tbaa !2
  %32 = load i8, i8* %topic2, align 1, !tbaa !2
  store i8 %32, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 32), align 16, !tbaa !2
  %arrayidx7.1 = getelementptr inbounds i8, i8* %topic2, i32 1
  %33 = load i8, i8* %arrayidx7.1, align 1, !tbaa !2
  store i8 %33, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 33), align 1, !tbaa !2
  %arrayidx7.2 = getelementptr inbounds i8, i8* %topic2, i32 2
  %34 = load i8, i8* %arrayidx7.2, align 1, !tbaa !2
  store i8 %34, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 34), align 2, !tbaa !2
  %arrayidx7.3 = getelementptr inbounds i8, i8* %topic2, i32 3
  %35 = load i8, i8* %arrayidx7.3, align 1, !tbaa !2
  store i8 %35, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 35), align 1, !tbaa !2
  %arrayidx7.4 = getelementptr inbounds i8, i8* %topic2, i32 4
  %36 = load i8, i8* %arrayidx7.4, align 1, !tbaa !2
  store i8 %36, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 36), align 4, !tbaa !2
  %arrayidx7.5 = getelementptr inbounds i8, i8* %topic2, i32 5
  %37 = load i8, i8* %arrayidx7.5, align 1, !tbaa !2
  store i8 %37, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 37), align 1, !tbaa !2
  %arrayidx7.6 = getelementptr inbounds i8, i8* %topic2, i32 6
  %38 = load i8, i8* %arrayidx7.6, align 1, !tbaa !2
  store i8 %38, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 38), align 2, !tbaa !2
  %arrayidx7.7 = getelementptr inbounds i8, i8* %topic2, i32 7
  %39 = load i8, i8* %arrayidx7.7, align 1, !tbaa !2
  store i8 %39, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 39), align 1, !tbaa !2
  %arrayidx7.8 = getelementptr inbounds i8, i8* %topic2, i32 8
  %40 = load i8, i8* %arrayidx7.8, align 1, !tbaa !2
  store i8 %40, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 40), align 8, !tbaa !2
  %arrayidx7.9 = getelementptr inbounds i8, i8* %topic2, i32 9
  %41 = load i8, i8* %arrayidx7.9, align 1, !tbaa !2
  store i8 %41, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 41), align 1, !tbaa !2
  %arrayidx7.10 = getelementptr inbounds i8, i8* %topic2, i32 10
  %42 = load i8, i8* %arrayidx7.10, align 1, !tbaa !2
  store i8 %42, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 42), align 2, !tbaa !2
  %arrayidx7.11 = getelementptr inbounds i8, i8* %topic2, i32 11
  %43 = load i8, i8* %arrayidx7.11, align 1, !tbaa !2
  store i8 %43, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 43), align 1, !tbaa !2
  %arrayidx7.12 = getelementptr inbounds i8, i8* %topic2, i32 12
  %44 = load i8, i8* %arrayidx7.12, align 1, !tbaa !2
  store i8 %44, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 44), align 4, !tbaa !2
  %arrayidx7.13 = getelementptr inbounds i8, i8* %topic2, i32 13
  %45 = load i8, i8* %arrayidx7.13, align 1, !tbaa !2
  store i8 %45, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 45), align 1, !tbaa !2
  %arrayidx7.14 = getelementptr inbounds i8, i8* %topic2, i32 14
  %46 = load i8, i8* %arrayidx7.14, align 1, !tbaa !2
  store i8 %46, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 46), align 2, !tbaa !2
  %arrayidx7.15 = getelementptr inbounds i8, i8* %topic2, i32 15
  %47 = load i8, i8* %arrayidx7.15, align 1, !tbaa !2
  store i8 %47, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 47), align 1, !tbaa !2
  %arrayidx7.16 = getelementptr inbounds i8, i8* %topic2, i32 16
  %48 = load i8, i8* %arrayidx7.16, align 1, !tbaa !2
  store i8 %48, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 48), align 16, !tbaa !2
  %arrayidx7.17 = getelementptr inbounds i8, i8* %topic2, i32 17
  %49 = load i8, i8* %arrayidx7.17, align 1, !tbaa !2
  store i8 %49, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 49), align 1, !tbaa !2
  %arrayidx7.18 = getelementptr inbounds i8, i8* %topic2, i32 18
  %50 = load i8, i8* %arrayidx7.18, align 1, !tbaa !2
  store i8 %50, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 50), align 2, !tbaa !2
  %arrayidx7.19 = getelementptr inbounds i8, i8* %topic2, i32 19
  %51 = load i8, i8* %arrayidx7.19, align 1, !tbaa !2
  store i8 %51, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 51), align 1, !tbaa !2
  %arrayidx7.20 = getelementptr inbounds i8, i8* %topic2, i32 20
  %52 = load i8, i8* %arrayidx7.20, align 1, !tbaa !2
  store i8 %52, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 52), align 4, !tbaa !2
  %arrayidx7.21 = getelementptr inbounds i8, i8* %topic2, i32 21
  %53 = load i8, i8* %arrayidx7.21, align 1, !tbaa !2
  store i8 %53, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 53), align 1, !tbaa !2
  %arrayidx7.22 = getelementptr inbounds i8, i8* %topic2, i32 22
  %54 = load i8, i8* %arrayidx7.22, align 1, !tbaa !2
  store i8 %54, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 54), align 2, !tbaa !2
  %arrayidx7.23 = getelementptr inbounds i8, i8* %topic2, i32 23
  %55 = load i8, i8* %arrayidx7.23, align 1, !tbaa !2
  store i8 %55, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 55), align 1, !tbaa !2
  %arrayidx7.24 = getelementptr inbounds i8, i8* %topic2, i32 24
  %56 = load i8, i8* %arrayidx7.24, align 1, !tbaa !2
  store i8 %56, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 56), align 8, !tbaa !2
  %arrayidx7.25 = getelementptr inbounds i8, i8* %topic2, i32 25
  %57 = load i8, i8* %arrayidx7.25, align 1, !tbaa !2
  store i8 %57, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 57), align 1, !tbaa !2
  %arrayidx7.26 = getelementptr inbounds i8, i8* %topic2, i32 26
  %58 = load i8, i8* %arrayidx7.26, align 1, !tbaa !2
  store i8 %58, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 58), align 2, !tbaa !2
  %arrayidx7.27 = getelementptr inbounds i8, i8* %topic2, i32 27
  %59 = load i8, i8* %arrayidx7.27, align 1, !tbaa !2
  store i8 %59, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 59), align 1, !tbaa !2
  %arrayidx7.28 = getelementptr inbounds i8, i8* %topic2, i32 28
  %60 = load i8, i8* %arrayidx7.28, align 1, !tbaa !2
  store i8 %60, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 60), align 4, !tbaa !2
  %arrayidx7.29 = getelementptr inbounds i8, i8* %topic2, i32 29
  %61 = load i8, i8* %arrayidx7.29, align 1, !tbaa !2
  store i8 %61, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 61), align 1, !tbaa !2
  %arrayidx7.30 = getelementptr inbounds i8, i8* %topic2, i32 30
  %62 = load i8, i8* %arrayidx7.30, align 1, !tbaa !2
  store i8 %62, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 62), align 2, !tbaa !2
  %arrayidx7.31 = getelementptr inbounds i8, i8* %topic2, i32 31
  %63 = load i8, i8* %arrayidx7.31, align 1, !tbaa !2
  store i8 %63, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 63), align 1, !tbaa !2
  %64 = load i8, i8* %topic3, align 1, !tbaa !2
  store i8 %64, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 64), align 16, !tbaa !2
  %arrayidx17.1 = getelementptr inbounds i8, i8* %topic3, i32 1
  %65 = load i8, i8* %arrayidx17.1, align 1, !tbaa !2
  store i8 %65, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 65), align 1, !tbaa !2
  %arrayidx17.2 = getelementptr inbounds i8, i8* %topic3, i32 2
  %66 = load i8, i8* %arrayidx17.2, align 1, !tbaa !2
  store i8 %66, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 66), align 2, !tbaa !2
  %arrayidx17.3 = getelementptr inbounds i8, i8* %topic3, i32 3
  %67 = load i8, i8* %arrayidx17.3, align 1, !tbaa !2
  store i8 %67, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 67), align 1, !tbaa !2
  %arrayidx17.4 = getelementptr inbounds i8, i8* %topic3, i32 4
  %68 = load i8, i8* %arrayidx17.4, align 1, !tbaa !2
  store i8 %68, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 68), align 4, !tbaa !2
  %arrayidx17.5 = getelementptr inbounds i8, i8* %topic3, i32 5
  %69 = load i8, i8* %arrayidx17.5, align 1, !tbaa !2
  store i8 %69, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 69), align 1, !tbaa !2
  %arrayidx17.6 = getelementptr inbounds i8, i8* %topic3, i32 6
  %70 = load i8, i8* %arrayidx17.6, align 1, !tbaa !2
  store i8 %70, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 70), align 2, !tbaa !2
  %arrayidx17.7 = getelementptr inbounds i8, i8* %topic3, i32 7
  %71 = load i8, i8* %arrayidx17.7, align 1, !tbaa !2
  store i8 %71, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 71), align 1, !tbaa !2
  %arrayidx17.8 = getelementptr inbounds i8, i8* %topic3, i32 8
  %72 = load i8, i8* %arrayidx17.8, align 1, !tbaa !2
  store i8 %72, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 72), align 8, !tbaa !2
  %arrayidx17.9 = getelementptr inbounds i8, i8* %topic3, i32 9
  %73 = load i8, i8* %arrayidx17.9, align 1, !tbaa !2
  store i8 %73, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 73), align 1, !tbaa !2
  %arrayidx17.10 = getelementptr inbounds i8, i8* %topic3, i32 10
  %74 = load i8, i8* %arrayidx17.10, align 1, !tbaa !2
  store i8 %74, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 74), align 2, !tbaa !2
  %arrayidx17.11 = getelementptr inbounds i8, i8* %topic3, i32 11
  %75 = load i8, i8* %arrayidx17.11, align 1, !tbaa !2
  store i8 %75, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 75), align 1, !tbaa !2
  %arrayidx17.12 = getelementptr inbounds i8, i8* %topic3, i32 12
  %76 = load i8, i8* %arrayidx17.12, align 1, !tbaa !2
  store i8 %76, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 76), align 4, !tbaa !2
  %arrayidx17.13 = getelementptr inbounds i8, i8* %topic3, i32 13
  %77 = load i8, i8* %arrayidx17.13, align 1, !tbaa !2
  store i8 %77, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 77), align 1, !tbaa !2
  %arrayidx17.14 = getelementptr inbounds i8, i8* %topic3, i32 14
  %78 = load i8, i8* %arrayidx17.14, align 1, !tbaa !2
  store i8 %78, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 78), align 2, !tbaa !2
  %arrayidx17.15 = getelementptr inbounds i8, i8* %topic3, i32 15
  %79 = load i8, i8* %arrayidx17.15, align 1, !tbaa !2
  store i8 %79, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 79), align 1, !tbaa !2
  %arrayidx17.16 = getelementptr inbounds i8, i8* %topic3, i32 16
  %80 = load i8, i8* %arrayidx17.16, align 1, !tbaa !2
  store i8 %80, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 80), align 16, !tbaa !2
  %arrayidx17.17 = getelementptr inbounds i8, i8* %topic3, i32 17
  %81 = load i8, i8* %arrayidx17.17, align 1, !tbaa !2
  store i8 %81, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 81), align 1, !tbaa !2
  %arrayidx17.18 = getelementptr inbounds i8, i8* %topic3, i32 18
  %82 = load i8, i8* %arrayidx17.18, align 1, !tbaa !2
  store i8 %82, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 82), align 2, !tbaa !2
  %arrayidx17.19 = getelementptr inbounds i8, i8* %topic3, i32 19
  %83 = load i8, i8* %arrayidx17.19, align 1, !tbaa !2
  store i8 %83, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 83), align 1, !tbaa !2
  %arrayidx17.20 = getelementptr inbounds i8, i8* %topic3, i32 20
  %84 = load i8, i8* %arrayidx17.20, align 1, !tbaa !2
  store i8 %84, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 84), align 4, !tbaa !2
  %arrayidx17.21 = getelementptr inbounds i8, i8* %topic3, i32 21
  %85 = load i8, i8* %arrayidx17.21, align 1, !tbaa !2
  store i8 %85, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 85), align 1, !tbaa !2
  %arrayidx17.22 = getelementptr inbounds i8, i8* %topic3, i32 22
  %86 = load i8, i8* %arrayidx17.22, align 1, !tbaa !2
  store i8 %86, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 86), align 2, !tbaa !2
  %arrayidx17.23 = getelementptr inbounds i8, i8* %topic3, i32 23
  %87 = load i8, i8* %arrayidx17.23, align 1, !tbaa !2
  store i8 %87, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 87), align 1, !tbaa !2
  %arrayidx17.24 = getelementptr inbounds i8, i8* %topic3, i32 24
  %88 = load i8, i8* %arrayidx17.24, align 1, !tbaa !2
  store i8 %88, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 88), align 8, !tbaa !2
  %arrayidx17.25 = getelementptr inbounds i8, i8* %topic3, i32 25
  %89 = load i8, i8* %arrayidx17.25, align 1, !tbaa !2
  store i8 %89, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 89), align 1, !tbaa !2
  %arrayidx17.26 = getelementptr inbounds i8, i8* %topic3, i32 26
  %90 = load i8, i8* %arrayidx17.26, align 1, !tbaa !2
  store i8 %90, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 90), align 2, !tbaa !2
  %arrayidx17.27 = getelementptr inbounds i8, i8* %topic3, i32 27
  %91 = load i8, i8* %arrayidx17.27, align 1, !tbaa !2
  store i8 %91, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 91), align 1, !tbaa !2
  %arrayidx17.28 = getelementptr inbounds i8, i8* %topic3, i32 28
  %92 = load i8, i8* %arrayidx17.28, align 1, !tbaa !2
  store i8 %92, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 92), align 4, !tbaa !2
  %arrayidx17.29 = getelementptr inbounds i8, i8* %topic3, i32 29
  %93 = load i8, i8* %arrayidx17.29, align 1, !tbaa !2
  store i8 %93, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 93), align 1, !tbaa !2
  %arrayidx17.30 = getelementptr inbounds i8, i8* %topic3, i32 30
  %94 = load i8, i8* %arrayidx17.30, align 1, !tbaa !2
  store i8 %94, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 94), align 2, !tbaa !2
  %arrayidx17.31 = getelementptr inbounds i8, i8* %topic3, i32 31
  %95 = load i8, i8* %arrayidx17.31, align 1, !tbaa !2
  store i8 %95, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 95), align 1, !tbaa !2
  %call = tail call i32 @bigIntGetBytes(i32 %value, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentLogVal, i32 0, i32 0)) #6
  tail call void @writeLog(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentLogVal, i32 0, i32 0), i32 %call, i8* getelementptr inbounds ([96 x i8], [96 x i8]* @currentTopics, i32 0, i32 0), i32 3) #6
  ret void
}

declare i32 @bigIntGetBytes(i32, i8*) local_unnamed_addr #2

declare void @writeLog(i8*, i32, i8*, i32) local_unnamed_addr #2

; Function Attrs: nounwind
define void @init() local_unnamed_addr #1 {
entry:
  %call = tail call i32 bitcast (i32 (...)* @getNumArguments to i32 ()*)() #6
  %cmp = icmp eq i32 %call, 1
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @signalError(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @ERR_NUM_ARGS, i32 0, i32 0), i32 25) #6
  br label %return

if.end:                                           ; preds = %entry
  %call1 = tail call i32 @bigIntNew(i64 0) #6
  tail call void @bigIntGetCallValue(i32 %call1) #6
  %call2 = tail call i32 @bigIntNew(i64 0) #6
  %call3 = tail call i32 @bigIntCmp(i32 %call1, i32 %call2) #6
  %cmp4 = icmp sgt i32 %call3, 0
  br i1 %cmp4, label %if.then5, label %cleanup.cont

if.then5:                                         ; preds = %if.end
  tail call void @signalError(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @ERR_NOT_PAYABLE, i32 0, i32 0), i32 54) #6
  br label %return

cleanup.cont:                                     ; preds = %if.end
  tail call void @getCaller(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0)) #6
  %call8 = tail call i32 @bigIntNew(i64 0) #6
  tail call void @bigIntGetSignedArgument(i32 0, i32 %call8) #6
  tail call void @llvm.memset.p0i8.i32(i8* align 16 getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i8 0, i32 32, i1 false) #6
  %call9 = tail call i32 @bigIntStorageStore(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call8) #6
  store i8 1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), align 16, !tbaa !2
  %0 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0), align 16, !tbaa !2
  store i8 %0, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 1), align 1, !tbaa !2
  %1 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 1), align 1, !tbaa !2
  store i8 %1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 2), align 2, !tbaa !2
  %2 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 2), align 2, !tbaa !2
  store i8 %2, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 3), align 1, !tbaa !2
  %3 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 3), align 1, !tbaa !2
  store i8 %3, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 4), align 4, !tbaa !2
  %4 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 4), align 4, !tbaa !2
  store i8 %4, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 5), align 1, !tbaa !2
  %5 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 5), align 1, !tbaa !2
  store i8 %5, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 6), align 2, !tbaa !2
  %6 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 6), align 2, !tbaa !2
  store i8 %6, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 7), align 1, !tbaa !2
  %7 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 7), align 1, !tbaa !2
  store i8 %7, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 8), align 8, !tbaa !2
  %8 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 8), align 8, !tbaa !2
  store i8 %8, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 9), align 1, !tbaa !2
  %9 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 9), align 1, !tbaa !2
  store i8 %9, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 10), align 2, !tbaa !2
  %10 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 10), align 2, !tbaa !2
  store i8 %10, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 11), align 1, !tbaa !2
  %11 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 11), align 1, !tbaa !2
  store i8 %11, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 12), align 4, !tbaa !2
  %12 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 12), align 4, !tbaa !2
  store i8 %12, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 13), align 1, !tbaa !2
  %13 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 13), align 1, !tbaa !2
  store i8 %13, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 14), align 2, !tbaa !2
  %14 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 14), align 2, !tbaa !2
  store i8 %14, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 15), align 1, !tbaa !2
  %15 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 15), align 1, !tbaa !2
  store i8 %15, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 16), align 16, !tbaa !2
  %16 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 16), align 16, !tbaa !2
  store i8 %16, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 17), align 1, !tbaa !2
  %17 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 17), align 1, !tbaa !2
  store i8 %17, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 18), align 2, !tbaa !2
  %18 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 18), align 2, !tbaa !2
  store i8 %18, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 19), align 1, !tbaa !2
  %19 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 19), align 1, !tbaa !2
  store i8 %19, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 20), align 4, !tbaa !2
  %20 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 20), align 4, !tbaa !2
  store i8 %20, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 21), align 1, !tbaa !2
  %21 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 21), align 1, !tbaa !2
  store i8 %21, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 22), align 2, !tbaa !2
  %22 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 22), align 2, !tbaa !2
  store i8 %22, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 23), align 1, !tbaa !2
  %23 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 23), align 1, !tbaa !2
  store i8 %23, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 24), align 8, !tbaa !2
  %24 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 24), align 8, !tbaa !2
  store i8 %24, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 25), align 1, !tbaa !2
  %25 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 25), align 1, !tbaa !2
  store i8 %25, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 26), align 2, !tbaa !2
  %26 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 26), align 2, !tbaa !2
  store i8 %26, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 27), align 1, !tbaa !2
  %27 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 27), align 1, !tbaa !2
  store i8 %27, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 28), align 4, !tbaa !2
  %28 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 28), align 4, !tbaa !2
  store i8 %28, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 29), align 1, !tbaa !2
  %29 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 29), align 1, !tbaa !2
  store i8 %29, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 30), align 2, !tbaa !2
  %30 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 30), align 2, !tbaa !2
  store i8 %30, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 31), align 1, !tbaa !2
  %31 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 31), align 1, !tbaa !2
  store i8 %31, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 32), align 16, !tbaa !2
  %call.i = tail call i32 @keccak256(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), i32 33, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0)) #6
  %call10 = tail call i32 @bigIntStorageStore(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call8) #6
  br label %return

return:                                           ; preds = %if.then5, %cleanup.cont, %if.then
  ret void
}

declare i32 @getNumArguments(...) local_unnamed_addr #3

declare void @signalError(i8*, i32) local_unnamed_addr #2

declare i32 @bigIntNew(i64) local_unnamed_addr #2

declare void @bigIntGetCallValue(i32) local_unnamed_addr #2

declare i32 @bigIntCmp(i32, i32) local_unnamed_addr #2

declare void @getCaller(i8*) local_unnamed_addr #2

declare void @bigIntGetSignedArgument(i32, i32) local_unnamed_addr #2

declare i32 @bigIntStorageStore(i8*, i32) local_unnamed_addr #2

; Function Attrs: nounwind
define void @totalSupply() local_unnamed_addr #1 {
entry:
  %call = tail call i32 bitcast (i32 (...)* @getNumArguments to i32 ()*)() #6
  %cmp = icmp eq i32 %call, 0
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @signalError(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @ERR_NUM_ARGS, i32 0, i32 0), i32 25) #6
  br label %return

if.end:                                           ; preds = %entry
  %call1 = tail call i32 @bigIntNew(i64 0) #6
  tail call void @bigIntGetCallValue(i32 %call1) #6
  %call2 = tail call i32 @bigIntNew(i64 0) #6
  %call3 = tail call i32 @bigIntCmp(i32 %call1, i32 %call2) #6
  %cmp4 = icmp sgt i32 %call3, 0
  br i1 %cmp4, label %if.then5, label %cleanup.cont

if.then5:                                         ; preds = %if.end
  tail call void @signalError(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @ERR_NOT_PAYABLE, i32 0, i32 0), i32 54) #6
  br label %return

cleanup.cont:                                     ; preds = %if.end
  tail call void @llvm.memset.p0i8.i32(i8* align 16 getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i8 0, i32 32, i1 false) #6
  %call8 = tail call i32 @bigIntNew(i64 0) #6
  %call9 = tail call i32 @bigIntStorageLoad(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call8) #6
  tail call void @bigIntFinish(i32 %call8) #6
  br label %return

return:                                           ; preds = %if.then5, %cleanup.cont, %if.then
  ret void
}

declare i32 @bigIntStorageLoad(i8*, i32) local_unnamed_addr #2

declare void @bigIntFinish(i32) local_unnamed_addr #2

; Function Attrs: nounwind
define void @balanceOf() local_unnamed_addr #1 {
entry:
  %call = tail call i32 bitcast (i32 (...)* @getNumArguments to i32 ()*)() #6
  %cmp = icmp eq i32 %call, 1
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @signalError(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @ERR_NUM_ARGS, i32 0, i32 0), i32 25) #6
  br label %return

if.end:                                           ; preds = %entry
  %call1 = tail call i32 @bigIntNew(i64 0) #6
  tail call void @bigIntGetCallValue(i32 %call1) #6
  %call2 = tail call i32 @bigIntNew(i64 0) #6
  %call3 = tail call i32 @bigIntCmp(i32 %call1, i32 %call2) #6
  %cmp4 = icmp sgt i32 %call3, 0
  br i1 %cmp4, label %if.then5, label %cleanup.cont

if.then5:                                         ; preds = %if.end
  tail call void @signalError(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @ERR_NOT_PAYABLE, i32 0, i32 0), i32 54) #6
  br label %return

cleanup.cont:                                     ; preds = %if.end
  %call8 = tail call i32 @getArgument(i32 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 0)) #6
  store i8 1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), align 16, !tbaa !2
  %0 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 0), align 16, !tbaa !2
  store i8 %0, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 1), align 1, !tbaa !2
  %1 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 1), align 1, !tbaa !2
  store i8 %1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 2), align 2, !tbaa !2
  %2 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 2), align 2, !tbaa !2
  store i8 %2, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 3), align 1, !tbaa !2
  %3 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 3), align 1, !tbaa !2
  store i8 %3, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 4), align 4, !tbaa !2
  %4 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 4), align 4, !tbaa !2
  store i8 %4, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 5), align 1, !tbaa !2
  %5 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 5), align 1, !tbaa !2
  store i8 %5, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 6), align 2, !tbaa !2
  %6 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 6), align 2, !tbaa !2
  store i8 %6, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 7), align 1, !tbaa !2
  %7 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 7), align 1, !tbaa !2
  store i8 %7, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 8), align 8, !tbaa !2
  %8 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 8), align 8, !tbaa !2
  store i8 %8, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 9), align 1, !tbaa !2
  %9 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 9), align 1, !tbaa !2
  store i8 %9, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 10), align 2, !tbaa !2
  %10 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 10), align 2, !tbaa !2
  store i8 %10, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 11), align 1, !tbaa !2
  %11 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 11), align 1, !tbaa !2
  store i8 %11, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 12), align 4, !tbaa !2
  %12 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 12), align 4, !tbaa !2
  store i8 %12, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 13), align 1, !tbaa !2
  %13 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 13), align 1, !tbaa !2
  store i8 %13, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 14), align 2, !tbaa !2
  %14 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 14), align 2, !tbaa !2
  store i8 %14, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 15), align 1, !tbaa !2
  %15 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 15), align 1, !tbaa !2
  store i8 %15, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 16), align 16, !tbaa !2
  %16 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 16), align 16, !tbaa !2
  store i8 %16, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 17), align 1, !tbaa !2
  %17 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 17), align 1, !tbaa !2
  store i8 %17, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 18), align 2, !tbaa !2
  %18 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 18), align 2, !tbaa !2
  store i8 %18, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 19), align 1, !tbaa !2
  %19 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 19), align 1, !tbaa !2
  store i8 %19, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 20), align 4, !tbaa !2
  %20 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 20), align 4, !tbaa !2
  store i8 %20, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 21), align 1, !tbaa !2
  %21 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 21), align 1, !tbaa !2
  store i8 %21, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 22), align 2, !tbaa !2
  %22 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 22), align 2, !tbaa !2
  store i8 %22, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 23), align 1, !tbaa !2
  %23 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 23), align 1, !tbaa !2
  store i8 %23, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 24), align 8, !tbaa !2
  %24 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 24), align 8, !tbaa !2
  store i8 %24, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 25), align 1, !tbaa !2
  %25 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 25), align 1, !tbaa !2
  store i8 %25, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 26), align 2, !tbaa !2
  %26 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 26), align 2, !tbaa !2
  store i8 %26, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 27), align 1, !tbaa !2
  %27 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 27), align 1, !tbaa !2
  store i8 %27, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 28), align 4, !tbaa !2
  %28 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 28), align 4, !tbaa !2
  store i8 %28, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 29), align 1, !tbaa !2
  %29 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 29), align 1, !tbaa !2
  store i8 %29, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 30), align 2, !tbaa !2
  %30 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 30), align 2, !tbaa !2
  store i8 %30, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 31), align 1, !tbaa !2
  %31 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 31), align 1, !tbaa !2
  store i8 %31, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 32), align 16, !tbaa !2
  %call.i = tail call i32 @keccak256(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), i32 33, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0)) #6
  %call9 = tail call i32 @bigIntNew(i64 0) #6
  %call10 = tail call i32 @bigIntStorageLoad(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call9) #6
  tail call void @bigIntFinish(i32 %call9) #6
  br label %return

return:                                           ; preds = %if.then5, %cleanup.cont, %if.then
  ret void
}

declare i32 @getArgument(i32, i8*) local_unnamed_addr #2

; Function Attrs: nounwind
define void @allowance() local_unnamed_addr #1 {
entry:
  %call = tail call i32 bitcast (i32 (...)* @getNumArguments to i32 ()*)() #6
  %cmp = icmp eq i32 %call, 2
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @signalError(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @ERR_NUM_ARGS, i32 0, i32 0), i32 25) #6
  br label %return

if.end:                                           ; preds = %entry
  %call1 = tail call i32 @bigIntNew(i64 0) #6
  tail call void @bigIntGetCallValue(i32 %call1) #6
  %call2 = tail call i32 @bigIntNew(i64 0) #6
  %call3 = tail call i32 @bigIntCmp(i32 %call1, i32 %call2) #6
  %cmp4 = icmp sgt i32 %call3, 0
  br i1 %cmp4, label %if.then5, label %cleanup.cont

if.then5:                                         ; preds = %if.end
  tail call void @signalError(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @ERR_NOT_PAYABLE, i32 0, i32 0), i32 54) #6
  br label %return

cleanup.cont:                                     ; preds = %if.end
  %call8 = tail call i32 @getArgument(i32 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0)) #6
  %call9 = tail call i32 @getArgument(i32 1, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 0)) #6
  tail call void @computeAllowanceKey(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 0))
  %call10 = tail call i32 @bigIntNew(i64 0) #6
  %call11 = tail call i32 @bigIntStorageLoad(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call10) #6
  tail call void @bigIntFinish(i32 %call10) #6
  br label %return

return:                                           ; preds = %if.then5, %cleanup.cont, %if.then
  ret void
}

; Function Attrs: nounwind
define void @transferToken() local_unnamed_addr #1 {
entry:
  %call = tail call i32 bitcast (i32 (...)* @getNumArguments to i32 ()*)() #6
  %cmp = icmp eq i32 %call, 2
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @signalError(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @ERR_NUM_ARGS, i32 0, i32 0), i32 25) #6
  br label %cleanup.cont28

if.end:                                           ; preds = %entry
  %call1 = tail call i32 @bigIntNew(i64 0) #6
  tail call void @bigIntGetCallValue(i32 %call1) #6
  %call2 = tail call i32 @bigIntNew(i64 0) #6
  %call3 = tail call i32 @bigIntCmp(i32 %call1, i32 %call2) #6
  %cmp4 = icmp sgt i32 %call3, 0
  br i1 %cmp4, label %if.then5, label %cleanup.cont

if.then5:                                         ; preds = %if.end
  tail call void @signalError(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @ERR_NOT_PAYABLE, i32 0, i32 0), i32 54) #6
  br label %cleanup.cont28

cleanup.cont:                                     ; preds = %if.end
  tail call void @getCaller(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0)) #6
  %call8 = tail call i32 @getArgument(i32 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 0)) #6
  %call9 = tail call i32 @bigIntNew(i64 0) #6
  tail call void @bigIntGetSignedArgument(i32 1, i32 %call9) #6
  %call10 = tail call i32 @bigIntNew(i64 0) #6
  %call11 = tail call i32 @bigIntCmp(i32 %call9, i32 %call10) #6
  %cmp12 = icmp slt i32 %call11, 0
  br i1 %cmp12, label %if.then13, label %if.end14

if.then13:                                        ; preds = %cleanup.cont
  tail call void @signalError(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @ERR_TRANSFER_NEG, i32 0, i32 0), i32 34) #6
  br label %cleanup.cont28

if.end14:                                         ; preds = %cleanup.cont
  store i8 1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), align 16, !tbaa !2
  %0 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0), align 16, !tbaa !2
  store i8 %0, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 1), align 1, !tbaa !2
  %1 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 1), align 1, !tbaa !2
  store i8 %1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 2), align 2, !tbaa !2
  %2 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 2), align 2, !tbaa !2
  store i8 %2, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 3), align 1, !tbaa !2
  %3 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 3), align 1, !tbaa !2
  store i8 %3, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 4), align 4, !tbaa !2
  %4 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 4), align 4, !tbaa !2
  store i8 %4, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 5), align 1, !tbaa !2
  %5 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 5), align 1, !tbaa !2
  store i8 %5, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 6), align 2, !tbaa !2
  %6 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 6), align 2, !tbaa !2
  store i8 %6, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 7), align 1, !tbaa !2
  %7 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 7), align 1, !tbaa !2
  store i8 %7, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 8), align 8, !tbaa !2
  %8 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 8), align 8, !tbaa !2
  store i8 %8, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 9), align 1, !tbaa !2
  %9 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 9), align 1, !tbaa !2
  store i8 %9, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 10), align 2, !tbaa !2
  %10 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 10), align 2, !tbaa !2
  store i8 %10, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 11), align 1, !tbaa !2
  %11 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 11), align 1, !tbaa !2
  store i8 %11, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 12), align 4, !tbaa !2
  %12 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 12), align 4, !tbaa !2
  store i8 %12, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 13), align 1, !tbaa !2
  %13 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 13), align 1, !tbaa !2
  store i8 %13, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 14), align 2, !tbaa !2
  %14 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 14), align 2, !tbaa !2
  store i8 %14, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 15), align 1, !tbaa !2
  %15 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 15), align 1, !tbaa !2
  store i8 %15, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 16), align 16, !tbaa !2
  %16 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 16), align 16, !tbaa !2
  store i8 %16, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 17), align 1, !tbaa !2
  %17 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 17), align 1, !tbaa !2
  store i8 %17, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 18), align 2, !tbaa !2
  %18 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 18), align 2, !tbaa !2
  store i8 %18, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 19), align 1, !tbaa !2
  %19 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 19), align 1, !tbaa !2
  store i8 %19, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 20), align 4, !tbaa !2
  %20 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 20), align 4, !tbaa !2
  store i8 %20, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 21), align 1, !tbaa !2
  %21 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 21), align 1, !tbaa !2
  store i8 %21, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 22), align 2, !tbaa !2
  %22 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 22), align 2, !tbaa !2
  store i8 %22, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 23), align 1, !tbaa !2
  %23 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 23), align 1, !tbaa !2
  store i8 %23, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 24), align 8, !tbaa !2
  %24 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 24), align 8, !tbaa !2
  store i8 %24, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 25), align 1, !tbaa !2
  %25 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 25), align 1, !tbaa !2
  store i8 %25, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 26), align 2, !tbaa !2
  %26 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 26), align 2, !tbaa !2
  store i8 %26, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 27), align 1, !tbaa !2
  %27 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 27), align 1, !tbaa !2
  store i8 %27, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 28), align 4, !tbaa !2
  %28 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 28), align 4, !tbaa !2
  store i8 %28, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 29), align 1, !tbaa !2
  %29 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 29), align 1, !tbaa !2
  store i8 %29, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 30), align 2, !tbaa !2
  %30 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 30), align 2, !tbaa !2
  store i8 %30, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 31), align 1, !tbaa !2
  %31 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 31), align 1, !tbaa !2
  store i8 %31, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 32), align 16, !tbaa !2
  %call.i = tail call i32 @keccak256(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), i32 33, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0)) #6
  %call15 = tail call i32 @bigIntNew(i64 0) #6
  %call16 = tail call i32 @bigIntStorageLoad(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call15) #6
  %call17 = tail call i32 @bigIntCmp(i32 %call9, i32 %call15) #6
  %cmp18 = icmp sgt i32 %call17, 0
  br i1 %cmp18, label %if.then19, label %if.end20

if.then19:                                        ; preds = %if.end14
  tail call void @signalError(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @ERR_INSUFFICIENT_FUNDS, i32 0, i32 0), i32 18) #6
  br label %cleanup.cont28

if.end20:                                         ; preds = %if.end14
  tail call void @bigIntSub(i32 %call15, i32 %call15, i32 %call9) #6
  %call21 = tail call i32 @bigIntStorageStore(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call15) #6
  store i8 1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), align 16, !tbaa !2
  %32 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 0), align 16, !tbaa !2
  store i8 %32, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 1), align 1, !tbaa !2
  %33 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 1), align 1, !tbaa !2
  store i8 %33, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 2), align 2, !tbaa !2
  %34 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 2), align 2, !tbaa !2
  store i8 %34, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 3), align 1, !tbaa !2
  %35 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 3), align 1, !tbaa !2
  store i8 %35, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 4), align 4, !tbaa !2
  %36 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 4), align 4, !tbaa !2
  store i8 %36, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 5), align 1, !tbaa !2
  %37 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 5), align 1, !tbaa !2
  store i8 %37, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 6), align 2, !tbaa !2
  %38 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 6), align 2, !tbaa !2
  store i8 %38, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 7), align 1, !tbaa !2
  %39 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 7), align 1, !tbaa !2
  store i8 %39, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 8), align 8, !tbaa !2
  %40 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 8), align 8, !tbaa !2
  store i8 %40, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 9), align 1, !tbaa !2
  %41 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 9), align 1, !tbaa !2
  store i8 %41, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 10), align 2, !tbaa !2
  %42 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 10), align 2, !tbaa !2
  store i8 %42, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 11), align 1, !tbaa !2
  %43 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 11), align 1, !tbaa !2
  store i8 %43, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 12), align 4, !tbaa !2
  %44 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 12), align 4, !tbaa !2
  store i8 %44, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 13), align 1, !tbaa !2
  %45 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 13), align 1, !tbaa !2
  store i8 %45, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 14), align 2, !tbaa !2
  %46 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 14), align 2, !tbaa !2
  store i8 %46, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 15), align 1, !tbaa !2
  %47 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 15), align 1, !tbaa !2
  store i8 %47, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 16), align 16, !tbaa !2
  %48 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 16), align 16, !tbaa !2
  store i8 %48, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 17), align 1, !tbaa !2
  %49 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 17), align 1, !tbaa !2
  store i8 %49, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 18), align 2, !tbaa !2
  %50 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 18), align 2, !tbaa !2
  store i8 %50, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 19), align 1, !tbaa !2
  %51 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 19), align 1, !tbaa !2
  store i8 %51, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 20), align 4, !tbaa !2
  %52 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 20), align 4, !tbaa !2
  store i8 %52, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 21), align 1, !tbaa !2
  %53 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 21), align 1, !tbaa !2
  store i8 %53, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 22), align 2, !tbaa !2
  %54 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 22), align 2, !tbaa !2
  store i8 %54, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 23), align 1, !tbaa !2
  %55 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 23), align 1, !tbaa !2
  store i8 %55, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 24), align 8, !tbaa !2
  %56 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 24), align 8, !tbaa !2
  store i8 %56, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 25), align 1, !tbaa !2
  %57 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 25), align 1, !tbaa !2
  store i8 %57, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 26), align 2, !tbaa !2
  %58 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 26), align 2, !tbaa !2
  store i8 %58, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 27), align 1, !tbaa !2
  %59 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 27), align 1, !tbaa !2
  store i8 %59, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 28), align 4, !tbaa !2
  %60 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 28), align 4, !tbaa !2
  store i8 %60, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 29), align 1, !tbaa !2
  %61 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 29), align 1, !tbaa !2
  store i8 %61, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 30), align 2, !tbaa !2
  %62 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 30), align 2, !tbaa !2
  store i8 %62, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 31), align 1, !tbaa !2
  %63 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 31), align 1, !tbaa !2
  store i8 %63, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 32), align 16, !tbaa !2
  %call.i47 = tail call i32 @keccak256(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), i32 33, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0)) #6
  %call22 = tail call i32 @bigIntNew(i64 0) #6
  %call23 = tail call i32 @bigIntStorageLoad(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call22) #6
  tail call void @bigIntAdd(i32 %call22, i32 %call22, i32 %call9) #6
  %call24 = tail call i32 @bigIntStorageStore(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call22) #6
  tail call void @saveLogWith3Topics(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @transferEvent, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 0), i32 %call9)
  br label %cleanup.cont28

cleanup.cont28:                                   ; preds = %if.then13, %if.end20, %if.then19, %if.then5, %if.then
  ret void
}

declare void @bigIntSub(i32, i32, i32) local_unnamed_addr #2

declare void @bigIntAdd(i32, i32, i32) local_unnamed_addr #2

; Function Attrs: nounwind
define void @approve() local_unnamed_addr #1 {
entry:
  %call = tail call i32 bitcast (i32 (...)* @getNumArguments to i32 ()*)() #6
  %cmp = icmp eq i32 %call, 2
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @signalError(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @ERR_NUM_ARGS, i32 0, i32 0), i32 25) #6
  br label %cleanup.cont18

if.end:                                           ; preds = %entry
  %call1 = tail call i32 @bigIntNew(i64 0) #6
  tail call void @bigIntGetCallValue(i32 %call1) #6
  %call2 = tail call i32 @bigIntNew(i64 0) #6
  %call3 = tail call i32 @bigIntCmp(i32 %call1, i32 %call2) #6
  %cmp4 = icmp sgt i32 %call3, 0
  br i1 %cmp4, label %if.then5, label %cleanup.cont

if.then5:                                         ; preds = %if.end
  tail call void @signalError(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @ERR_NOT_PAYABLE, i32 0, i32 0), i32 54) #6
  br label %cleanup.cont18

cleanup.cont:                                     ; preds = %if.end
  tail call void @getCaller(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0)) #6
  %call8 = tail call i32 @getArgument(i32 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 0)) #6
  %call9 = tail call i32 @bigIntNew(i64 0) #6
  tail call void @bigIntGetSignedArgument(i32 1, i32 %call9) #6
  %call10 = tail call i32 @bigIntNew(i64 0) #6
  %call11 = tail call i32 @bigIntCmp(i32 %call9, i32 %call10) #6
  %cmp12 = icmp slt i32 %call11, 0
  br i1 %cmp12, label %if.then13, label %if.end14

if.then13:                                        ; preds = %cleanup.cont
  tail call void @signalError(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @ERR_ALLOWANCE_NEG, i32 0, i32 0), i32 33) #6
  br label %cleanup.cont18

if.end14:                                         ; preds = %cleanup.cont
  tail call void @computeAllowanceKey(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 0))
  %call15 = tail call i32 @bigIntStorageStore(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call9) #6
  tail call void @saveLogWith3Topics(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @approveEvent, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 0), i32 %call9)
  br label %cleanup.cont18

cleanup.cont18:                                   ; preds = %if.then13, %if.end14, %if.then5, %if.then
  ret void
}

; Function Attrs: nounwind
define void @transferFrom() local_unnamed_addr #1 {
entry:
  %call = tail call i32 bitcast (i32 (...)* @getNumArguments to i32 ()*)() #6
  %cmp = icmp eq i32 %call, 3
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void @signalError(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @ERR_NUM_ARGS, i32 0, i32 0), i32 25) #6
  br label %cleanup.cont37

if.end:                                           ; preds = %entry
  %call1 = tail call i32 @bigIntNew(i64 0) #6
  tail call void @bigIntGetCallValue(i32 %call1) #6
  %call2 = tail call i32 @bigIntNew(i64 0) #6
  %call3 = tail call i32 @bigIntCmp(i32 %call1, i32 %call2) #6
  %cmp4 = icmp sgt i32 %call3, 0
  br i1 %cmp4, label %if.then5, label %cleanup.cont

if.then5:                                         ; preds = %if.end
  tail call void @signalError(i8* getelementptr inbounds ([55 x i8], [55 x i8]* @ERR_NOT_PAYABLE, i32 0, i32 0), i32 54) #6
  br label %cleanup.cont37

cleanup.cont:                                     ; preds = %if.end
  tail call void @getCaller(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 0)) #6
  %call8 = tail call i32 @getArgument(i32 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0)) #6
  %call9 = tail call i32 @getArgument(i32 1, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 0)) #6
  %call10 = tail call i32 @bigIntNew(i64 0) #6
  tail call void @bigIntGetSignedArgument(i32 2, i32 %call10) #6
  %call11 = tail call i32 @bigIntNew(i64 0) #6
  %call12 = tail call i32 @bigIntCmp(i32 %call10, i32 %call11) #6
  %cmp13 = icmp slt i32 %call12, 0
  br i1 %cmp13, label %if.then14, label %if.end15

if.then14:                                        ; preds = %cleanup.cont
  tail call void @signalError(i8* getelementptr inbounds ([35 x i8], [35 x i8]* @ERR_TRANSFER_NEG, i32 0, i32 0), i32 34) #6
  br label %cleanup.cont37

if.end15:                                         ; preds = %cleanup.cont
  tail call void @computeAllowanceKey(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @caller, i32 0, i32 0))
  %call16 = tail call i32 @bigIntNew(i64 0) #6
  %call17 = tail call i32 @bigIntStorageLoad(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call16) #6
  %call18 = tail call i32 @bigIntCmp(i32 %call10, i32 %call16) #6
  %cmp19 = icmp sgt i32 %call18, 0
  br i1 %cmp19, label %if.then20, label %if.end21

if.then20:                                        ; preds = %if.end15
  tail call void @signalError(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @ERR_ALLOWANCE_EXCEEDED, i32 0, i32 0), i32 18) #6
  br label %cleanup.cont37

if.end21:                                         ; preds = %if.end15
  tail call void @bigIntSub(i32 %call16, i32 %call16, i32 %call10) #6
  %call22 = tail call i32 @bigIntStorageStore(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call16) #6
  store i8 1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), align 16, !tbaa !2
  %0 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0), align 16, !tbaa !2
  store i8 %0, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 1), align 1, !tbaa !2
  %1 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 1), align 1, !tbaa !2
  store i8 %1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 2), align 2, !tbaa !2
  %2 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 2), align 2, !tbaa !2
  store i8 %2, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 3), align 1, !tbaa !2
  %3 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 3), align 1, !tbaa !2
  store i8 %3, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 4), align 4, !tbaa !2
  %4 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 4), align 4, !tbaa !2
  store i8 %4, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 5), align 1, !tbaa !2
  %5 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 5), align 1, !tbaa !2
  store i8 %5, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 6), align 2, !tbaa !2
  %6 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 6), align 2, !tbaa !2
  store i8 %6, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 7), align 1, !tbaa !2
  %7 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 7), align 1, !tbaa !2
  store i8 %7, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 8), align 8, !tbaa !2
  %8 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 8), align 8, !tbaa !2
  store i8 %8, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 9), align 1, !tbaa !2
  %9 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 9), align 1, !tbaa !2
  store i8 %9, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 10), align 2, !tbaa !2
  %10 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 10), align 2, !tbaa !2
  store i8 %10, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 11), align 1, !tbaa !2
  %11 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 11), align 1, !tbaa !2
  store i8 %11, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 12), align 4, !tbaa !2
  %12 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 12), align 4, !tbaa !2
  store i8 %12, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 13), align 1, !tbaa !2
  %13 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 13), align 1, !tbaa !2
  store i8 %13, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 14), align 2, !tbaa !2
  %14 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 14), align 2, !tbaa !2
  store i8 %14, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 15), align 1, !tbaa !2
  %15 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 15), align 1, !tbaa !2
  store i8 %15, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 16), align 16, !tbaa !2
  %16 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 16), align 16, !tbaa !2
  store i8 %16, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 17), align 1, !tbaa !2
  %17 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 17), align 1, !tbaa !2
  store i8 %17, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 18), align 2, !tbaa !2
  %18 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 18), align 2, !tbaa !2
  store i8 %18, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 19), align 1, !tbaa !2
  %19 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 19), align 1, !tbaa !2
  store i8 %19, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 20), align 4, !tbaa !2
  %20 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 20), align 4, !tbaa !2
  store i8 %20, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 21), align 1, !tbaa !2
  %21 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 21), align 1, !tbaa !2
  store i8 %21, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 22), align 2, !tbaa !2
  %22 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 22), align 2, !tbaa !2
  store i8 %22, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 23), align 1, !tbaa !2
  %23 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 23), align 1, !tbaa !2
  store i8 %23, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 24), align 8, !tbaa !2
  %24 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 24), align 8, !tbaa !2
  store i8 %24, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 25), align 1, !tbaa !2
  %25 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 25), align 1, !tbaa !2
  store i8 %25, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 26), align 2, !tbaa !2
  %26 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 26), align 2, !tbaa !2
  store i8 %26, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 27), align 1, !tbaa !2
  %27 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 27), align 1, !tbaa !2
  store i8 %27, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 28), align 4, !tbaa !2
  %28 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 28), align 4, !tbaa !2
  store i8 %28, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 29), align 1, !tbaa !2
  %29 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 29), align 1, !tbaa !2
  store i8 %29, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 30), align 2, !tbaa !2
  %30 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 30), align 2, !tbaa !2
  store i8 %30, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 31), align 1, !tbaa !2
  %31 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 31), align 1, !tbaa !2
  store i8 %31, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 32), align 16, !tbaa !2
  %call.i = tail call i32 @keccak256(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), i32 33, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0)) #6
  %call23 = tail call i32 @bigIntNew(i64 0) #6
  %call24 = tail call i32 @bigIntStorageLoad(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call23) #6
  %call25 = tail call i32 @bigIntCmp(i32 %call10, i32 %call23) #6
  %cmp26 = icmp sgt i32 %call25, 0
  br i1 %cmp26, label %if.then27, label %if.end28

if.then27:                                        ; preds = %if.end21
  tail call void @signalError(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @ERR_INSUFFICIENT_FUNDS, i32 0, i32 0), i32 18) #6
  br label %cleanup.cont37

if.end28:                                         ; preds = %if.end21
  tail call void @bigIntSub(i32 %call23, i32 %call23, i32 %call10) #6
  %call29 = tail call i32 @bigIntStorageStore(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call23) #6
  store i8 1, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), align 16, !tbaa !2
  %32 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 0), align 16, !tbaa !2
  store i8 %32, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 1), align 1, !tbaa !2
  %33 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 1), align 1, !tbaa !2
  store i8 %33, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 2), align 2, !tbaa !2
  %34 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 2), align 2, !tbaa !2
  store i8 %34, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 3), align 1, !tbaa !2
  %35 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 3), align 1, !tbaa !2
  store i8 %35, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 4), align 4, !tbaa !2
  %36 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 4), align 4, !tbaa !2
  store i8 %36, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 5), align 1, !tbaa !2
  %37 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 5), align 1, !tbaa !2
  store i8 %37, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 6), align 2, !tbaa !2
  %38 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 6), align 2, !tbaa !2
  store i8 %38, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 7), align 1, !tbaa !2
  %39 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 7), align 1, !tbaa !2
  store i8 %39, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 8), align 8, !tbaa !2
  %40 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 8), align 8, !tbaa !2
  store i8 %40, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 9), align 1, !tbaa !2
  %41 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 9), align 1, !tbaa !2
  store i8 %41, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 10), align 2, !tbaa !2
  %42 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 10), align 2, !tbaa !2
  store i8 %42, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 11), align 1, !tbaa !2
  %43 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 11), align 1, !tbaa !2
  store i8 %43, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 12), align 4, !tbaa !2
  %44 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 12), align 4, !tbaa !2
  store i8 %44, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 13), align 1, !tbaa !2
  %45 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 13), align 1, !tbaa !2
  store i8 %45, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 14), align 2, !tbaa !2
  %46 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 14), align 2, !tbaa !2
  store i8 %46, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 15), align 1, !tbaa !2
  %47 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 15), align 1, !tbaa !2
  store i8 %47, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 16), align 16, !tbaa !2
  %48 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 16), align 16, !tbaa !2
  store i8 %48, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 17), align 1, !tbaa !2
  %49 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 17), align 1, !tbaa !2
  store i8 %49, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 18), align 2, !tbaa !2
  %50 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 18), align 2, !tbaa !2
  store i8 %50, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 19), align 1, !tbaa !2
  %51 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 19), align 1, !tbaa !2
  store i8 %51, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 20), align 4, !tbaa !2
  %52 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 20), align 4, !tbaa !2
  store i8 %52, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 21), align 1, !tbaa !2
  %53 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 21), align 1, !tbaa !2
  store i8 %53, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 22), align 2, !tbaa !2
  %54 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 22), align 2, !tbaa !2
  store i8 %54, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 23), align 1, !tbaa !2
  %55 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 23), align 1, !tbaa !2
  store i8 %55, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 24), align 8, !tbaa !2
  %56 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 24), align 8, !tbaa !2
  store i8 %56, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 25), align 1, !tbaa !2
  %57 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 25), align 1, !tbaa !2
  store i8 %57, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 26), align 2, !tbaa !2
  %58 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 26), align 2, !tbaa !2
  store i8 %58, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 27), align 1, !tbaa !2
  %59 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 27), align 1, !tbaa !2
  store i8 %59, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 28), align 4, !tbaa !2
  %60 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 28), align 4, !tbaa !2
  store i8 %60, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 29), align 1, !tbaa !2
  %61 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 29), align 1, !tbaa !2
  store i8 %61, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 30), align 2, !tbaa !2
  %62 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 30), align 2, !tbaa !2
  store i8 %62, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 31), align 1, !tbaa !2
  %63 = load i8, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 31), align 1, !tbaa !2
  store i8 %63, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 32), align 16, !tbaa !2
  %call.i63 = tail call i32 @keccak256(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @balanceKeyRaw, i32 0, i32 0), i32 33, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0)) #6
  %call30 = tail call i32 @bigIntNew(i64 0) #6
  %call31 = tail call i32 @bigIntStorageLoad(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call30) #6
  tail call void @bigIntAdd(i32 %call30, i32 %call30, i32 %call10) #6
  %call32 = tail call i32 @bigIntStorageStore(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @currentKey, i32 0, i32 0), i32 %call30) #6
  tail call void @saveLogWith3Topics(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @transferEvent, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @sender, i32 0, i32 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @recipient, i32 0, i32 0), i32 %call10)
  br label %cleanup.cont37

cleanup.cont37:                                   ; preds = %if.then14, %if.then27, %if.end28, %if.then20, %if.then5, %if.then
  ret void
}

; Function Attrs: norecurse nounwind readnone
define void @_main() local_unnamed_addr #4 {
entry:
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i32(i8* nocapture writeonly, i8, i32, i1 immarg) #5

attributes #0 = { nofree norecurse nounwind writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-prototype" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { norecurse nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0 (tags/RELEASE_900/final)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
