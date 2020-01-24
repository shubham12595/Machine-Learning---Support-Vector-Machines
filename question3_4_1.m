    [trD, trLb, valD, valLb, trRegs, valRegs]=HW4_Utils.getPosAndRandomNeg();
    [w,b] = svm(trD,trLb);
    HW4_Utils.genRsltFile(transpose(w),b,'val','/home/shubham/Downloads/hw4/finx');
    [ap,prec,rec]=HW4_Utils.cmpAP('/home/shubham/Downloads/hw4/finx', 'val');
