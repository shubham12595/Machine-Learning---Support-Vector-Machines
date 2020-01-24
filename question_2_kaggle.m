%TrainFeatures1 = sortrows(TrainFeatures,1);
%TrainLabels1 = sortrows(TrainLabels,1);
%ValFeatures1 = sortrows(ValFeatures,1)
%ValLabels1 = sortrows(ValLabels,1)
TrainFeatures1=TrainFeatures1{:,2:513};
TestFeatures=TestFeatures{:,2:513};
TrainLabels1=TrainLabels1{:,2:2};
%ValFeatures1=ValFeatures1{:,2:columns};
%ValLabels1=ValLabels1{:,2:2};
[row1,column1] = size(TrainFeatures);
[row2,column2] = size(TrainLabels);

    %disp(TrainLabels{i,2});
for j = 1:4
    for i = 1:row1 
        %disp(j);
        if(TrainLabels1(i) == j)
            %TrainLabels(i,2) =1;
            pred(i,j) = 1;
        else
            %TrainLabels(i,2) = -1;
            pred(i,j) = -1;
        end
    end
end
[t1,t2] = size(TrainFeatures);
[t3,t4] = size(pred);
for i =1:4
    [w,b] = svm(TrainFeatures1',pred(:,i));
    warray(i,:) = w;
    barray(i,:) = b;
end
TrainFeaturestrans = transpose(TrainFeatures1);
for j= 1:4
    for i = 1:4000         
    val(i) = warray(j,:)*transpose(TrainFeatures1(i,:)) + barray(j,:);
    end
    valarray(:,j) = val;
end
claasifier = 0;
prediction = zeros(4000,1);
for i = 1:4000
    max = -1000;
    for j = 1:4
        if valarray(i,j) > max
            max = valarray(i,j);
            class = j;
        end
    end
    prediction(i,1) = class;
end
    
for j= 1:4
    for i = 1:2000         
    val1(i) = warray(j,:)*transpose(TestFeatures(i,:)) + barray(j,:);
    end
    valarray1(:,j) = val1;
end
class1 = 0;
claasifier1 = 0;
prediction1 = zeros(2000,1);
for i = 1:2000
    max = -1000;
    for j = 1:4
        if valarray1(i,j) > max
            max = valarray1(i,j);
            class1 = j;
        end
    end
    prediction1(i,1) = class1;
end  

csvwrite("submissions.csv",prediction1);