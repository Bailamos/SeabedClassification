function retval = distanceBetweenPointsBulk (x, y)
  distance = sqrt(sum((x-y).^2,2));
  retval = distance;
endfunction