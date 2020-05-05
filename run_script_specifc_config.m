% perform action for specific configuration

% clear all workplace variables
clear;
clc;
close all;
restart_prob_list = [0.05, 0.30, 0.55, 0.85];

% Game and PR configurations
bit_len = 3;
% for num_phenotype = 2:8
num_phenotype = 8;

restart_prob = 0.05;

config(bit_len, num_phenotype, restart_prob)

% RUN FOR EACH GAME SETTING
% --------------------
% [ Generate mapping
generate_permutation_mapping
% ]

% [ Generate tools to remove solution and edge invariant strcutures
compute_rotation_indices   
compute_reflection_indices  
compute_possible_rotation
compute_possible_reflection
% ]
% --------------------

% RUN DIFFERENTLY FOR EACH GAME & PR SETTING
% --------------------


% [ Remove invariant structures
filter_solution_invariant
% filter_edge_invariant

% ]
% [ PR calculation
complete_mapping_page_rank
solution_invariant_mapping_page_rank
% edge_invariant_mapping_page_rank
% ]


% [ One norm analysis
batch_PR_norm_with_mapping
largest_PR_norm
same_solution_largest_PR_norm
% ]

% [ Hitting time analysis
% solution_invariant_mapping_hitting_time
% edge_invariant_mapping_hitting_time
% hitting_time_abs
% ]

% [ identify group of mappings
find_same_solution_mapping
find_solution_invariant_mapping
% ]

% --------------------