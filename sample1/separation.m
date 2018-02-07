

%% 
data_sorted = sortrows(data_unsorted,1);
temp_sorted = data_sorted(:,1); 
res_sorted = data_sorted(:,2);
scatter(temp_sorted, res_sorted);
%% 
res_linear = res_sorted(find(floor(temp_sorted)==118):length(temp_sorted));
temp_linear = temp_sorted(find(floor(temp_sorted)==118):length(res_sorted));
scatter(temp_linear, res_linear);

dtemp_linear = 0.001*ones(1, length(temp_linear));
dres_linear = 0.015*ones(1, length(res_linear));
lineardata = [temp_linear dtemp_linear' res_linear dres_linear'];
linearTable = array2table(lineardata,'VariableNames',{'x', 'dx', 'y', 'dy'});
writetable(linearTable, "linearDatawError.txt",'Delimiter',' ');


m = [res_linear temp_linear];
csvwrite("linear_region.csv", m);
%% 

res_paracond = res_sorted(find(floor(temp_sorted)==115):find(floor(temp_sorted)==117));
temp_paracond = temp_sorted(find(floor(temp_sorted)==115):find(floor(temp_sorted)==117));
scatter(temp_paracond, res_paracond);

dtemp_paracond = 0.001*ones(1, length(temp_paracond));
dres_paracond = 0.015*ones(1, length(res_paracond));
paraconddata = [temp_paracond dtemp_paracond' res_paracond dres_paracond'];
paracondTable = array2table(paraconddata,'VariableNames',{'x', 'dx', 'y', 'dy'});
writetable(paracondTable, "paracondDatawError.txt",'Delimiter',' ');


p = [temp_paracond res_paracond];
csvwrite("paraconducting_region.csv", p);
%% 

res_supercond = res_sorted(find(floor(temp_sorted)==108):find(floor(temp_sorted)==114));
temp_supercond = temp_sorted(find(floor(temp_sorted)==108):find(floor(temp_sorted)==114));
scatter(temp_supercond, res_supercond);

dtemp_supercond = 0.001*ones(1, length(temp_supercond));
dres_supercond = 0.015*ones(1, length(res_supercond));
superconddata = [temp_supercond dtemp_supercond' res_supercond dres_supercond'];
supercondTable = array2table(superconddata,'VariableNames',{'x', 'dx', 'y', 'dy'});
writetable(supercondTable, "supercondDatawError.txt",'Delimiter',' ');

n = [temp_supercond res_supercond];
csvwrite("superconducting_region", n);
%% 
