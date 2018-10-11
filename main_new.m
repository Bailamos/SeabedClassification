clear;
lines_start = 1;
lines_skip = 1;
lines_end = 140;
x_axis = lines_start:lines_skip:lines_end;

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

  
  v_avg =  vec2mat(v_avg, 10);
  skewness_avg(image_number, :) = skewness(v_avg');
  
  v_std =  vec2mat(v_std, 10);
  skewness_std(image_number, :) = skewness(v_std');
  
  v_max =  vec2mat(v_max, 10);
  skewness_max(image_number, :) = skewness(v_max');
  
  v_min =  vec2mat(v_min, 10);
  skewness_min(image_number, :) = skewness(v_min');
end

scatter(skewness_min(1,:), skewness_std(1,:))
hold on;
scatter(skewness_min(2,:), skewness_std(2,:))
hold on;
scatter(skewness_min(3,:), skewness_std(3,:))
hold on;
scatter(skewness_min(4,:), skewness_std(4,:))


