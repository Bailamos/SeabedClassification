clear;
colors = ['b'; 'g'; 'y'; 'r'];
colors2 = ['r'; 'k'; 'c'; 'm'];
%colors2 = [[0 0 0.5]; [0 0.5 0]; [0.5 0.5 0]; [0.5 00]];
load('nbss.mat');
data = vbss;
data = data(:, : , 1:140);
data = customNormalize(data);  
figure();
learning_set = data(:,1:200,:);
verifying_set = data(:,201:600,:);

nn_classes = [];
for i = 1 : 4
  current_params = classificationParams(learning_set(i,:,:));
  
  classification_params(i,:,:) = current_params;  
  nn_classes = [nn_classes; classNNCalculate(current_params)];
end

for i = 1 : 4
  s1 = scatter3(...
    classification_params(i,:,1),...
    classification_params(i,:,2),...
    classification_params(i,:,3), colors(i));       
  hold on;
 
end

scatter3(...
  nn_classes(:,1),...
  nn_classes(:,2),...
  nn_classes(:,3), 'filled');

hold on;
  
%testing section
for i = 1 : 4
  current_verifying_params = classificationParams(verifying_set(i,:,:));  
  v_classification_params(i,:,:) = current_verifying_params;   
end

for i = 1 : 4
  prompt = 'Click to continue';
  komenda = input(prompt)
  
  scatter3(...
    v_classification_params(i,:,1),...
    v_classification_params(i,:,2),...
    v_classification_params(i,:,3), colors(i));       
  hold on;

end