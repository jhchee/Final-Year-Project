%{
    Compute PR score for all permutations of genotype-phenotype mapping
%}


disp(strcat("Running '", mfilename, "' ..."));
s = rng(0, 'twister');
load('config.mat');
load(strcat("data/mapping_data/solution_invariant/", spec, "_mapping.mat"));


foldername = "data/PR_result/solution_invariant/";
if ~exist(foldername, 'dir')
       mkdir(foldername)
end

filename = strcat(foldername, spec_restart, "_result.mat");
% stop generating new result if it has been generated before
% if exist(filename, 'file')
%     disp("skip generate an existing result");
%     return;
% end

transition_matrix_perm_collection = zeros(length(perm_solution_mapping), num_phenotype, num_phenotype);
% PR score w.r.t to solution
page_rank_score_solution_collection = zeros(length(perm_solution_mapping), num_phenotype);
% PR score w.r.t to genotype
page_rank_score_gene_collection = zeros(length(perm_solution_mapping), num_genotype);
converged_transition_m_collection = cell(1,length(perm_solution_mapping));
% loop the permutation of mapping and compute their PR score
for i = 1:length(perm_solution_mapping)
%     disp(i);
    current_solution_mapping = perm_solution_mapping(i,:); % get the current mapping
    [PR_v_gene, PR_v_gene_sum, converged_transition_m, PR_v_phenotype] = random_walk_on_cubic_graph(current_solution_mapping);
    page_rank_score_gene_collection(i,:) = PR_v_gene;
    page_rank_score_solution_collection(i,:) = PR_v_gene_sum;
    converged_transition_m_collection{i} = converged_transition_m;
end


save(filename, 'perm_solution_mapping', 'page_rank_score_gene_collection', 'page_rank_score_solution_collection', 'converged_transition_m_collection', 'restart_prob');

