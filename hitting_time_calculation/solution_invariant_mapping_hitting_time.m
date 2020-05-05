%{
    Compute PR score for all permutations of genotype-phenotype mapping
%}


disp(strcat("Running '", mfilename, "' ..."));
s = rng(0, 'twister');
load('config.mat');

load(strcat("data/mapping_data/solution_invariant/", spec, "_mapping.mat"));

foldername = "data/HT_result/solution_invariant/";
filename = strcat(foldername, spec_restart, "_result.mat");
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
% stop generating new result if it has existsed before
% if exist(filename, 'file')
%     disp("skip generating an existing result");
%     return;
% end

a_s_solution_collection = cell(1, length(perm_solution_mapping));
t_s_solution_collection = cell(1, length(perm_solution_mapping));
h_t_trans_solution_collection = cell(1, length(perm_solution_mapping));
h_t_abs_solution_collection = cell(1, length(perm_solution_mapping));

a_s_gene_collection = cell(1, length(perm_solution_mapping));
t_s_gene_collection = cell(1, length(perm_solution_mapping));
h_t_trans_gene_collection = cell(1, length(perm_solution_mapping));
h_t_abs_gene_collection = cell(1, length(perm_solution_mapping));

converged_transition_collection = cell(1, length(perm_solution_mapping));
% loop the permutation of mapping and compute their Hitting time
for i = 1:length(perm_solution_mapping)
%     disp(i);
    current_solution_mapping = perm_solution_mapping(i,:); % get the current mapping
    [transition_m_gene, ~, ~] = construct_transition_matrix(current_solution_mapping, num_genotype, neighbour_index);
%     [~, ~, converged_transition_m] = random_walk_sampling(current_solution_mapping, transition_m_gene);
    converged_transition_m = converged_transition_m_collection{i};
    [a_s, t_s, h_t_abs, h_t_trans] = compute_hitting_time(transition_m_gene, bit_len);
    a_s_gene_collection{i} = a_s;
    t_s_gene_collection{i} = t_s;
    h_t_trans_gene_collection{i} = h_t_trans;
    h_t_abs_gene_collection{i} = h_t_abs;
    
    [a_s, t_s, h_t_abs, h_t_trans] = compute_hitting_time(converged_transition_m, bit_len);
    a_s_solution_collection{i} = a_s;
    t_s_solution_collection{i} = t_s;
    h_t_trans_solution_collection{i} = h_t_trans;
    h_t_abs_solution_collection{i} = h_t_abs;
    
end


save(filename, 'perm_solution_mapping', ...
'a_s_gene_collection', 'a_s_solution_collection',...
't_s_gene_collection', 't_s_solution_collection',...
'h_t_trans_gene_collection', 'h_t_trans_solution_collection',...
'h_t_abs_gene_collection', 'h_t_abs_solution_collection',...
'restart_prob');