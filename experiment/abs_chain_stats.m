% compile the absorbing chain statistic with each mapping

load("config.mat");
num_genotype = 8;


for num_phenotype = 2:8
    spec = strcat("G", num2str(num_genotype), "P", num2str(num_phenotype));
    load(strcat("./data/mapping_data/solution_invariant/", spec, "_mapping.mat"));
    abs_stats = true(size(perm_solution_mapping,1),1);
    abs_state = cell(size(perm_solution_mapping,1),1);
    rec_num_freq_collection = [];
    rec_states_num_collection = [];
    for i = 1:size(perm_solution_mapping,1)
        mapping = perm_solution_mapping(i,:);
        t = construct_transition_matrix(mapping, num_genotype, neighbour_index);
        mc = dtmc(t);
        [bins,ClassStates,ClassRecurrence,ClassPeriod] = classify(mc);
        num_rec = length(find(ClassRecurrence==1));
        current_abs_state = [];
        char_class = ClassStates(ClassRecurrence==1);
        
        rec_states_num = zeros(1,num_genotype)-1;
        rec_num_freq = zeros(1,num_genotype);
        for j = 1:length(char_class)  
            rec_states_num(j) = mapping(str2double(char_class{j}(1))); % the solution
            rec_num_freq(j) = length(char_class{j});
        end
        [rec_states_num,ix] = sort(rec_states_num);
        rec_num_freq = rec_num_freq(ix); 
        
        rec_states_num_collection = [rec_states_num_collection; rec_states_num];
        rec_num_freq_collection = [rec_num_freq_collection; rec_num_freq];
        
        abs_state{i} = char_class;
        if (num_rec > 1)
            abs_stats(i) = false;
        end
    end
    
    save(strcat("./data/analysis/abs_chain_stats/", spec, "_abs_stat.mat"), 'abs_stats', 'abs_state', 'rec_states_num_collection', 'rec_num_freq_collection');
end