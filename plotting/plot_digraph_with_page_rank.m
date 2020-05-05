%{ 
    Plot cubic digraph with page rank
%}

function plot_digraph_with_page_rank(transition_m, solution_mapping, PR_v_gene)
    load('config.mat');
    figure();
    D = digraph(transition_m);
    D.Nodes = table(PR_v_gene', 'VariableNames', {'Score'});
    p = plot(D, 'XData', genotypic_state(:, 1), 'YData', genotypic_state(:, 2), 'ZData', genotypic_state(:, 3), 'Linewidth', 2);
    
    % construct the plot
    x = genotypic_state(:, 1); y = genotypic_state(:, 2); z = genotypic_state(:, 3);
    % permutation of bit string (label preparing)
    a = dec2bin(state_list);
    b = transpose(string(solution_mapping+1));
    % label genotype + corresponding solution
    label = strcat(a," (", b, ")");
    % label page rank
    label = strcat(label, ": ", num2str(PR_v_gene'));
    dx = 0.1; dy = 0.1; dz = 0.01; % displacement so the text does not overlay the data points
    text(x + dx, y + dy, z + dz, label);
    title('Transition in genotypic state space');
    xlabel("1st bit");
    ylabel("2nd bit");
    zlabel("3rd bit");
    
    % set node size to some constant
    marker_size = repelem([15], length(state_list));
    
    % the colour intensity of the node depending on its page rank score
    % normalize to get better distribution of colour
    norm_page_rank_score = normalize(PR_v_gene, 'range');
%     norm_page_rank_score = PR_v_gene;
    
    for i = 1:length(state_list)
        highlight(p, i, 'NodeColor', [1 0.5 0.25] * norm_page_rank_score(i));  
    end
    
    p.MarkerSize = marker_size;
    p.ArrowSize=15;
    % remove default label
    node_label = repelem({''}, length(state_list));
    labelnode(p, state_list + 1, node_label);
end