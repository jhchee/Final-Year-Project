disp(strcat("Running '", mfilename, "' ..."));
load('config');
load(strcat("./data/analysis/", spec_restart, "_largest.mat"));
A = {};
[A, idx] = sort([max_mapping_value_index{1,:}], 'descend');
m = [max_mapping_value_index{2,:}];
% source PR_norm target_list
A = {idx; A; m(idx)};

% for i = 1:size(A,2)
for i = 1:2
    source = A{1}(source);
    source_mapping = perm_solution_mapping(source, :);
    [source_transition, ~, ~] = construct_transition_matrix(source_mapping, num_genotype, neighbour_index);
    target_list = A{3}{source};
    [PR_gene_source, PR_solution_source] = page_rank_with_restart(ones(1,num_genotype), restart_prob, source_transition);
    draw_genotype_phenotype_mapping(source_mapping);
    plot_digraph_with_page_rank(source_transition, source_mapping, PR_v_gene_1);
%     disp(PR_solution_source);
    for j = 1:length(target_list)
        target_mapping = perm_solution_mapping(target_list(j,:), :);
        [target_transition, ~, ~] = construct_transition_matrix(target_mapping, num_genotype, neighbour_index);
        [PR_gene_target, PR_solution_target] = page_rank_with_restart(ones(1,num_genotype), restart_prob, target_transition);
        draw_genotype_phenotype_mapping(target_mapping);
        plot_digraph_with_page_rank(target_transition, target_mapping, PR_gene_target);
    end

%     d = {d; dominance_matrix_1};
%     disp(dominance_matrix_1);
%     plot_digraph_with_page_rank(transition_m_1, m(i,:), PR_v_gene_1);
%     if sum(abs(previous_page_rank - PR_v_solution_sum)) > 0.01
%         disp("abnormal");
%     end
%     previous_page_rank = PR_v_gene_sum;
%     disp(PR_v_gene_sum); 
end