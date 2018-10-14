clear;
lines_start = 1;
lines_skip = 1;
lines_end = 140;

przesuniecie = 0;
skok = 5;
odleglosc = 70;
load("nbss.mat");
data = vbss;
data = data(1:4, : , 1:140);
data = normalize(data);  
colors = ['blue'; 'yellow'; 'green'; 'red'];
nachylenie_maxa = [];
nachylenie_korelacji = [];
pionowy_parametr_1 = [];
pionowy_parametr_2 = [];
nachylenie_wierzcholek = [];
global_max = [];
part_nachylenie_wierzcholek = [];
for image_number = 1:4;

  x = data(image_number, 1:600, lines_start:lines_skip:lines_end);
  x = squeeze(x);

  v_avg = mean(x);
  v_std = std(x);
  v_max = max(x);
  v_min = min(x);
  v_var = var(x);
  v_skewness  = skewness(x);
  x_axis = lines_start:lines_skip:lines_end;

  
  %korelacja dla ka¿dej kolumny
  korelacja_table = [];
  for k=1:140
    kolumna = x(k,:);
    if(przesuniecie!=0)
      korelacja = xcorr(kolumna,przesuniecie,'coeff');
    else
      korelacja = xcorr(kolumna,'coeff');
    endif
    korelacja_table = [korelacja_table;korelacja];
  endfor
  %koniec korelacji


  %nachylenie dla tablicy korelacji
  roznica = 0;
  ilos_skow = 140/skok;
  nachylenie_table = [];
  for numer = 0:ilos_skow
    a = 1+numer*skok;
    b = 1+skok+numer*skok;
    if(b>140)
      roznica = b - 140;
      b = b - roznica;
    endif
    x_kor = korelacja_table(a:b);
    y_ax = 1:1+skok-roznica;
    te = polyfit(x_kor,y_ax,1);
    nachylenie = te(1);
    nachylenie_table = [nachylenie_table,nachylenie];
  endfor
  %koniec nachylenia dla tablicy korelacji

  %nachylenie nr 2 - dla dowolnego parametru 
  nachylenie_table2 = [];
  roznica = 0;
  for numer = 0:ilos_skow
    a = 1+numer*skok;
    b = 1+skok+numer*skok;
    if(b>140)
      roznica = b - 140;
      b = b - roznica;
    endif
    x_ax = v_std(a:b);  %dowolny parametr
    y_ax = 1:1+skok-roznica;
    wartosc_x = polyfit(x_ax,y_ax,1);
    nachylenie = wartosc_x(1);
    nachylenie_table2 = [nachylenie_table2, nachylenie];
  endfor  
  %koniec nachylenia nr 2 dla dowolnego parametru 
  
 %nachylenie nr 3 - od wierzcho³ka z korelacji 
  nachylenie_table3 = [];
  part = [];
  srodek = (size(korelacja_table))(2);
  srodek = (srodek + 1) / 2;
  for k=1:140
    x_ax = korelacja_table(k,srodek:srodek+odleglosc-1);
    y_ax = 1:odleglosc;
    wartosc_x = polyfit(x_ax,y_ax,1);
    nachylenie = wartosc_x(1);
    nachylenie_table3 = [nachylenie_table3, nachylenie];
    if(mod(k,skok)==1)
      part = [part,nachylenie];
    endif
  endfor
    %koniec nachylenia nr 3 - od wierzcho³ka z korelacji 
  
  %wartosci do osi y
    pionowe = v_max(1:skok:140);
    pionowy_parametr_1 = [pionowy_parametr_1; pionowe];
    
  %wartosci do osi y
    pionowe2 = v_avg(1:skok:140);
    pionowy_parametr_2 = [pionowy_parametr_2; pionowe2];
    
    %wyrownanie rozmiarow
    [nx ny] = size(nachylenie_table);
    [px py] = size(pionowe);
    if(ny>py)
     nachylenie_table = nachylenie_table(1:py);
     nachylenie_table2 = nachylenie_table2(1:py);
    endif
    
    %globalne tablice
    global_max = [global_max;v_max];
  nachylenie_korelacji = [nachylenie_korelacji;nachylenie_table];
  nachylenie_maxa = [nachylenie_maxa;nachylenie_table2];
  nachylenie_wierzcholek = [nachylenie_wierzcholek;nachylenie_table3];
  %
  part_nachylenie_wierzcholek = [part_nachylenie_wierzcholek; part];
end
#rysowanie wykresow
%1
  for iter=1:4 
    scatter(nachylenie_korelacji(iter,:,:),pionowy_parametr_1(iter,:),"filled",colors(iter));
    hold on;
  endfor
  %2
  figure();
  for iter=1:4
    scatter(nachylenie_maxa(iter,:,:),pionowy_parametr_1(iter,:),"filled",colors(iter));
    hold on;
  endfor
    %3
  figure();
    for iter=1:4
    scatter(nachylenie_korelacji(iter,:,:),nachylenie_maxa(iter,:,:),"filled",colors(iter));
    hold on;
  endfor
    %4
  figure();
  for iter=1:4
    scatter(nachylenie_wierzcholek(iter,:,:),global_max(iter,:,:),"filled",colors(iter));
    hold on;
  endfor
    %5
  figure();
  for iter=1:4
    scatter(part_nachylenie_wierzcholek(iter,:,:),nachylenie_korelacji(iter,:,:),"filled",colors(iter));
    hold on;
  endfor
    %6
  figure();
  for iter=1:4
    scatter(part_nachylenie_wierzcholek(iter,:,:),nachylenie_maxa(iter,:,:),"filled",colors(iter));
    hold on;
  endfor
    %7
  figure();
  for iter=1:4
    scatter(part_nachylenie_wierzcholek(iter,:,:),pionowy_parametr_1(iter,:,:),"filled",colors(iter));
    hold on;
  endfor
    %8
  figure();
  for iter=1:4
    scatter(part_nachylenie_wierzcholek(iter,:,:),pionowy_parametr_2(iter,:,:),"filled",colors(iter));
    hold on;
  endfor