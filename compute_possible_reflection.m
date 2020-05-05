%{ 
    a more precise description for this code is doing
    this composes the reflection mapping and rotation mapping to yield all possible symmetries
%}


disp(strcat("Running '", mfilename, "' ..."));
load('config.mat');
foldername = "data/reflection_indices/";
filename = strcat(foldername, "cube-", num2str(bit_len), "_reflection_indices.mat");
load(filename);
foldername = "data/rotation_indices/";
filename = strcat(foldername, "cube-", num2str(bit_len), "_rotation_indices.mat");
load(filename);
foldername = "data/possible_rotation/";
filename = strcat(foldername, "cube-", num2str(bit_len), "_possible_rotation.mat");
load(filename);

initial_mapping = [0:1:num_genotype-1];

m = [];
for i = 1:size(reflection_indices,1)
    current_reflection = reflection_indices(i,:); % clone the variable to prevent overwrite
    m = [m; current_reflection(possible_rotation+1)];  
end

m_unique = unique(m, 'rows'); % remove combined reflection that lead to the same mapping

% remove possible rotation
possible_reflection = m_unique;
possible_reflection(ismember(m_unique, possible_rotation, 'rows'),:) = []; % remove rotation indices

foldername = "data/possible_reflection/";
filename = strcat(foldername, "cube-", num2str(bit_len),  "_possible_reflection.mat");
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
save(filename, 'possible_reflection');

