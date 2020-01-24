[trD, trLb, valD, valLb, trRegs, valRegs] = HW4_Utils.getPosAndRandomNeg();
PosD = [];
PosLb=[];
NegD = [];
NegLb = [];
for s= 1:size(trD,2)
	if(trLb(s)== 1)
		PosD = double([PosD,trD(:,s)]);
		PosLb = [PosLb;trLb(s)];
    elseif(trLb == -1)
        NegD = double([NegD,trD(:,g)]);
		NegLb = [NegLb;trLb(g)];    
	end
end
[w, b,obj] = svm(trD, trLb);
APval = zeros(10, 1);
Objectiveval = zeros(10, 1);
load(sprintf('%s/%sAnno.mat', HW4_Utils.dataDir, "train"), 'ubAnno');
for i =1:10
	index = [];
	for l = 1:size(trD,2)
    	if(trLb(l,:) ~=-1)
        	index =[index,l];
    	end
	end
	trD = trD(:,index);
	trLb = trLb(index,:);
	NegDListnew = [];
	for j = 1:93
		ubval = ubAnno{j};
		im = sprintf('%s/trainIms/%04d.jpg', HW4_Utils.dataDir, j);
        im = imread(im);
        [imrow1, imcol1, ~] = size(im);
        rect = HW4_Utils.detect(im, w, b);
        Negativereg = rect(:,1:(sum(rect(end,:)>0)));
        example=[];
        for d=1:size(Negativereg,2)
            if Negativereg(3,d)< imcol1 && Negativereg(4,d)<imrow1
                example=[example,d];
            end
        end
        Negativereg = Negativereg(:,example);
        for e = 1:size(ubval,2)
            Negativereg = Negativereg(:, (HW4_Utils.rectOverlap(Negativereg, ubval(:,e))) < 0.3);
       	end
        for e= 1: size(Negativereg,2)
        	ext = Negativereg(:,e);
            l1 = ext(1);
            l2 = ext(2);
            l3= ext(3);
            l4 = ext(4);
        	imaex = im(l2:l4, l1:l3,:);
            imaex = imresize(imaex, HW4_Utils.normImSz);
            hardNeg = HW4_Utils.l2Norm(HW4_Utils.cmpFeat(rgb2gray(imaex)));
            NegDListnew = [NegDListnew, hardNeg];
        end
        if size(NegDListnew, 2) > 1000
            break;
        end
    end
    new = -1*ones(size(NegDListnew,2),1);
    trD = [trD, NegDListnew];
    trLb = [trLb; new];
    [w, b,obj] = svm(trD, trLb);
    HW4_Utils.genRsltFile(w, b, "val", "valvalue");
    [ap, ~, ~] = HW4_Utils.cmpAP("valvalue", "val");
    APval(i) = ap;
    Objectiveval(i) = obj;
end
disp("Objective Function Values:");
disp(Objectiveval);
disp("AP Values:");
disp(APval);
iter = 1 : 10;
iter = iter(:);
figure
plot(iter, Objectiveval);
title('Objective Value Plot');
xlabel('Iteration');
ylabel('Objective Values')
figure
plot(iter, APval);
title('AP values plot');
xlabel('Iteration');
ylabel('APs');
