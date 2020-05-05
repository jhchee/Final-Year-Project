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

% remove rotation
counter = 1;
while (counter < size(perm_solution_mapping,1)) % scan never get pass the total length
    current_solution_mapping = perm_solution_mapping(counter,:);
    rotated_structures = zeros(num_rotation, num_genotype);
    
    for j = 1:num_rotation
        rotated_structures(j,:) = current_solution_mapping(possible_rotation(j,:)+1);
    end
    
    loc = find(ismember(perm_solution_mapping(counter+1:end, :), rotated_structures, 'rows')==1)+counter;
%     rotation_record = [rotation_record; [counter,length(loc)]];
    perm_solution_mapping(loc, :) = [];
    counter = counter + 1;
end

% remove reflection
counter = 1;
while (counter < size(perm_solution_mapping,1))
    current_solution_mapping = perm_solution_mapping(counter,:);
    reflected_structures = zeros(num_reflection, num_genotype);
    
    for j = 1:num_reflection
        reflected_structures(j,:) = current_solution_mapping(possible_reflection(j,:)+1);
    end
    
    loc = find(ismember(perm_solution_mapping(counter+1:end, :), reflected_structures, 'rows')==1)+counter;

%     reflection_record = [reflection_record; [counter,length(loc)]];
    perm_solution_mapping(loc, :) = [];
    counter = counter + 1;
end


foldername = "data/mapping_data/solution_invariant/";
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
save(strcat(foldername, spec, "_mapping.mat"), 'perm_solution_mapping');