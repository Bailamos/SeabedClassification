clear;
colors = ['blue'; 'yellow'; 'green'; 'red'];
load("nbss.mat");
data = vbss;
data = data(:, : , 1:140); 
data = customNormalize(data);  


for skok = 100:10:100 % figure 10 ok ?
  if (skok == 0)
    continue
  endif
%pozioma os do liczenia nachylenia
poziomo = [];
for a =1:abs(skok);
  poziomo = [poziomo;a];
endfor

poziomo2x = [];
for a =1:abs(2*skok);
  poziomo2x = [poziomo2x;a];
endfor


fig  = figure();

for image_number = 1:4;
  x = data(image_number, :, :);
  x = squeeze(x);

  #korelacja
  v_corr = [];
  for line_number = 1:140;
    v_corr = [v_corr, xcorr(x(:, line_number),'coeff')]; 
  endfor
  %koniec korelacji
  
  
  #nachylenie korelacji
  nachylenie = [];
  for iter = 1:140;
    if (skok>0)
      nachylenie_value = polyfit(poziomo2x, v_corr(600:600+(skok*2)-1, iter),1);
    else
      nachylenie_value = polyfit(poziomo2x, v_corr(600:600+abs((skok*2)+1), iter),1);
    end
    nachylenie = [nachylenie, nachylenie_value(2)];
  endfor;
  %koniec nachylenia
  

  #nachylenie z srodka maxa do punktu + skok
  v_max = max(x);
  nachylenie_wartosci = [];
  for line_number = 1:140;
    if (skok>0)
      nachylenie_value = polyfit(poziomo, x(300:300+(skok-1), line_number),1);
    else
      nachylenie_value = polyfit(poziomo, x(300:300+abs(skok+1), line_number),1);
    end
    nachylenie_wartosci = [nachylenie_wartosci, nachylenie_value(2)];
  endfor

  %scatter3(v_max, nachylenie_wartosci, nachylenie, colors(image_number));
  %hold on;
  scatter(v_max, nachylenie_wartosci)
  hold on;
endfor

xlabel('v max');
ylabel('nachylenie wartosci');
zlabel('nachylenie');
endfor