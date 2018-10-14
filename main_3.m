clear;
SLOPE_OFFSET = 10;

load("nbss.mat");
data = vbss;
data = data(:, : , 1:140);
data = customNormalize(data);  

for image_number = 1:4;
  image_number
  x = data(image_number, :, :);
  x = squeeze(x);

  #max
  [v_max, v_max_position] = max(x);
  
  #nachylenie z maxa do punktu -10
  slope_end_position = v_max_position + SLOPE_OFFSET;
  slope_end_position(slope_end_position > 600) -= SLOPE_OFFSET * 2;
  v_slope_end = x(slope_end_position);
  m = (v_slope_end - v_max) ./ (slope_end_position - v_max_position);
 
  #korelacja
  v_corr = [];
  for line_number = 1:140;
    v_corr = [v_corr, xcorr(x(:, line_number),'coeff')];
    [v_corr_max, v_corr_max_position] = max(v_corr);   
  endfor
  m_corr = (v_corr(600 + SLOPE_OFFSET,:) - v_corr(600,:))/ SLOPE_OFFSET;
  
  scatter3(v_max, m, m_corr);
  hold on;
endfor

xlabel('max');
ylabel('mmax');
zlabel('mcorr');
