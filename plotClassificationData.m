function retval = plotClassificationData (data, colors)  
  for i = 1 : 4
    scatter3(...
      data(i,:,1),...
      data(i,:,2),...
      data(i,:,3), colors(i));       
    hold on;
  endfor
  xlabel('max');
  ylabel('entropy');
  zlabel('nachylenie korelacji');
endfunction