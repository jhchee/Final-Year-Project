%{
    Compute PR score for all permutations of genotype-phenotype mapping
%}

disp(strcat("Running '", mfilename, "' ..."));
s = rng(0, 'twister');
load('config.mat');

load(strcat("data/mapping_data/edge_invariant/", spec, "_mapping.mat"));

hitting_time_solution_collection = cell(1, length(perm_solution_mapping));
hitting_time_gene_collection = cell(1, length(perm_solution_mapping));
converged_transition_collection = cell(1, length(perm_solution_mapping));
% loop the permutation of mapping and compute their Hitting time
for i = 1:length(perm_solution_mapping)
%     disp(i);
    current_solution_mapping = perm_solution_mapping(i,:); % get the current mapping
    [transition_m_gene, ~, ~] = construct_transition_matrix(current_solution_mapping, num_genotype, neighbour_index);
    [PR_v_gene, PR_v_solution, converged_transition_m] = random_walk_sampling(current_solution_mapping, transition_m_gene);

    d_m_gene = compute_hitting_time(transition_m_gene);
    d_m_sol = compute_hitting_time(converged_transition_m);

    hitting_time_gene_collection{i} = d_m_gene;
    hitting_time_solution_collection{i} = d_m_sol;
    converged_transition_collection{i} = converged_transition_m;
end

foldername = "data/HT_result/edge_invariant/";
filename = strcat(foldername, spec_restart, "_result.mat");
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
save(filename, 'perm_solution_mapping', 'converged_transition_collection', 'hitting_time_gene_collection', 'hitting_time_solution_collection', 'restart_prob');