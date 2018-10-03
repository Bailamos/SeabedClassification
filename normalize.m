function retval = normalize(data)
  min = min(data(:));
  max = max(data(:));
  
  retval = (data - min) / (max - min);
endfunction
