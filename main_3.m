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
  [v_max, v_max_position] = max(x');
  
##  plot(x(1,:));
##  hold on;
##  plot(v_max_position(1), v_max(1), 'r*');

  #nachylenie z maxa do punktu oddalonego o +10
  m_p = [];
  for line_number = 1:140;  
    
    end_position = v_max_position + 1;
    end_position(end_position > 600) -= 2;
    
    m_p = [m_p; 
      polyfit(
      [v_max_position(line_number), end_position(line_number)], 
      [v_max(line_number), x(line_number, end_position(line_number))], 1)
    ];
      
##    if line_number == 100
##      plot(x(line_number,:));
##      hold on;
##      plot(v_max_position(line_number), v_max(line_number), 'r*');
##      plot(v_max_position(line_number) + 1, x(line_number, end_position(line_number)), 'g*');
##    end
  endfor
  
  #korelacja
  v_corr = [];
  for line_number = 1:140;
    cor_tmp = xcorr(x(line_number, :),'coeff');
    v_corr = [v_corr; polyfit([cor_tmp(600); cor_tmp(605)],[600;605], 1)];
    
##   if line_number == 1
##     plot(cor_tmp);
##     hold on;
##     plot(600, 1, 'r*');
##     plot(700, cor_tmp(700), 'g*');
##     figure();
##   end
  endfor
 
  
  scatter3(v_max, m_p(:,1), v_corr(:,1));
  hold on;
endfor

xlabel('max');
ylabel('m');
zlabel('mcorr');
