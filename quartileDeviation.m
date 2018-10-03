function retval = quartileDeviation(Image, subImage)
  
  q1i = quantile(Image(:), 0.25);
  q3i = quantile(Image(:), 0.75);
  
  q1 = quantile(subImage(:), 0.25);
  q3 = quantile(subImage(:), 0.75);
  
  retval = quartileDeviation = ((q3 - q1) / 2) / ((q3i - q1i) / 2);
endfunction
