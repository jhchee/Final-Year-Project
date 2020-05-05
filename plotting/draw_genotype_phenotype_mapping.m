%{ 
    Draw the genotype to phenotype mapping
%}

% arguments: mapping, defines which solution the genotype mapped to
function draw_genotype_phenotype_mapping(solution_mapping)
    figure();
    load('config.mat');
    solution_mapping = flip(solution_mapping);
    state_list = flip(state_list);
    genotypic_state = flip(genotypic_state);
    
    x = [1 bit_len]; % space between genotype and phenotype
    x = repelem(x, [num_genotype num_phenotype]);
    y = [1:num_genotype 1:num_phenotype]; % space between genotypes/phenotypes
    coordinate = [x;y]';
    
    genotype = coordinate(1:num_genotype,:);
    phenotype = coordinate(num_genotype+1:num_phenotype+num_genotype, :);
    scatter(x,y);
    
    dx = 0.4;
    label = dec2bin(0:length(genotypic_state)-1);
    label = label(end:-1:1, :);
    text(genotype(:,1) - dx, genotype(:,2), label);
    dx = 0.2;
    label = num2str(state_list');
    text(phenotype(:,1) + dx, phenotype(:,2), label);
    title("Genotype to phenotype mapping");
    daspect([1 2 3]);
    axis off ; 
    for i = 1:num_genotype
        hold on
        arrow3(genotype(i,:), phenotype(num_phenotype-(solution_mapping(i)),:));
    end
    hold off
end