% Compute the reflection mapping indices


disp(strcat("Running '", mfilename, "' ..."));
load('config.mat');

flip_list = {[]};
for i = 1:2
    comb = nchoosek([1:1:bit_len], i);
    flip_list{i} = comb;
end
m = [];

% Perform reflection without having the plane of reflection crossing 
% any genotype (reflection of axis. This doesn't need to fix any genotype 
% (all genotypes move into new position)
for i = 1:size(flip_list{1},1) % loop through the flip list 1 (combination 1)
    current_genotypic_state_list = genotypic_state; % clone to prevent overwrite
    for j = 1:size(flip_list{1}(i,:),2)
        current_genotypic_state_list(:, flip_list{1}(i,j)) = 1 - current_genotypic_state_list(:, flip_list{1}(i,j));
    end
    
    % can be reused
    current_state_list = zeros(1,num_genotype);
    % convert genotype (binary) to mapping (decimal)
    for k = 1:num_genotype
        current_state_list(k) = bin_dec2dec(current_genotypic_state_list(k,:));
    end
    m = [m; current_state_list];
end

group_1 = [1,2];
group_2 = [3,0];
% Find the plane of reflection and fix genotype that lies on the plane.
for i = 1:size(flip_list{2},1) % loop through the flip list 2 (combination 2)
    current_genotypic_state_list = genotypic_state;
    % find the two groups
    % the grouping location is specified in the flip list
    group_location = flip_list{2}(i,:); % this is also the flip location
    extracted_bits = genotypic_state(:,group_location);
    extracted_dec = bin2dec(num2str(extracted_bits));
    % index group 1 and 2
    group_1_index = ismember(extracted_dec, group_1);
    group_2_index = ismember(extracted_dec, group_2);
    
    % flip bit at corresponding position
    
    current_genotypic_state_list(:, group_location) = 1 - current_genotypic_state_list(:, group_location);
    
    group_1_reflection = current_genotypic_state_list;
    group_1_reflection(group_1_index, :) = genotypic_state(group_1_index, :);
    group_2_reflection = current_genotypic_state_list;
    group_2_reflection(group_2_index, :) = genotypic_state(group_2_index, :);
    
    % convert genotype (binary) to mapping (decimal)
    for k = 1:num_genotype
        current_state_list(k) = bin_dec2dec(group_1_reflection(k,:));
    end
    m = [m; current_state_list];
    
    for k = 1:num_genotype
        current_state_list(k) = bin_dec2dec(group_2_reflection(k,:));
    end
    m = [m; current_state_list];
end

foldername = "data/reflection_indices/";
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
reflection_indices = m;
filename = strcat(foldername, "cube-", num2str(bit_len), "_reflection_indices.mat");
save(filename, 'reflection_indices');