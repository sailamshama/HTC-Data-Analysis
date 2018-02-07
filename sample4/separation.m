%import temperature and resistance data from converted_HTC_Lab5.txt file
%using MATLAB's GUI tools

%check if right data
plot(temp, res)

%get data for separate regions. I wrote down the approximate temperatures
%that divide the graph
% 305 - 146K
res_linear = res(48824:length(res));
temp_linear = temp(48824:length(temp));

% 94K - 128 K
% 39647 - 47614
res_paracond = res(39647:47614);
temp_paracond = temp(39647:47614);

% 67K - 88K
% 1- 32031
res_supercond = res(1: 32031);
temp_supercond = temp(1:32031);
 
%check that data for each region give the right shape
plot(temp_linear, res_linear);
plot(temp_paracond, res_paracond);
plot(temp_supercond, res_supercond);

%save data for each region in separate file (so you can analyse with
%different fitting scripts
m = [res_linear; temp_linear]
csvwrite("linear_region.csv", m)
n = [temp_supercond res_supercond];
csvwrite("superconducting_region", n);
p = [temp_paracond res_paracond];
csvwrite("paraconducting_region", p);

%save linear data in correct format for python script
dtemp_linear = 0.001*ones(1, length(temp_linear));
dres_linear = 0.015*ones(1, length(res_linear));
lineardata = [temp_linear dtemp_linear' res_linear dres_linear'];
linearTable = array2table(lineardata,'VariableNames',{'#x', 'dx', 'y', 'dy'});
writetable(linearTable, "linearDatawError.txt",'Delimiter',' ');

%save superconducting data in correct format for python script
dtemp_supercond = 0.001*ones(1, length(temp_supercond));
dres_supercond = 0.015*ones(1, length(res_supercond));
superconddata = [temp_supercond dtemp_supercond' res_supercond dres_supercond'];
supercondTable = array2table(superconddata,'VariableNames',{'#x', 'dx', 'y', 'dy'});
writetable(supercondTable, "supercondDatawError.txt",'Delimiter',' ');

%save paraconductng data in correct format for python script
dtemp_paracond = 0.001*ones(1, length(temp_paracond));
dres_paracond = 0.015*ones(1, length(res_paracond));
paradata = [temp_paracond dtemp_paracond' res_paracond dres_paracond']
paraTable = array2table(paradata,'VariableNames',{'#x', 'dx', 'y', 'dy'});
writetable(paraTable, "paraDatawError.txt",'Delimiter',' ');


