function [w,b,obj] = svm(train,yval)
train = double(train);
yval = double(yval);
[r1,c1] = size(train);
[r2,c2] = size(yval);
yvaltrans = yval';
traintrans = transpose(train);
C = 0.1;
mul = (traintrans*train).*(yval*yvaltrans);
%[m1,m2] = size(mul);
H = mul;
%disp('H');
[h1,h2] = size(H);
%disp(h1);   
%disp(h2);
%f(1:c1,1)=-1;
f = -1*(ones(c1,1));
%disp(f);
[s1,s2] = size(f);
%disp(s1);
%disp(s2);
lb=zeros(c1,1);
%disp('lb');
[lb1,lb2] = size(lb);
%disp(lb1);
%disp(lb2);
ub=C * ones(c1,1);
%disp('ub');
[ub1,ub2] = size(ub);
%disp(ub1);
%disp(ub2);
Aeq = yvaltrans;
%disp('Aeq');
[aeq1,aeq2] = size(Aeq);
%disp(aeq1);
%disp(aeq2);
beq = zeros(1,1);
[beq1,beq2] = size(beq);
%disp(beq1);
%disp(beq2);
A=[];
b=[];
[alphavalue,objectiveval]=quadprog(H,f,A,b,Aeq,beq,lb,ub);
w = zeros(r1,1);
b=0;
for i= 1:c1
    w = w + ((alphavalue(i)*yval(i))*train(:,i));
end
for i = 1:c1
    if (alphavalue(i)>0.00001) && (alphavalue(i)<C)
        b = yval(i)-(transpose(train(:,i))*w);
    end
end
obj = -1* objectiveval;
end



