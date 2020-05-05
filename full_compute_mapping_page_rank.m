%{
    Compute PR score for permutations of genotype-phenotype mapping
%}

disp(strcat("Running '", mfilename, "' ..."));
s = rng(0, 'twister');
load('config.mat');
load(strcat("data/mapping_data/complete/", spec, "_mapping.mat"));
transition_matrix_perm_collection = zeros(length(perm_solution_mapping), num_phenotype, num_phenotype);
% PR score w.r.t to solution
page_rank_score_solution_collection = zeros(length(perm_solution_mapping), num_phenotype);
% PR score w.r.t to genotype
page_rank_score_gene_collection = zeros(length(perm_solution_mapping), num_genotype);

% loop the permutation of mapping and compute their PR score
for i = 1:length(perm_solution_mapping)
    disp(i);
    current_solution_mapping = perm_solution_mapping(i,:); % get the current mapping
    [PR_v_gene, PR_v_gene_sum, ~] = random_walk_on_cubic_graph(current_solution_mapping);
    page_rank_score_gene_collection(i,:) = PR_v_gene;
    page_rank_score_solution_collection(i,:) = PR_v_gene_sum;
end

foldername = "data/PR_result/complete/";
filename = strcat(foldername, spec_restart, "_result.mat");
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
save(filename, 'perm_solution_mapping', 'page_rank_score_gene_collection', 'page_rank_score_solution_collection', 'restart_prob');

