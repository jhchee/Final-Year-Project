% group the mappings of the same solution space

disp(strcat("Running '", mfilename, "' ..."));
load('config.mat');
load(strcat("data/mapping_data/solution_invariant/", spec, "_mapping.mat"));

num_mapping = size(perm_solution_mapping, 1);
same_solution_record = cell(num_mapping, 1);
for i = 1:num_mapping
    current_mapping = perm_solution_mapping(i,:);
    sorted_mapping = sort(current_mapping);
    sorted_perm_mapping = sort(perm_solution_mapping')';
    idx = find(ismember(sorted_perm_mapping, sorted_mapping, 'rows')==1);
    same_solution_record{i} = idx;
end

foldername = "data/group_record/same_solution_record/solution_invariant/";
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
save(strcat(foldername, spec, "_solution_record.mat"), 'same_solution_record');