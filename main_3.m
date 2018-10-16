clear;
SLOPE_OFFSET = 10;

load("nbss.mat");
data = vbss;
data = data(:, : , 1:140);
data = customNormalize(data);  

for image_number = 1:4;
  image_number
  x = data(image_number, :, :);
  x = squeeze(x)';

  #max
  [v_max, v_max_position] = max(x);
  
##  plot(x(:,1));
##  hold on;
##  plot(v_max_position(1), v_max(1), 'r*');

  #nachylenie z maxa do punktu oddalonego o +10
  m_p = [];
  for line_number = 1:600;  
    m_p = [m_p; 
      polyfit(
      [v_max_position(line_number), v_max_position(line_number) + 10], 
      [v_max(line_number), x(v_max_position(line_number) + 10, line_number)], 1)
    ];
      
##    if line_number == 500
##      plot(x(:,line_number));
##      hold on;
##      plot(v_max_position(line_number), v_max(line_number), 'r*');
##      plot(v_max_position(line_number) + 10, x(v_max_position(line_number) + 10, line_number), 'g*');
##    end
  endfor
  
  #korelacja
  v_corr = [];
  for line_number = 1:600;
    cor_tmp = xcorr(x(:, line_number),'coeff');
    v_corr = [v_corr; polyfit([cor_tmp(140); cor_tmp(145)],[140;145], 1)];
    
##   if line_number == 1
##     plot(cor_tmp);
##     hold on;
##     plot(140, 1, 'r*');
##     plot(145, cor_tmp(145), 'g*');
##     figure();
##   end
  endfor
 
  
  scatter3(v_max, m_p(:,1), v_corr(:,1));
  hold on;
endfor

xlabel('max');
ylabel('m');
zlabel('mcorr');
