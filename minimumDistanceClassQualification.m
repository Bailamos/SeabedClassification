function retval = minimumDistanceClassQualification (classes, point)
  bestDistance = 100000000;
  bestClass = 1;
  
  for class = 1 : 4
    class_x = classes(class, 1);  
    class_y = classes(class, 2);  
    class_z = classes(class, 3);
    
    point_x = point(1);
    point_y = point(2);
    point_z = point(3);
    
    distance = sqrt((point_x - class_x)^2 + (point_y - class_y)^2 + (point_z - class_z)^2);
    if distance < bestDistance;
      bestDistance = distance;
      bestClass = class; 
    end
  end
  
  retval = bestClass;
end