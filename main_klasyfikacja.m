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


#plotClassificationData(classification_params, colors);
#figure();
#plotClasses(nn_classes, colors);

#testing section
for i = 1 : 4
  test_classification_params(i,:,:) = calculateClassificationParams(test_set(i,:,:));  
  current_test_classification_params = squeeze(test_classification_params(i,:,:));  
  
  classes = [];
  for j = 1 : 400
    distance_1 = distanceBetweenPoints(...
                    current_test_classification_params(j,:),
                    nn_classes(1,:));
    distance_2 = distanceBetweenPoints(...
                    current_test_classification_params(j,:),
                    nn_classes(2,:));
    distance_3 = distanceBetweenPoints(...
                    current_test_classification_params(j,:),
                    nn_classes(3,:));
    distance_4 = distanceBetweenPoints(...
                    current_test_classification_params(j,:),
                    nn_classes(4,:));
                    
    [a class] = min([distance_1 distance_2 distance_3 distance_4]);
    classes = [classes; class];     
  endfor

  classification_result(i,:) = classes;
  current_test_classification_params = [current_test_classification_params, classes];
  
  #plotTestData(current_test_classification_params, colors);
endfor



#figure();
#plotClassificationData(test_classification_params, colors);

#saveClassificationResultsToFile(classification_result);
