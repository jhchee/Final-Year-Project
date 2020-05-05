%{ 
    Compute PR score with restart setting
%}

% arguments: initial_dist: node(s) where the walker starts at
%            restart_prob: probability of restarting from starting node
% return:    PR_v: PageRank vector
%            counter: number of iteration to convergence
function [PR_v, counter] = page_rank_with_restart(initial_dist, restart_prob, transition_m)
    initial_dist = initial_dist./sum(initial_dist); % normalise
    PR_v = initial_dist;
    last_p = initial_dist;
    
    PR_v = restart_prob * initial_dist + (1-restart_prob) * PR_v * transition_m;
    PR_v = PR_v./sum(PR_v); % normalise
    counter = 1; % report the number of iteration leads to convergence
    % convergence when 1-norm delta < 1e-9
    while sum(abs(PR_v - last_p)) > 1e-9
        last_p= PR_v;
        PR_v = restart_prob * initial_dist + (1-restart_prob) * PR_v * transition_m;
        PR_v = PR_v./sum(PR_v); % normalise
        counter = counter + 1;
    end
end