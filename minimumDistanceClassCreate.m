function retval = minimumDistanceClassCreate (data1, data2, data3)
  
  classes = []
  for image_number = 1:4
    images_data = [data1(image_number, :); data2(image_number, :); data3(image_number, :)];
    class = [mean(images_data(1,:)), mean(images_data(2,:)), mean(images_data(3,:))];
    classes = [classes; class];
  end
  
  
  retval = classes;
endfunction
