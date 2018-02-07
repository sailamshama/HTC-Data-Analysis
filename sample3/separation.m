%import data
%res = table2array(resistance);
%temp = table2array(temperature);

%sort data 

%%%% BAD IDEA %%%%%
%res = sort(res);
%temp = sort(temp);
%plot(temp,res) %<- not the same anymore
%%%%%%%%%%%%%%%%%%%

% temp_unsorted = data_unsorted(:,1);
% res_unsorted = data_unsorted(:,2);
% 
% trim1_unsorted = find(floor(temp_unsorted) == 105,1);
% trim2_unsorted = find(floor(temp_unsorted) == 108, 1);
% res_unsorted_trimmed = [res_unsorted(1:trim1); res_unsorted(trim2:length(res_unsorted))];
% temp_unsorted_trimmed = [temp_unsorted(1:trim1); temp_unsorted(trim2:length(temp_unsorted))];


data_sorted = sortrows(data,1);
temp_sorted = data_sorted(:,1); 
res_sorted = data_sorted(:,2);

%checking that both sorted and unsorted data plot the same
% subplot(2, 1, 1)
% scatter(temp_unsorted, res_unsorted)
% subplot(2,1,2)
% scatter(temp_sorted, res_sorted)

%trim bad data
trim1_sorted = find(floor(temp_sorted) == 105,1);
trim2_sorted = find(floor(temp_sorted) == 108, 1);
res_sorted_trimmed = [res_sorted(1:trim1_sorted); res_sorted(trim2_sorted:length(res_sorted))];
temp_sorted_trimmed = [temp_sorted(1:trim1_sorted); temp_sorted(trim2_sorted:length(temp_sorted))];

%plot to verify data has been trimmed
scatter(temp_sorted_trimmed, res_sorted_trimmed);

%save sorted and filtered data
new_data = [temp_sorted_trimmed res_sorted_trimmed];
csvwrite("sorted_filtered_data.csv", new_data);


%find linear region
res_linear = res_sorted_trimmed(find(floor(temp_sorted_trimmed)==108):length(temp_sorted_trimmed));
temp_linear = temp_sorted_trimmed(find(floor(temp_sorted_trimmed)==108):length(temp_sorted_trimmed));
scatter(temp_linear, res_linear);

dtemp_linear = 0.001*ones(1, length(temp_linear));
dres_linear = 0.015*ones(1, length(res_linear));
lineardata = [temp_linear dtemp_linear' res_linear dres_linear'];
linearTable = array2table(lineardata,'VariableNames',{'x', 'dx', 'y', 'dy'});
writetable(linearTable, "linearDatawError.txt",'Delimiter',' ');

%find paraconducting region
res_paracond = res_sorted_trimmed(find(floor(temp_sorted_trimmed)==88):find(floor(temp_sorted_trimmed)==105));
temp_paracond = temp_sorted_trimmed(find(floor(temp_sorted_trimmed)==88):find(floor(temp_sorted_trimmed)==105));
scatter(temp_paracond, res_paracond);

dtemp_paracond = 0.001*ones(1, length(temp_paracond));
dres_paracond = 0.015*ones(1, length(res_paracond));
paraconddata = [temp_paracond dtemp_paracond' res_paracond dres_paracond'];
paracondTable = array2table(paraconddata,'VariableNames',{'x', 'dx', 'y', 'dy'});
writetable(paracondTable, "paracondDatawError.txt",'Delimiter',' ');

%find superconducting region
%not a great region here
res_supercond = res_sorted_trimmed(1:find(floor(temp_sorted_trimmed)==84));
temp_supercond = temp_sorted_trimmed(1:find(floor(temp_sorted_trimmed)==84));
scatter(temp_supercond, res_supercond);

dtemp_supercond = 0.001*ones(1, length(temp_supercond));
dres_supercond = 0.015*ones(1, length(res_supercond));
superconddata = [temp_supercond dtemp_supercond' res_supercond dres_supercond'];
supercondTable = array2table(superconddata,'VariableNames',{'x', 'dx', 'y', 'dy'});
writetable(supercondTable, "supercondDatawError.txt",'Delimiter',' ');
