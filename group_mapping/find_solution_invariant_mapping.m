%{
    Perform operations that its outcome is edge-preserving and solution 
    label preserving. These structure are removed due to duplication.
%}

disp(strcat("Running '", mfilename, "' ..."));
load('config.mat');
load(strcat("data/mapping_data/complete/", spec, "_mapping.mat"));
load(strcat("data/possible_rotation/","cube-", num2str(bit_len), "_possible_rotation.mat"));
load(strcat("data/possible_reflection/","cube-", num2str(bit_len), "_possible_reflection.mat"));

num_rotation = size(possible_rotation,1);
num_reflection = size(possible_reflection,1);



rotation_record = repelem({[]}, size(perm_solution_mapping,1));
for i = 1:size(perm_solution_mapping,1)
    current_solution_mapping = perm_solution_mapping(i,:);
    rotated_structures = zeros(num_rotation, num_genotype);
    
    for j = 1:num_rotation
        rotated_structures(j,:) = current_solution_mapping(possible_rotation(j,:)+1);
    end
    
    loc = find(ismember(perm_solution_mapping, rotated_structures, 'rows')==1);
    rotation_record{i} = loc;
end

reflection_record = repelem({[]}, size(perm_solution_mapping,1));
for i = 1:size(perm_solution_mapping,1)
    current_solution_mapping = perm_solution_mapping(i,:);
    reflection_structures = zeros(num_rotation, num_genotype);
    
    for j = 1:num_rotation
        reflection_structures(j,:) = current_solution_mapping(possible_reflection(j,:)+1);
    end
    
    loc = find(ismember(perm_solution_mapping, reflection_structures, 'rows')==1);
    reflection_record{i} = loc;
end


foldername = "data/group_record/invariant_record/";
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
save(strcat(foldername, spec, "_invariant_record.mat"), 'rotation_record', 'reflection_record');