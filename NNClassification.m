function retval = NNClassification (test_set, nn_classes, colors) 
  figure();
  plotClasses(nn_classes, colors);
  
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
    
    plotTestData(current_test_classification_params, colors);
  endfor

  saveClassificationResultsToFile(classification_result);
endfunction
