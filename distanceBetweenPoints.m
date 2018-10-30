function retval = distanceBetweenPoints (x, y)
  distance = sqrt(sum((x-y).^2));
  retval = distance;
endfunction