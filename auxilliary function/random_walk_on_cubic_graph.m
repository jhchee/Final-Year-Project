%{ 
    Compute PR w.r.t genotypes, phenotypes
%}

% function [PR_v_gene, PR_v_gene_sum, stationary_distribution_restart] = random_walk_on_cubic_graph(solution_mapping)
function [PR_v_gene, PR_v_gene_sum, converged_transition_m, PR_v_phenotype] = random_walk_on_cubic_graph(solution_mapping)
    load('config.mat');
    num_phenotype = max(solution_mapping) + 1; 
    [transition_m_gene, ~, ~] = construct_transition_matrix(solution_mapping, num_genotype, neighbour_index);

    [PR_v_gene, ~] = page_rank_with_restart(ones(1,num_genotype), restart_prob, transition_m_gene);
    PR_v_gene_sum = zeros(1, num_phenotype);
    for i = 1:num_phenotype
        PR_v_gene_sum(1,i) = sum(PR_v_gene(solution_mapping==i-1));
    end
       
    % random starting point
    next_state = randsample([1:num_genotype],1);
    last_symbol = solution_mapping(next_state) + 1;
    stationary_distribution = zeros(1, num_phenotype);
    stationary_distribution_restart = stationary_distribution;
    stationary_distribution(1, last_symbol) = stationary_distribution(1, last_symbol) + 1;

    state_list = state_list + 1;
    converged_transition_m = zeros(num_phenotype);
    max_iteration = 1;
    for i = 1:max_iteration
        % restart
        if randsample([true, false], 1, true,[restart_prob, 1-restart_prob])
            next_state = randsample(state_list,1);
            symbol = solution_mapping(next_state) + 1;
%             converged_transition_m(last_symbol, symbol) = converged_transition_m(last_symbol, symbol) + 1;
            stationary_distribution_restart(1, symbol) = stationary_distribution_restart(1, symbol) + 1;
        else
            next_state = randsample(state_list, 1, true, transition_m_gene(next_state,:));
            symbol = solution_mapping(next_state) + 1;
            converged_transition_m(last_symbol, symbol) = converged_transition_m(last_symbol, symbol) + 1;
            stationary_distribution(1, symbol) = stationary_distribution(1, symbol) + 1;
        end
        last_symbol = symbol;
    end
    converged_transition_m = converged_transition_m ./ sum(converged_transition_m,2);
    stationary_distribution_restart = stationary_distribution_restart + stationary_distribution;
    stationary_distribution_restart = stationary_distribution_restart./sum(stationary_distribution_restart);
    stationary_distribution = stationary_distribution./sum(stationary_distribution);
   
    [PR_v_phenotype, ~] = page_rank_with_restart(ones(1,num_phenotype), restart_prob, converged_transition_m);
    
%     plot_digraph_with_page_rank(transition_m_gene, PR_v_gene, solution_mapping);  
%     PR_v_gene_sum
%     PR_v_phenotype
%     disp("norm of gene and reconstructed" + num2str(page_rank_one_norm(PR_v_gene_sum, PR_v_phenotype)));
%     disp("norm of gene and stationary" + num2str(page_rank_one_norm(PR_v_gene_sum, stationary_distribution_restart)));

end