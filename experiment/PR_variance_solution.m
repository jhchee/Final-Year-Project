% show the median and variance of each solution PR
% only includes one-to-one mapping since solution space is the same for all

close all;
load("config.mat");
restart_prob_list = [0.05, 0.30, 0.55, 0.85];

for i = 1:length(restart_prob_list)
    restart_prob = restart_prob_list(i);
    spec_restart = strcat(spec, "R", num2str(restart_prob)); % attaching restart probability
    count_solution_PR_variance = [];    
    result_label = [];
    for j = 1:8
        load(strcat("./data/PR_result/solution_invariant/", spec_restart, "_result.mat"));
        count_solution_PR_variance = [count_solution_PR_variance; page_rank_score_solution_collection(:,j)];
        label = repelem([num2str(j)], length(page_rank_score_solution_collection(:,j)));
        result_label = [result_label; label'];
    end
    subaxis(1,4,i);
    boxplot(count_solution_PR_variance, result_label);
    title(strcat("restart probability: ", num2str(restart_prob)));
    axis([0 9 0 1]);
end