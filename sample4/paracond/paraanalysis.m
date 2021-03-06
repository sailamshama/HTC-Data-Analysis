%import paraconducting data

%extrapolate linear fit data using parameters found from best fit
p0 = 0.40157;
p1 = 0.0017209;

res_linear_extended = p0 + p1*temp_paracond;
res_difference = res_linear_extended - res_paracond; 

%visualize
subplot(3,1,1);
scatter(temp_paracond, res_linear_extended);
subplot(3,1,2);
scatter(temp_paracond, res_paracond);
subplot(3,1,3);
scatter(temp_paracond, res_difference);

%save difference data into odr script form
dtemp = 0.001*ones(1, length(temp_paracond));
dres_diff = 0.015*ones(1, length(res_difference));
diffdata = [temp_paracond dtemp' res_difference dres_diff'];
csvwrite("diffdata.csv", diffdata);
diffTable = array2table(diffdata,'VariableNames',{'x', 'dx', 'y', 'dy'});
writetable(diffTable, "diffDatawError.txt",'Delimiter',' ');


%sketchy stuff
flipped_temp_paracond = 130 + -1*temp_paracond;
subplot(3,1,1)
scatter(flipped_temp_paracond, res_linear_extended)
subplot(3,1,2)
scatter(flipped_temp_paracond, res_paracond)
subplot(3,1,3)
scatter(flipped_temp_paracond, res_difference)


subplot(4,1,1)
ylabel('res(linear, extrapolated)');
scatter(temp_paracond, res_linear_extended);
subplot(4,1,2);
scatter(temp_paracond, res_paracond);
subplot(4,1,3);
scatter(temp_paracond, res_difference);

supposed_difference = 1./((temp_paracond - 77).^1.1);
subplot(4,1,4);
scatter(temp_paracond, supposed_difference);
xlabel('Paraconducting temperature (K)');