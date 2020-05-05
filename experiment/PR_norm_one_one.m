% PageRank norm analysis for one-to-one mapping
% This contributes to the experiment in 3.2.1
% "Describe structural difference in coevolutionary chain 
% with PageRank (in respect of one-to-one mapping)"

close all;
clc;
load("config.mat")
load(strcat("./data/PR_result/solution_invariant/", spec_restart, "_result.mat"));
load(strcat("./data/analysis/abs_chain_stats/", spec, "_abs_stat.mat"));

size_mapping = size(page_rank_score_solution_collection,1);
largest_contributor = zeros(size_mapping, size_mapping);
largest_contributor_percentage = zeros(size_mapping, size_mapping);
each_solution_contributor_percentage = zeros(size_mapping, size_mapping, 8);

% the stats preparation
for i = 1:size_mapping
    source_page_rank = page_rank_score_solution_collection(i,:);
    for j = 1:size_mapping
        target_page_rank = page_rank_score_solution_collection(j,:);
        diff = source_page_rank-target_page_rank;
        each_solution_contributor_percentage(i,j,:) = diff;
        [~, index] = max(abs(diff));
        largest_contributor(i,j) = index;
        largest_contributor_percentage(i,j) = diff(index)/sum(abs(diff));
    end
end

% draw result from stats
fig_num = 0;


%%
% % count the norm contribution from each solution
% % plot a graph on these stats

% count_mean_weight_solutions = [];
% box_result_1 = [];
% for i = 1:8
%     abs_weight_solution = reshape(abs(each_solution_contributor_percentage(:,:,i)) , [], 1);
%     count_mean_weight_solutions = [count_mean_weight_solutions, abs_weight_solution];
%     label = repelem([num2str(i)], length(abs_weight_solution));
%     box_result_1 = [box_result_1; label'];
% end
% fig_num = fig_num + 1;
% figure(fig_num);
% boxplot(count_mean_weight_solutions, box_result_1);
% axis([0 9 0 1]);
% xlabel("Solutions");
% ylabel("Percentage of contribution to the PR norm");
% title(strcat("Norm contribution from each solution", ", alpha = ", num2str(restart_prob)));


%%
% % change in solution entries
% % abs vs non-abs chain
% % non-abs vs non-abs chain

% abs_abs = each_solution_contributor_percentage(abs_stats ,abs_stats, :);
% non_abs_non_abs = each_solution_contributor_percentage(~abs_stats, ~abs_stats, :);
% 
% count_abs_abs_change = [];
% box_result_2 = [];
% for i = 1:num_phenotype
%     abs_abs_change = reshape((abs_abs(:,:,i)) , [], 1);
%     count_abs_abs_change = [count_abs_abs_change, abs_abs_change];
%     label = repelem([num2str(i)], length(abs_abs_change));
%     box_result_2 = [box_result_2; label'];
% end
% fig_num = fig_num + 1;
% figure(fig_num);
% boxplot(count_abs_abs_change, box_result_2);
% xlabel("Solutions");
% ylabel("Change in solution entries");
% title("Absorbing chain vs absorbing chain");
% axis([0 9 -0.8 0.8]);
% 
% count_abs_non_abs_change = [];
% box_result_3 = [];
% for i = 1:num_phenotype
%     abs_non_abs_change = reshape((non_abs_non_abs(:,:,i)) , [], 1);
%     count_abs_non_abs_change = [count_abs_non_abs_change, abs_non_abs_change];
%     label = repelem([num2str(i)], length(abs_non_abs_change));
%     box_result_3 = [box_result_3; label'];
% end
% fig_num = fig_num + 1;
% figure(fig_num);
% boxplot(count_abs_non_abs_change, box_result_3);
% xlabel("Solutions");
% ylabel("Change in solution entries");
% title("Non-absorbing chain vs non-absorbing chain");
% axis([0 9 -0.8 0.8]);


%%
% % plot number of absorbing chain can exist in one-to-one mapping and genotype=8 

% num_abs_one_one = sum(rec_num_freq_collection,2);
% 
% one_abs = perm_solution_mapping(num_abs_one_one==1, :);
% mapping_one_abs = one_abs(1,:);
% four_abs_t = construct_transition_matrix(mapping_one_abs, num_genotype, neighbour_index);
% [PR_v_gene, ~, ~, ~ ] = random_walk_on_cubic_graph(mapping_one_abs);
% plot_digraph_with_page_rank(four_abs_t, mapping_one_abs, round(PR_v_gene,3));
% title("1 absorbing state");
% 
% two_abs = perm_solution_mapping(num_abs_one_one==2, :);
% mapping_two_abs = two_abs(1,:);
% four_abs_t = construct_transition_matrix(mapping_two_abs, num_genotype, neighbour_index);
% [PR_v_gene, ~, ~, ~ ] = random_walk_on_cubic_graph(mapping_two_abs);
% plot_digraph_with_page_rank(four_abs_t, mapping_two_abs, round(PR_v_gene,3));
% title("2 absorbing states");
% 
% three_abs = perm_solution_mapping(num_abs_one_one==3, :);
% mapping_three_abs = three_abs(1,:);
% four_abs_t = construct_transition_matrix(mapping_three_abs, num_genotype, neighbour_index);
% [PR_v_gene, ~, ~, ~ ] = random_walk_on_cubic_graph(mapping_three_abs);
% plot_digraph_with_page_rank(four_abs_t, mapping_three_abs, round(PR_v_gene,3));
% title("3 absorbing states");
% 
% four_abs = perm_solution_mapping(num_abs_one_one==4, :);
% mapping_four_abs = four_abs(1,:);
% four_abs_t = construct_transition_matrix(mapping_four_abs, num_genotype, neighbour_index);
% [PR_v_gene, ~, ~, ~ ] = random_walk_on_cubic_graph(mapping_four_abs);
% plot_digraph_with_page_rank(four_abs_t, mapping_four_abs, round(PR_v_gene,3));
% title("4 absorbing states");
% 
% nbins = max(num_abs_one_one);
% count = [];
% for i = 1:max(num_abs_one_one)
%     count = [count, length(find(num_abs_one_one==i))];
% end
% h = bar([1:nbins],count);
% title("Number of absorbing states can exist");
% xlabel("Number of absorbing states");
% ylabel("Frequency");


%%
% % demonstrate the solution-wise PageRank difference
% % when the suboptimal solution is replaced by the another alternative

% idx_six = ismember(rec_states_num_collection, [-1,-1,-1,-1,-1,-1,6,7], 'rows');
% idx_five = ismember(rec_states_num_collection, [-1,-1,-1,-1,-1,-1,5,7], 'rows');
% 
% six_six = each_solution_contributor_percentage(idx_six ,idx_six, :);
% six_five = each_solution_contributor_percentage(idx_five, idx_six, :);
% 
% count_six_seven_change = [];
% box_result_3 = [];
% for i = 1:num_phenotype
%     six_seven_change = reshape((six_five(:,:,i)) , [], 1);
%     count_six_seven_change = [count_six_seven_change, six_seven_change];
%     label = repelem([num2str(i)], length(six_seven_change));
%     box_result_3 = [box_result_3; label'];
% end
% fig_num = fig_num + 1;
% figure(fig_num);
% boxplot(count_six_seven_change, box_result_3);
% xlabel("Solutions");
% ylabel("Change in solution entries");
% title("Suboptimal solution 7 being replaced by 6");
