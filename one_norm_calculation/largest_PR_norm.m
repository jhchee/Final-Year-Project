%{
    Return the list of mapping index that creates the largest PR difference
    w.r.t to the target mapping. Since the largest PR is made up of pairwise comparison
%}

disp(strcat("Running '", mfilename, "' ..."));
load('config.mat');
split_num = 10;
offset = 0;
max_mapping_value_index = {};

for batch_iteration = 1: split_num
    load(strcat("./data/one_norm_batch/solution_invariant/", spec_restart, "/batch_", num2str(batch_iteration), ".mat"), "page_rank_norm_collection");
    current_batch_size = size(page_rank_norm_collection, 1);
    for j = 1:current_batch_size
        M = max(page_rank_norm_collection(j,:));
        [~, col] = find(page_rank_norm_collection(j,:)==M);
        if M == 0 % do not record when max == 0
            col = [];
        end
        max_mapping_value_index = [max_mapping_value_index, {M;{[col]}}];
    end
    offset = offset + current_batch_size;
    clear page_rank_norm_collection;
end
foldername = strcat("./data/analysis/solution_invariant/");
if ~exist(foldername, 'dir')
   mkdir(foldername)
end

% extract largest idx
largest_PR = max([max_mapping_value_index{1,:}]);
largest_idx = find([max_mapping_value_index{1,:}]==largest_PR);

load(strcat("./data/mapping_data/solution_invariant/", spec', "_mapping.mat"));
save(strcat(foldername, spec_restart, "_largest.mat"), "max_mapping_value_index", "perm_solution_mapping", "largest_PR", "largest_idx");




