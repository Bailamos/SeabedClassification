function retval = customEntropy (I, subImage)

  [counts, x] = imhist (I(:), 255);
  
  P = 0;
  subImage_size = size(subImage(:));
  image_size = size(I)(1) * size(I)(2);
  for point_no = 1 : subImage_size
      point = subImage(point_no);
      [min_val, index] = min(abs(x-point));
      P += counts(index) / image_size;
  end
##  [P, xout] = hist (I(:), 255, 1);
##  bin_spacing = xout(2) - xout(1);
##  
##  Y = subImage(10,10);
##  [min_val, index] = min(abs(xout-Y));
##  tmp_n = zeros(size(P));
##  tmp_n(index) = 1;
##  P = P + tmp_n;
##      
##
##  retval += P(n);
retval = P;
endfunction
