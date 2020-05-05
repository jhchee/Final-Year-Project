% Compute rotation mapping indices available for each dimension

disp(strcat("Running '", mfilename, "' ..."));
load('config.mat');

neighbour_index = compute_neighbour_list(bit_len);
state_list_num = [0:1:num_genotype-1];
state_list_gene = dec2bin([0:1:num_genotype-1]) - '0';
two_bit_state_list_gene = dec2bin([0:1:(2^2)-1]) - '0';


num_non_common_bits = bit_len - 2;
non_common_bits_list_gene = dec2bin([0:1:(2^num_non_common_bits)-1]) - '0';

num_rotation_exists = 0;
for i = 0:bit_len-1
    num_rotation_exists = num_rotation_exists + i;
end

rotation_mapping_indices = [];
left_pivot = 1;
right_pivot = 2;
count = 1;

disp("Left pivot | Right pivot");
while left_pivot < bit_len - 1 % left pivot never moves pass the 2nd last position
    % moves the left and right pivot when right pivot has reached the end
    if right_pivot == bit_len + 1 
        left_pivot = left_pivot + 1;
        right_pivot = left_pivot + 1;
    end
    disp("    " + left_pivot + "            " + right_pivot);
    bit_fixed_position = [left_pivot, right_pivot];
    
    % divide into 4 groups
    genotype_group_list = {{},{},{},{}};
    num = num_genotype / 4;

    other_position = repelem(true, bit_len);
    other_position(bit_fixed_position) = false;
    for i = 1:4
        genotype_group_list{i} = zeros(num, bit_len);
        fixed_indices_value = two_bit_state_list_gene(i,:);
        for j = 1:num
            non_common_bits_in_group = non_common_bits_list_gene(j,:);
            genotype_group_list{i}(j, bit_fixed_position) = fixed_indices_value;
            genotype_group_list{i}(j, other_position) = non_common_bits_in_group;
        end
    end
    
    largest = 2^(bit_len - bit_fixed_position(1)); % MSB it can flip
    smallest = 2^(bit_len - bit_fixed_position(2)); % LSB it can flip

    assignment = [smallest largest -largest -smallest]; % always in this pattern
    mapping = zeros(1,num_genotype);
    for i = 1:4
        current_group = genotype_group_list{i};
        current_assignment = assignment(i);
        for j = 1:size(current_group, 1)
            current_genotype_location = bin_dec2dec(current_group(j,:));
            new_genotypic_location = current_genotype_location + current_assignment;
            mapping(1, current_genotype_location+1) = new_genotypic_location+1;
        end
    end
    rotation_mapping_indices = [rotation_mapping_indices; mapping];
    % move the right pivot
    right_pivot = right_pivot + 1;
    count = count + 1;
end
foldername = "data/rotation_indices/";
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
filename = strcat(foldername, "cube-", num2str(bit_len),  "_rotation_indices.mat");
save(filename, 'rotation_mapping_indices');
