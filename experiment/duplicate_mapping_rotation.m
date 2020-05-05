% shows transformation can lead into duplicate mappings

close all;
load("config.mat");
load(strcat("data/mapping_data/complete/", spec, "_mapping.mat"));
load(strcat("data/possible_rotation/","cube-", num2str(bit_len), "_possible_rotation.mat"));
load(strcat("data/possible_reflection/","cube-", num2str(bit_len), "_possible_reflection.mat"));

num_rotation = size(possible_rotation,1);
num_reflection = size(possible_reflection,1);

counter = 1;
% while (counter < size(perm_solution_mapping,1))
current_solution_mapping = perm_solution_mapping(counter,:);
rotated_structures = zeros(num_rotation, num_genotype);
for j = 1:num_rotation
    rotated_structures(j,:) = current_solution_mapping(possible_rotation(j,:)+1);
end
reflected_structures = zeros(num_reflection, num_genotype);
for j = 1:num_reflection
    reflected_structures(j,:) = current_solution_mapping(possible_reflection(j,:)+1);
end
all_invariant = [rotated_structures; reflected_structures];
[C,ia,ic] = unique(all_invariant, 'rows');
% end

PR_v_gene = zeros(1, num_genotype);
[transition_m, ~] = construct_transition_matrix(current_solution_mapping(possible_rotation(1,:)+1), num_genotype, neighbour_index);
plot_digraph_with_page_rank(transition_m, current_solution_mapping(possible_rotation(1,:)+1), PR_v_gene);
[transition_m, ~] = construct_transition_matrix(current_solution_mapping(possible_rotation(12,:)+1), num_genotype, neighbour_index);
plot_digraph_with_page_rank(transition_m, current_solution_mapping(possible_rotation(12,:)+1), PR_v_gene);

load(strcat("data/mapping_data/complete/", "G8P8", "_mapping.mat"));