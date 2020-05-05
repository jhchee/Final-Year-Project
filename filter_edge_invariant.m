%{
    Group and filter structure with no PR difference (the solution label on
    the genotype no longer important, but the edge structure), solution
    label no longer preserved. The filtered list contains only distinct
    structure. This is the strength of page rank to find similar edge
    structure.

    Filter invariant structure first to remove large amount of invariant
    structure. Then carry out to filter the rest similar edge structure.

    This is a total filtering of the same edge strcuture, solution label is
    not preserved.

    Filter on solution invariant structure.
%}


disp(strcat("Running '", mfilename, "' ..."));
load('config.mat');
load(strcat("data/mapping_data/solution_invariant/", spec, "_mapping.mat"));
load(strcat("data/possible_rotation/","cube-", num2str(bit_len), "_possible_rotation.mat"));
load(strcat("data/possible_reflection/","cube-", num2str(bit_len), "_possible_reflection.mat"));


% pack the domination matrix
domination_m_mapping = repelem({[]}, size(perm_solution_mapping, 1));
for i = 1:size(perm_solution_mapping, 1)
    [~, ~, domination_m] = construct_transition_matrix(perm_solution_mapping(i,:), num_genotype, neighbour_index);
    domination_m_mapping{i}= domination_m;
end

counter = 1;
counter_same = 0;
disp("same");
while (counter < size(perm_solution_mapping,1)) % scan never get pass the total length
    domination_m = domination_m_mapping{counter};
    loc = [];
   
    for i = counter+1:length(perm_solution_mapping) % scan beyond the current mapping
        if isequal(domination_m, domination_m_mapping{i})
            loc = [loc; i];
            counter_same = counter_same + 1;
        end
    end
    domination_m_mapping(loc) = [];
    perm_solution_mapping(loc,:) = [];
    counter = counter + 1;
%     if ~isempty(loc) % debug
%         disp("counter: " + counter);  disp(length(loc));
%     end
end


num_rotation = size(possible_rotation,1);
num_reflection = size(possible_reflection,1);

% filter by the rotation
counter_rotation =  0;
counter = 1;
disp("rotation");
while (counter < length(domination_m_mapping)) % scan never get pass the total length
    domination_m = domination_m_mapping{counter};
    rotation_structure = zeros(num_rotation, num_genotype, num_genotype);
    loc = [];
    % all possible rotation
    for i = 1:num_rotation
        indices = possible_rotation(i,:) + 1;
        rotation_structure(i,:, :) = domination_m(indices, indices);
    end
    
    for i = 1:size(rotation_structure,1)
        current_rotated_structure = reshape(rotation_structure(i,:,:),[num_genotype, num_genotype]);
        for j = counter+1:length(domination_m_mapping) % scan beyond the current mapping
            if isequal(current_rotated_structure, domination_m_mapping{j})
                loc = [loc; j];
                counter_rotation = counter_rotation  + 1;
            end
        end
    end
%     if ~isempty(loc) % debug
%         disp("counter: " + counter);  disp(length(loc));
%     end
    domination_m_mapping(loc) = [];
    perm_solution_mapping(loc,:) = [];
    counter = counter + 1;
end

% filter by the reflection
counter_reflection = 0;
counter = 1;
disp("reflection");
while (counter < length(domination_m_mapping)) % scan never get pass the total length
    domination_m = domination_m_mapping{counter};
    reflection_structure = zeros(num_reflection, num_genotype, num_genotype);
    loc = [];
    % all possible reflefction
    for i = 1:num_reflection
        indices = possible_reflection(i,:) + 1;
        reflection_structure(i,:, :) = domination_m(indices, indices);
    end
    
    for i = 1:size(reflection_structure,1)
        current_reflected_structure = reshape(reflection_structure(i,:,:),[num_genotype, num_genotype]);
        for j = counter+1:length(domination_m_mapping)
            if isequal(current_reflected_structure, domination_m_mapping{j})
                loc = [loc; j];
                counter_reflection = counter_reflection + 1;
            end
        end
    end
%     if ~isempty(loc) % debug
%         disp("counter: " + counter);  disp(length(loc));
%     end
    domination_m_mapping(loc) = [];
    perm_solution_mapping(loc,:) = [];
    counter = counter + 1;
end


foldername = "data/mapping_data/edge_invariant/";
filename = strcat(foldername, spec, "_mapping.mat");
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
save(filename, 'perm_solution_mapping');