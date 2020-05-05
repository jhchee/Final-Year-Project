function [PR_v_gene, PR_v_solution, converged_transition_m] = random_walk_sampling(solution_mapping, transition_m_gene)
    load('config.mat');
    % random starting point
    next_state = randsample([1:num_genotype],1);
    last_symbol = solution_mapping(next_state) + 1;
    
    [PR_v_gene, ~] = page_rank_with_restart(ones(1,num_genotype), restart_prob, transition_m_gene);
    PR_v_solution = zeros(1, num_phenotype);
    for i = 1:num_phenotype
        PR_v_solution(1,i) = sum(PR_v_gene(solution_mapping==i-1));
    end
    
    state_list = state_list + 1;
    converged_transition_m = zeros(num_phenotype);
    max_iteration = 100000;
    % generate restart_list in one go
    restart_list = randsample([true, false], max_iteration, true,[restart_prob, 1-restart_prob]);
    for i = 1:max_iteration
        % restart
        if restart_list(i)
            next_state = randsample(state_list,1);
            symbol = solution_mapping(next_state) + 1;
        else
            next_state = randsample(state_list, 1, true, transition_m_gene(next_state,:));
            symbol = solution_mapping(next_state) + 1;
            converged_transition_m(last_symbol, symbol) = converged_transition_m(last_symbol, symbol) + 1;
        end
        last_symbol = symbol;
    end
    converged_transition_m = converged_transition_m ./ sum(converged_transition_m,2);

end