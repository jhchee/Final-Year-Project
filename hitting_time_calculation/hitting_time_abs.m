load("config.mat");
load(strcat("data/mapping_data/solution_invariant/", spec, "_mapping.mat"));
close all;

N_result = cell(1,size(perm_solution_mapping,1));
hit_abs_result = cell(1,size(perm_solution_mapping,1));
mean_hit_abs_result = zeros(1,size(perm_solution_mapping,1));
for i = 1:size(perm_solution_mapping,1)
    mapping = perm_solution_mapping(i,:);
    transition_m = construct_transition_matrix(mapping, num_genotype, neighbour_index);

    [N, hit_abs, mean_hit_abs] = hitting_time(transition_m, mapping);
    N_result{i} = N;
    hit_abs_result{i} = hit_abs;
    mean_hit_abs_result(i) = mean_hit_abs;
end
save(strcat("data/HT_to_abs_result/", spec, "_result.mat"), ...
"N_result","hit_abs_result","mean_hit_abs_result" ...
);


