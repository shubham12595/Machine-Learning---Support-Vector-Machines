[w,b,obj] = svm(trD,trLb)

valtran = valD;
[valr1,valc2]= size(valD);
vallabel = valLb;
for i = 1: valc2
    val(i) = w'*valtran(:,i) +b;
    prediction(i) = sign(val(i));
end
countval = 0;
for i = 1:valc2
    if((val(i)>=-1)&&(val(i)<=1))
        countval = countval+1;
    end
end
objectiveval = obj
supportvectors = countval;
disp("Support Vectors are");
disp(supportvectors);
count = 0;
for i = 1:valc2
    if(prediction(i)==transpose(vallabel(i)))
        count = count+1;
    end
end
accuracy = count/valc2;
disp('Accuracy Score');
disp(accuracy);
confusion_matrix = confusionmat(prediction,vallabel);
disp("Confusion Matrix");
disp(confusion_matrix);
disp("Objective function value ");
disp(objectiveval);



