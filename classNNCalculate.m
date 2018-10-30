function retval = classNNCalculate (dataSet)

  x = mean(dataSet(:,1));
  y = mean(dataSet(:,2));
  z = mean(dataSet(:,3));
  
  retval = [x, y, z];
end
