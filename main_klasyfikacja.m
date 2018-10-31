clear;
colors = ["blue"; "green"; "yellow"; "red"];
#colors2 = [[0 0 0.5]; [0 0.5 0]; [0.5 0.5 0]; [0.5 00]];
load("nbss.mat");
data = vbss;
data = data(:, : , 1:140);
data = customNormalize(data);  

learning_set = data(:,1:200,:);
verifying_set = data(:,201:600,:);

nn_classes = [];
for i = 1 : 4
  current_params = classificationParams(learning_set(i,:,:));
  
  classification_params(i,:,:) = current_params;  
  nn_classes = [nn_classes; classNNCalculate(current_params)];
endfor


##for i = 1 : 4
##  s1 = scatter3(...
##    classification_params(i,:,1),...
##    classification_params(i,:,2),...
##    classification_params(i,:,3), colors(i));       
##  hold on;
##endfor
##xlabel('max');
##ylabel('entropy');
##zlabel('nachylenie korelacji');

for i = 1 : 4
scatter3(...
  nn_classes(i,1),...
  nn_classes(i,2),...
  nn_classes(i,3), 'filled', 'MarkerFaceColor', colors(i));
  hold on;  
endfor

  
#testing section
for i = 1 : 4
  current_verifying_params = classificationParams(verifying_set(i,:,:));  
  v_classification_params(i,:,:) = current_verifying_params;  
  
  classes = [];
  tmp = [];
  for j = 1 : 400
    distance_1 = distanceBetweenPoints(...
                    current_verifying_params(j,:),
                    nn_classes(1,:));
    distance_2 = distanceBetweenPoints(...
                    current_verifying_params(j,:),
                    nn_classes(2,:));
    distance_3 = distanceBetweenPoints(...
                    current_verifying_params(j,:),
                    nn_classes(3,:));
    distance_4 = distanceBetweenPoints(...
                    current_verifying_params(j,:),
                    nn_classes(4,:));
                    
    [a class] = min([distance_1 distance_2 distance_3 distance_4]);
    classes = [classes; class];
    
##    scatter3(...
##      current_verifying_params(j,1),...
##      current_verifying_params(j,2),...
##      current_verifying_params(j,3), colors(class));    
  endfor

  classification_result(i,:) = classes;
endfor


for i = 1 : 4 
##  scatter3(...
##    v_classification_params(i,:,1),...
##    v_classification_params(i,:,2),...
##    v_classification_params(i,:,3), colors(i));       
##  hold on;
endfor

xlabel('max');
ylabel('entropy');
zlabel('nachylenie korelacji');



fileID = fopen(['results-' num2str(now) '.txt'],'w');

x = classification_result(1,:);
s = ['Rezultat klasyfikacji dna pierwszego:\n'...
     'Poprawnie sklasyfikowane ' num2str(size(x(x==1))(2))...
     '\n Zklasyfikowane jako dno drugie ' num2str(size(x(x==2))(2))...
     '\n Zklasyfikowane jako dno trzecie ' num2str(size(x(x==3))(2))...
     '\n Zklasyfikowane jako dno czwarte ' num2str(size(x(x==4))(2))...
     '\n Poprawnosc ' num2str((size(x(x==1))/400)(2)) '\n'];
fprintf(fileID, s);

x = classification_result(2,:);
s = ['Rezultat klasyfikacji dna drugiego:\n'...
     'Poprawnie sklasyfikowane ' num2str(size(x(x==2))(2))...
     '\n Zklasyfikowane jako dno pierwsze ' num2str(size(x(x==1))(2))...
     '\n Zklasyfikowane jako dno trzecie ' num2str(size(x(x==3))(2))...
     '\n Zklasyfikowane jako dno czwarte ' num2str(size(x(x==4))(2))...
     '\n Poprawnosc ' num2str((size(x(x==2))/400)(2)) '\n'];
fprintf(fileID, s);
     
x = classification_result(3,:);
s = ['Rezultat klasyfikacji dna trzeciego:\n'...
     'Poprawnie sklasyfikowane ' num2str(size(x(x==3))(2))...
     '\n Zklasyfikowane jako dno pierwsze ' num2str(size(x(x==1))(2))...
     '\n Zklasyfikowane jako dno drugie ' num2str(size(x(x==2))(2))...
     '\n Zklasyfikowane jako dno czwarte ' num2str(size(x(x==4))(2))...
     '\n Poprawnosc ' num2str((size(x(x==3))/400)(2)) '\n'];
fprintf(fileID, s);

x = classification_result(4,:);
s = ['Rezultat klasyfikacji dna czwartego:\n'...
     'Poprawnie sklasyfikowane ' num2str(size(x(x==4))(2))...
     '\n Zklasyfikowane jako dno pierwsze ' num2str(size(x(x==1))(2))...
     '\n Zklasyfikowane jako dno drugie ' num2str(size(x(x==2))(2))...
     '\n Zklasyfikowane jako dno czwarte ' num2str(size(x(x==3))(2))...
     '\n Poprawnosc ' num2str((size(x(x==4))/400)(2)) '\n'];
fprintf(fileID, s);

fclose(fileID);
