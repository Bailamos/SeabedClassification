function retval = quartileDeviation(data)
  q1 = quantile(data(:), 0.25);
  q3 = quantile(data(:), 0.75);
  retval = quartileDeviation = (q3 - q1) / 2;
endfunction
