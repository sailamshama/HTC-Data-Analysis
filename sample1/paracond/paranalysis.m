%import paraconducting data

%extrapolate linear fit data using parameters found from best fit
p0 = 0.044262;
p1 = 0.0020505;

res_linear_extended = p0 + p1*temp_paracond;
res_difference = res_linear_extended - res_paracond; 
%% 

%visualize
subplot(4,1,1)
ylabel('res(linear, extrapolated)');
scatter(temp_paracond, res_linear_extended);
subplot(4,1,2);
scatter(temp_paracond, res_paracond);
subplot(4,1,3);
scatter(temp_paracond, res_difference);

%% 

%save difference data into odr script form
dtemp = 0.001*ones(1, length(temp_paracond));
dres_diff = 0.015*ones(1, length(res_difference));
diffdata = [temp_paracond dtemp' res_difference dres_diff'];
csvwrite("diffdata.csv", diffdata);
diffTable = array2table(diffdata,'VariableNames',{'x', 'dx', 'y', 'dy'});
writetable(diffTable, "diffDatawError.txt",'Delimiter',' ');
