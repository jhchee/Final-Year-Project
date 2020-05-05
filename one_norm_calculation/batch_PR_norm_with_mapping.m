%{
    Compute one norm between PR vectors arises from combination of mapping.
    The one norm result will be processed/stored in batch.
%}

disp(strcat("Running '", mfilename, "' ..."));
% split PR vectors into batches and process them individually
num_split_part = 10;
% file name for retrieving experiement data and folder name for storing
% one norm batch data
load('config.mat');
load(strcat("./data/PR_result/solution_invariant/", spec_restart, "_result.mat"));
clear page_rank_score_gene_collection;
% total number of comparison
total_comparison = length(perm_solution_mapping);
% number of one-norm in one batch
batch_size = repelem([floor(total_comparison/num_split_part)], num_split_part);

% if there's remainder (num total comparison isn't evenly divided)
remainder = mod(total_comparison, num_split_part);
for index = 1:remainder
    batch_size(index) = batch_size(index) + 1;
end

% create the one-norm result folder
foldername = strcat("./data/one_norm_batch/solution_invariant/", spec_restart);
if ~exist(foldername, 'dir')
   mkdir(foldername)
end

offset = 0;
for batch_iteration = 1:num_split_part
    current_batch_size = batch_size(batch_iteration);
    page_rank_norm_collection = zeros(current_batch_size, total_comparison);
    disp("Batch " + batch_iteration);
    for subset_iteration = 1:current_batch_size
        % compute one-norm of one vs the rest
        source = page_rank_score_solution_collection(offset+subset_iteration, :);
        source = repmat(source, total_comparison, 1);
        page_rank_norm_collection(subset_iteration, :) = sum(abs(source - page_rank_score_solution_collection), 2);
    end
    offset = offset + current_batch_size;
    save(strcat(foldername, "/batch_", num2str(batch_iteration), ".mat"), "page_rank_norm_collection", '-v7.3'); 
    clear page_rank_norm_collection;
end
