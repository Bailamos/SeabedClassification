function retval = plotClassificationData (data, colors)  
  for i = 1 : 4
    scatter3(...
      data(i,:,1),...
      data(i,:,2),...
      data(i,:,3), colors(i));       
    hold on;
  endfor
  xlabel('wartosc maksymalna');
  ylabel('entropia');
  zlabel('nachylenie autokorelacji');
  legend ({"mul",...
    "antropogeniczy piasek i mul",...
    "piasek drobnoziarnisty",...
    "piasek gruboziarnisty"});
  legend show;
  title (["Rozklad dla parametrow:"...
         "entropia, wartosc maksymalna oraz nacyhlenie autokorelacji"]);
  view(-100,30)
  print -djpg izmometryczny.jpg
  #entropia/naychlenie
  #view(90,0)
  #print -djpg rzut1.jpg
  #entropia/wartosc maksymalna
  #view(0,90)
  #print -djpg rzut2.jpg
  #nacyhlenie/wartosc maksymalna 
  #view(0,0)
  #print -djpg rzut3.jpg
endfunction
