%{ 
    Construct transition matrix with transitive chain setting
%}
function [transition_m, dangling_indicator_gene, domination_m] = construct_transition_matrix(solution_mapping, num_genotype, neighbour_index)
    num_bits = size(neighbour_index, 2);
    
    transition_m = zeros(num_genotype, num_genotype);
    domination_m = transition_m;
    dangling_indicator_gene = zeros(num_genotype, 1);
     
    % gene transition
    draw_counter = 0;
    for j = 1:num_genotype
        for k = 1:num_bits
            current_neighbour = neighbour_index(j, k);
            neighbour_value = solution_mapping(current_neighbour+1);
            if (solution_mapping(j) <= neighbour_value)
                % goto neighbour if it is superior or draw
                transition_m(j, current_neighbour+1) = 1;
            end
            if (solution_mapping(j) == neighbour_value)
                % self loop
                draw_counter = draw_counter + 1;
            end
        end
        domination_m(j,:) = transition_m(j,:);
        % there exists outneigbour 
        num_outneighbour = sum(transition_m(j,:));
        if num_outneighbour ~= 0
            % TODO handle draw here 
            
            % simply divide
            transition_m(j,:) = transition_m(j,:)/num_outneighbour;
        else
            % indicates the dangling nodes
            transition_m(j,j) = 1;
            domination_m(j,j) = 1;
            dangling_indicator_gene(j) = 1;
        end
    end
end
