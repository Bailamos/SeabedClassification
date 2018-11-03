clear;
colors = ["blue"; "green"; "yellow"; "red"];
#colors2 = [[0 0 0.5]; [0 0.5 0]; [0.5 0.5 0]; [0.5 00]];
load("nbss.mat");
data = vbss;
data = data(:, : , 1:140);
data = customNormalize(data);  

learning_set = data(:,1:200,:);
test_set = data(:,201:600,:);

nn_classes = [];
for i = 1 : 4
  classification_params(i,:,:) = calculateClassificationParams(learning_set(i,:,:));  
  
  nn_classes = [nn_classes; calculateNNClass(squeeze(classification_params(i,:,:)))];
endfor

nnwm_classes = classification_params;

#plotClassificationData(classification_params, colors);
#testing section
#NNClassification(test_set, nn_classes, colors);
NNWMClassification(test_set, nnwm_classes, colors);
