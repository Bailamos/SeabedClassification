function retval = classificationParams (dataSet)
  [a DATA_COUNT b] = size(dataSet);
  DATA_COUNT
  SLOPE_OFFSET = 10;
  CORR_BEG = 40;
  CORR_END = 100;
  CORR_COUNT = ((CORR_END - CORR_BEG) * 2) + 1;
  CORR_MID = (CORR_COUNT - 1)/ 2 + 1;
  CORR_TO = CORR_MID + 60;
  ENTROPY_NEIGHBOUR = [1 1 1; 1 1 1; 1 1 1];
  
  x = dataSet;
  x = squeeze(x)';
    
  vmax = max(x);
    
  entropies = entropyfilt(x, ENTROPY_NEIGHBOUR);
          
  ventropy = [];
  correlation = [];
  for line_number = 1:DATA_COUNT;
    ventropy = [ventropy; sum(entropies(:, line_number))];
    %ventropy = [ventropy; entropy(x(:,line_number))];
      
    line_data = x(:, line_number);
    %line_data = (line_data - min(line_data)) / (max(line_data) - min(line_data));
    cor_tmp = line_data(CORR_BEG:CORR_END);
    cor_tmp = xcorr(cor_tmp, 'coeff');
    correlation = [correlation; polyfit([CORR_MID; CORR_TO],[cor_tmp(CORR_MID); cor_tmp(CORR_TO)], 1)];
  end
          
  retval = [vmax', ventropy, correlation(:,1)];
end
