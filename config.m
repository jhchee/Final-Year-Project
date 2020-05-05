%{
    Configuration of the analysis
%}

function config (bit_len, num_phenotype, restart_prob)

    addpath(genpath("one_norm_calculation"));
    addpath(genpath("auxilliary function"));
    addpath(genpath("experiment"));
    addpath(genpath("page_rank_calculation"));
    addpath(genpath("hitting_time_calculation"));
    addpath(genpath("group_mapping"));
    addpath(genpath("plotting"));

    num_genotype = 2^bit_len;
    state_list  = [0:1:num_genotype-1];
    genotypic_state = dec2bin([0:1:num_genotype-1]) - '0';
    initial_dist = ones(1,num_genotype);
    
    % store neighbour index
    % e.g. 0: [4,2,1], neighbours of 0 are 4, 2 and 1
    % genotype neighborhood
    neighbour_index = compute_neighbour_list(bit_len);

    % specification
    spec = strcat("G", num2str(num_genotype), "P", num2str(num_phenotype));
    spec_restart = strcat(spec, "R", num2str(restart_prob)); % attaching restart probability

    % save all the variables in config.mat
    save("config.mat");
    disp(strcat("Current config - ", "spec: ", spec , " restart: ", num2str(restart_prob)));
end