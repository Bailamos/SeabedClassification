function retval = customDeviation (I, subImage)
  avg = sum(I(:)) / (size(I)(1) * size(I)(2));
  
  D = (subImage - avg).^2;
  
  deviation = sqrt(sum(D) /  size(subImage(:))(1));
  
  retval = deviation;
endfunction
