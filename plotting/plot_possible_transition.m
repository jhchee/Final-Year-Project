%{ 
    Plot cubic digraph with possible transition
%}

% plot transition between neighbours without solution encoding
function plot_possible_transition(num_bits)
    num_genotype = 2^num_bits;
    possible_genotype_transition = zeros(num_genotype, num_genotype);
    neighbour_index = zeros(2^num_bits, num_bits);
    genotypic_state = dec2bin([0:1:num_genotype-1]) - '0';    
    for i = 1:num_genotype
        current_genotype = genotypic_state(i,:);
        for j = 1:num_bits
           flipped_bit = current_genotype;
           flipped_bit(j) = ~flipped_bit(j);
           neighbour = bin_dec2dec(flipped_bit);
           neighbour_index(i, j) = neighbour;
        end
        for k = 1:num_bits
            genotype_neighbour = neighbour_index(i, k);
            possible_genotype_transition(i, genotype_neighbour + 1) = 1;
        end
    end
    
    figure();
    possible_transition_digraph = digraph(possible_genotype_transition);
    num_label = [1:1:num_genotype];
    node_label = repelem({''}, length(genotypic_state)); % remove label
    marker_none = {'none'};
    marker_none = repelem(marker_none, 8);
    possible_transition_plot = plot(possible_transition_digraph, 'XData', genotypic_state(:, 1), 'YData', genotypic_state(:, 2), 'ZData', genotypic_state(:, 3), 'Marker', marker_none);
    possible_transition_plot.LineStyle = ':';
    labelnode(possible_transition_plot, num_label, node_label);
    
    label = dec2bin(0:length(genotypic_state)-1);
    x = genotypic_state(:, 1); y = genotypic_state(:, 2); z = genotypic_state(:, 3);
    dx = 0.01; dy = 0.01; dz = 0.01; % displacement so the text does not overlay the data points
    % coordinate and text
    text(x + dx, y + dy, z + dz, label);
    title('Possible transition in genotypic space');
    
    xlabel("1st bit");
    ylabel("2nd bit");
    zlabel("3rd bit");    
end
