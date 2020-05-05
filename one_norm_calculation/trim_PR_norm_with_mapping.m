% %{
%     The one-norm result will be symmetric so only one side of the result is
%     computed. The one-norm batch result is trimmed so it only shows right
%     side.
% %}
% 
% clc;
% 
% load('config.mat');
% disp("computing 1-norm between PR vectors")
% 
% % split PR vectors into batches and process them individually
% num_split_part = 10;
% % file name for retrieving experiement data and folder name for storing
% % one norm batch data
% load(strcat("./data/PR_result/solution_invariant/", spec_restart, "_result.mat"));
% 
% % total number of comparison
% total_comparison = length(perm_solution_mapping);
% % number of one-norm in one batch
% batch_size = repelem([floor(total_comparison/num_split_part)], num_split_part);
% 
% % if there's remainder (num total comparison isn't evenly divided)
% remainder = mod(total_comparison, num_split_part);
% for index = 1:remainder
%     batch_size(index) = batch_size(index) + 1;
% end
% 
% % create the one-norm result folder
% foldername = strcat("./data/one_norm_trimmed/", spec_restart);
% if ~exist(foldername, 'dir')
%    mkdir(foldername)
% end
% 
% offset = 0;
% for batch_iteration = 1:num_split_part
%     current_batch_size = batch_size(batch_iteration);
%     width = length(perm_solution_mapping) - offset;
%     page_rank_norm_collection = zeros(current_batch_size, width);
%     disp("Batch " + batch_iteration);
%     for subset_iteration = 1:current_batch_size
%         % compute one-norm of one vs the rest
%         width = width - 1;
%         source = page_rank_score_solution_collection(offset+subset_iteration, :);
%         source = repmat(source, width, 1);
%         page_rank_norm_collection(subset_iteration, subset_iteration+1:end) = sum(abs(source - page_rank_score_solution_collection(offset+subset_iteration+1:end, :)), 2);
%     end
%     offset = offset + current_batch_size;
%     save(strcat(foldername, "/batch_", num2str(batch_iteration), ".mat"), "page_rank_norm_collection", '-v7.3'); 
%     clear page_rank_norm_collection;
% end