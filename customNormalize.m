function retval = customNormalize(data)
  min = min(data(:));
  max = max(data(:));
  
  retval = (data - min) / (max - min);
  #retval = ((100-0) / (max-min)) .* (data - min) + 0;
endfunction
