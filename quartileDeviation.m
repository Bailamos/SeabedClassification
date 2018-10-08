function retval = quartileDeviation(Image)
  
  q1 = quantile(Image, 0.25);
  q3 = quantile(Image, 0.75);
  
  retval = (q3 - q1) / 2;
endfunction
