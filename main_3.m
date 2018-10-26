clear;
SLOPE_OFFSET = 10;
CORR_BEG = 40;
CORR_END = 100;
CORR_COUNT = ((CORR_END - CORR_BEG) * 2) + 1;
CORR_MID = (CORR_COUNT - 1)/ 2 + 1;
CORR_TO = CORR_MID + 10;
ENTROPY_NEIGHBOUR = [1 1 1; 1 1 1; 1 1 1];
colors = ["blue"; "green"; "yellow"; "red"];
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
  entropies = entropyfilt(x, ENTROPY_NEIGHBOUR);
  m_p = [];
  for line_number = 1:600; 
      m_p = [m_p; sum(entropies(:,line_number))];
      
##    line_data = x(:, line_number);
##    line_data = (line_data - min(line_data)) / (max(line_data) - min(line_data));
##    [maxv, max_pos] = max(line_data);
##    m_p = [m_p; 
##      polyfit(
##      [max_pos, max_pos + 10], 
##      [maxv, line_data(v_max_position(line_number) + 10)], 1)
##    ];
##      m_p = [m_p; std(x(40:100, line_number))];
##        m_p = [m_p; skewness(x(:, line_number))];
##      m_p = [m_p; entropy(x(:,line_number))];     
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
    line_data = x(:, line_number);
    line_data = (line_data - min(line_data)) / (max(line_data) - min(line_data));
    cor_tmp = line_data(CORR_BEG:CORR_END);
    cor_tmp = xcorr(cor_tmp, 'coeff');
    v_corr = [v_corr; polyfit([CORR_MID; CORR_TO],[cor_tmp(CORR_MID); cor_tmp(CORR_TO)], 1)];
    
##   if line_number == 1
##     plot(cor_tmp);
##     hold on;
##     plot(CORR_MID, 1, 'r*');
##     plot(CORR_TO, cor_tmp(CORR_TO), 'g*');
##     figure();
##   end
  endfor
 
  
  scatter3(v_max, m_p(:),v_corr(:,1),colors(image_number));
  hold on;
endfor

xlabel('max');
ylabel('entropia');
zlabel('nachylenie korelacji');
