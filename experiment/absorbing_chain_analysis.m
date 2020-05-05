% show the number of absorbing chain in each mapping
clear;
clc;
load("config.mat");


% count = [];
% total
% for num_phenotype = 2:8
%     spec = strcat("G", num2str(num_genotype), "P", num2str(num_phenotype));
%     load(strcat("./data/analysis/abs_chain_stats/", spec, "_abs_stat.mat"), 'abs_stats');
%     count = [count length(find(abs_stats==1))];
% end

valid_stats = [];
for num_phenotype = 2:8
    spec = strcat("G", num2str(num_genotype), "P", num2str(num_phenotype));
%     spec_restart = strcat(spec, "R", num2str(restart_prob));
%     load(strcat("data/HT_to_abs_result/", spec, "_result.mat"), ...
%     "N_result","hit_abs_result","mean_hit_abs_result" ...
%     );
%     load(strcat("data/mapping_data/solution_invariant/", spec, "_mapping.mat"));
%     abs_chain_idx = find(mean_hit_abs_result>0);
    load(strcat("./data/analysis/abs_chain_stats/", spec, "_abs_stat.mat"), 'abs_stats');
    num_abs = length(find(abs_stats==1));
    total_mapping = length(abs_stats);
    
    valid_stats = [valid_stats; [num_abs,total_mapping]];
end
x = num2str([2:8]);
x = strsplit(x);
X = categorical(x);
X = reordercats(X,x);
y = valid_stats;
y_per = y(:,1)./y(:,2);
label = strcat(string(y(:,1)),"/", string(y(:,2)), " = ", string(y_per));
figure(1)
title("Number of mappings lead to absorbing chain")
b = bar(X,y,'stacked');
xtips = b(2).XEndPoints;
ytips = b(2).YEndPoints;
text(xtips,ytips,label,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
xlabel('Number of phenotypes')
ylabel('Frequency')
legend('Absorbing chain','Non absorbing chain');
title("Absorbing chain and non-absorbing chain in mapping");

