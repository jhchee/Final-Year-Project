%{
    Generates permutations of genotype-phenotype mapping
%}
disp(strcat("Running '", mfilename, "' ..."));
foldername = "data/mapping_data/complete/";
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
end_state = num_phenotype - 1;
x = num2str([0:end_state]); % string of phenotypes e.g. "0 1 2 3 4 5 6 7"
x(x==' ') = []; % remove whitepspace in the string

% create all possible permutations (with repetition) of letters stored in x
C = cell(num_genotype, 1); % preallocate a cell array
[C{:}] = ndgrid(x); % create K grids of values
% permutation of solution mapping for each genotypic state
perm_solution_mapping = cellfun(@(z){z(:)}, C); % convert grids to column vectors
perm_solution_mapping = [perm_solution_mapping{:}]; % obtain all permutations

% remove all the non-surjective mapping
check = false(length(perm_solution_mapping),1);
for i = 1:length(perm_solution_mapping)
    % if the phenotypic states are not fully mapped     
    if length(unique(perm_solution_mapping(i,:))) < end_state + 1
        check(i,1) = true;
    end
end
perm_solution_mapping(check,:) = []; % remove non-surjective mapping entry
perm_solution_mapping = perm_solution_mapping - '0'; % convert char array to num array

save(strcat(foldername, spec, "_mapping.mat"), "perm_solution_mapping");