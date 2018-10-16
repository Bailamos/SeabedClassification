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
  
  #nachylenie z maxa do punktu -10
  slope_end_position = v_max_position + SLOPE_OFFSET;
  slope_end_position(slope_end_position > 140);
  v_slope_end = x(slope_end_position);
  m = (v_slope_end - v_max) ./ (slope_end_position - v_max_position);
  
  m_p = [];
  for line_number = 1:600;
    m_p = [m_p; polyfit([v_max_position(line_number); slope_end_position(line_number)],[v_max(line_number); v_slope_end(line_number)],1)];
  endfor
  
  #korelacja
  v_corr = [];
  for line_number = 1:600;
    v_corr = [v_corr, xcorr(x(:, line_number),'coeff')];
  endfor
  m_corr = (v_corr(140 + SLOPE_OFFSET,:) - v_corr(140,:))/ SLOPE_OFFSET;
  
  scatter3(v_max, m_p(:,1), m_corr);
  hold on;
endfor

xlabel('max');
ylabel('m');
zlabel('mcorr');
