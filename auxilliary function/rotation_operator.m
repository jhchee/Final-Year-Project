%{
    Perform rotation with specified configuration
%}

function [solution_mapping] = rotation_operator(rotation_spec, solution_mapping)
    load('config.mat');
    load(strcat("data/rotation_indices/", "cube-", num2str(bit_len), "_rotation_indices.mat"));
    
    permutation = [0:1:2^bit_len-1]; % initialize the permutation to be an ordered list
    
    for i=1:length(rotation_spec)
        permutation = permutation(rotation_mapping_indices(rotation_spec(i),:));
    end
    solution_mapping = solution_mapping(permutation+1);
end

