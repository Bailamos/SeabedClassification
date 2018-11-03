function retval = NNWMClassification (test_set, nnwm_classes, colors) 
   for i = 1 : 4
       classes = [];
      test_classification_params(i,:,:) = calculateClassificationParams(test_set(i,:,:));  
      current_test_classification_params = squeeze(test_classification_params(i,:,:));  
    
      for j = 1 : 400
        distance_1 = min(distanceBetweenPointsBulk(...
                        current_test_classification_params(j,:),
                        squeeze(nnwm_classes(1,:,:))));
        distance_2 = min(distanceBetweenPointsBulk(...
                        current_test_classification_params(j,:),
                        squeeze(nnwm_classes(2,:,:))));
        distance_3 = min(distanceBetweenPointsBulk(...
                        current_test_classification_params(j,:),
                        squeeze(nnwm_classes(3,:,:))));
        distance_4 = min(distanceBetweenPointsBulk(...
                        current_test_classification_params(j,:),
                        squeeze(nnwm_classes(4,:,:))));
                        
        [a class] = min([distance_1 distance_2 distance_3 distance_4]);
        classes = [classes; class];     
      endfor
      classification_result(i,:) = classes;
      current_test_classification_params = [current_test_classification_params, classes];
      plotTestData(current_test_classification_params, colors);
   endfor
   
  saveClassificationResultsToFile(classification_result);
endfunction
