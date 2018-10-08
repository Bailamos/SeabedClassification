lines_start = 1;
lines_skip = 5;
lines_end = 140;

load("nbss.mat");
data = vbss;
data = data(1:4, : , 1:140);
data = normalize(data);  

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
  plot(x_axis, v_avg, 'color', 'red');
  hold on;
  plot(x_axis, v_std, 'color', 'blue');
  hold on;
  plot(x_axis, v_max, 'color', 'green');
  hold on;
  plot(x_axis, v_min, 'color', 'black');
  hold on;
  plot(x_axis, v_var, 'color', 'cyan');
  hold on;
  plot(x_axis, v_skewness, 'color', 'yellow');
  
  legend('avg','std','max','min','var','skewness')   
  figure();
end

##for image_number = 1:4;
##
##  x = data(image_number, 1:600, lines_start:lines_end);
##  x = squeeze(x);
##  x = x';
##  v_avg = mean(x);
##  v_std = std(x);
##  v_max = max(x);
##  v_min = min(x);
##  v_var = var(x);
##  v_skewness  = skewness(x);
##
##  plot(1:600, v_avg, 'color', 'red');
##  hold on;
##  plot(1:600, v_std, 'color', 'blue');
##  hold on;
##  plot(1:600, v_max, 'color', 'green');
##  hold on;
##  plot(1:600, v_min, 'color', 'black');
##  hold on;
##  plot(1:600, v_var, 'color', 'cyan');
##  hold on;
##  plot(1:600, v_skewness, 'color', 'yellow');
##  
##  legend('avg','std','max','min','var','skewness')
##  
##  figure();
##end

