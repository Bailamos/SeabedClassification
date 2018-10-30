function retval = customNormalize(data)
  mini = min(data(:));
  maxi = max(data(:));
  
  retval = (data - mini) / (maxi - mini);
  %retval = ((100-0) / (max-min)) .* (data - min) + 0;
end
