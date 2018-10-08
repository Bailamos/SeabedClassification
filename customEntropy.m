function retval = customEntropy (I, subImage)

  [counts, x] = imhist (I(:), 255);
  
  P = 0;
  subImage_size = size(subImage(:));
  image_size = size(I)(1) * size(I)(2);
  for point_no = 1 : subImage_size
      point = subImage(point_no);
      [min_val, index] = min(abs(x-point));
      P = [P, counts(index) / image_size];
  end
  P(P==0) = []
  retval = -sum (P .* log2 (P));
  #retval = P;
endfunction
