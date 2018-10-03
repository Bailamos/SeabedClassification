#Na jakie obrazy dzielic dane
AREA_SIZE_X = 10;
AREA_SIZE_Y = 10; 

load("nbss.mat");
data = vbss;
images_data_normalized = normalize(vbss);  

number_of_images = size(images_data_normalized)(1);
for image_number = 1:number_of_images;
  image_number
  image_to_proccess = images_data_normalized(image_number,:,:);
  image_to_proccess = squeeze(image_to_proccess);
  
  [image_size_x, image_size_y] = size(image_to_proccess);
  
  vec_x = ones(image_size_x/AREA_SIZE_X, 1);
  vec_x = vec_x .* AREA_SIZE_X;
  vec_y = ones(image_size_y/AREA_SIZE_Y, 1);
  vec_y = vec_y .* AREA_SIZE_Y;

  #podziel obraz na podobrazki o rozmiarze AREA_SIZE_X x AREA_SIZE_Y
  image_subareas = mat2cell(image_to_proccess, vec_x, vec_y);
  
  #dla kazdego podobrazka oblicz odchylenie cwiartkowe i entropie
  [subareas_count_x, subareas_count_y] = size(image_subareas);
  
  for x = 1 : subareas_count_x
    for y = 1 : subareas_count_y
      tmp = cell2mat(image_subareas(x,y));
       
      #quartile_deviation = quartileDeviation(image_to_proccess, tmp);
      #quartile_deviations(x,y) = quartile_deviation;  
      
      deviation = customDeviation(image_to_proccess, tmp);
      deviations(x,y) = deviation;
      
      entropy_var = customEntropy(image_to_proccess, tmp);
      entropies(x, y) = entropy_var;
    end
  end
  
  scatter(deviations, entropies);
  hold on;
end

##xlabel ("quartile deviations");
##ylabel ("entropies");
##legend
print -djpg image.jpg