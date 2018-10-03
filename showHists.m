function retval = showHists()
  
  load("nbss.mat");
  data = vbss;
  images_data_normalized = normalize(vbss);  

  number_of_images = size(images_data_normalized)(1);
  for image_number = 1:number_of_images;
    i = imhist(images_data_normalized(image_number,:,:));
    plot(i);
    #hold on;
    figure();
  end

endfunction
