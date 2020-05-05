% experiment to compare HT that has largest PR norm


clc;
% large page rank norm must come from structural difference
% 
load("config.mat")
load(strcat("./data/mapping_data/solution_invariant/", spec', "_mapping.mat"));
load(strcat("./data/analysis/solution_invariant/", spec_restart, "_largest.mat"));
load(strcat("data/PR_result/solution_invariant/", spec_restart, "_result.mat"));
load(strcat("data/HT_result/solution_invariant/", spec_restart, "_result.mat"));

for i = 1:length(largest_idx)
    close all;
    current_idx = largest_idx(i);
    current_idx_mapping = perm_solution_mapping(current_idx,:);
    
    % page rank
    PR_source_gene = page_rank_score_gene_collection(current_idx,:);
    PR_source_solution = page_rank_score_solution_collection(current_idx,:);
    [t_m, ~] = construct_transition_matrix(current_idx_mapping, num_genotype, neighbour_index);
    
    
    % hitting time
%     HT_gene_source = hitting_time_gene_collection{current_idx}
    HT_sol_source = hitting_time_solution_collection{current_idx}
    
    % plot
    plot_digraph_with_page_rank(t_m, current_idx_mapping, PR_source_gene);
    
    % check if same solution space
    sorted_source = sort(current_idx_mapping);
    
    max_PR_norm_idx = max_mapping_value_index{2,current_idx}{1};
    for j = 1:length(max_PR_norm_idx)
        
        current_max_idx = max_PR_norm_idx(j);
        current_max_idx_mapping = perm_solution_mapping(current_max_idx,:)
        
        sorted_target = sort(current_max_idx_mapping);
        
        if ~ismember(sorted_target, sorted_source, 'rows')
            continue;
        end
        
        % page rank
        PR_target_gene = page_rank_score_gene_collection(current_max_idx,:);
        PR_target_solution = page_rank_score_solution_collection(current_max_idx,:);
        [t_m, ~] = construct_transition_matrix(current_max_idx_mapping, num_genotype, neighbour_index);
        
        
        % hitting time
%         HT_gene_target = hitting_time_gene_collection{current_max_idx}
        HT_sol_target = hitting_time_solution_collection{current_max_idx}
    
        % plot
        plot_digraph_with_page_rank(t_m, current_max_idx_mapping, PR_target_gene);
    end
end


% common greatest index?