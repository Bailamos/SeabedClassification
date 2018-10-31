function retval = plotTestData (data, colors)  
  c1 = find(data(:,4)==1)';
  c2 = find(data(:,4)==2)';
  c3 = find(data(:,4)==3)';
  c4 = find(data(:,4)==4)';
  
  d1 = data(c1,1:3);
  d2 = data(c2,1:3);
  d3 = data(c3,1:3);
  d4 = data(c4,1:3);
  
  scatter3(d1(:,1),d1(:,2),d1(:,3), colors(1));
  xlabel('max');
  ylabel('entropy');
  zlabel('nachylenie korelacji');
  hold on;
  scatter3(d2(:,1),d2(:,2),d2(:,3), colors(2));
  scatter3(d3(:,1),d3(:,2),d3(:,3), colors(3));
  scatter3(d4(:,1),d4(:,2),d4(:,3), colors(4));
  

endfunction
