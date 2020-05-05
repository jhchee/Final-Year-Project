% show the median and variance of each abs and non-abs
% only for one-to-one mapping

close all;
load("config.mat");
load(strcat("./data/analysis/abs_chain_stats/", spec, "_abs_stat.mat"), 'abs_stats');
load(strcat("./data/PR_result/solution_invariant/", spec_restart, "_result.mat"));
num_phenotype = 8;
count_solution_PR_abs = [];
result_label_abs = [];
page_rank_score_solution_abs = page_rank_score_solution_collection(abs_stats,:);
for j = 1:8    
    count_solution_PR_abs = [count_solution_PR_abs; page_rank_score_solution_abs(:,j)];
    label = repelem([num2str(j)], length(page_rank_score_solution_abs(:,j)));
    result_label_abs = [result_label_abs; label'];
end
figure();
boxplot(count_solution_PR_abs, result_label_abs);
title("Absorbing chain");
xlabel("Solutions");
ylabel("PageRank score");
axis([0 9 0 1]);

count_solution_PR_non_abs = [];
result_label_non_abs = [];
page_rank_score_solution_abs = page_rank_score_solution_collection(~abs_stats,:);
for j = 1:8    
    count_solution_PR_non_abs = [count_solution_PR_non_abs; page_rank_score_solution_abs(:,j)];
    label = repelem([num2str(j)], length(page_rank_score_solution_abs(:,j)));
    result_label_non_abs = [result_label_non_abs; label'];
end
figure();
boxplot(count_solution_PR_non_abs, result_label_non_abs);
title("Non-absprbing chain");
xlabel("Solutions");
ylabel("PageRank score");
axis([0 9 0 1]);

