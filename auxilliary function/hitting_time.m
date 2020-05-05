% compute the hitting time to single dominant solution
% it must be reducible e.g. single absorbing state
% comparision between reducible chain

function [N, hit_abs, mean_hit_abs] = hitting_time(transition_matrix, mapping)
    % first check whether is absorbing chain
    mc = dtmc(transition_matrix);
    [bins,ClassStates,ClassRecurrence,ClassPeriod] = classify(mc);
    num_rec = length(find(ClassRecurrence==1));
    if num_rec > 1
        N = 0;
        hit_abs = 0;
        mean_hit_abs = 0;
        return;
    end
    % the solution in the absorbing class is obviously the most dominant
    % solution
    dominant = max(mapping);
    row_num = size(transition_matrix,1);
    tracker = zeros(row_num,1);
    trans_count = 0;
    for index = 1:row_num
        % dominant of close neighbours/they're actually draw
       if transition_matrix(index,index)>0 ||  mapping(index) == dominant % if absorbing state
           tracker(index) = index; % absorbing chain is positive
       else
           trans_count = trans_count + 1;
           tracker(index) = index - row_num; % create negative index to help sorting
       end
    end
    [~, arrangment] = sort(tracker);
    % order the transition matrix by transient and then absorbing state 
    transition_matrix = transition_matrix(arrangment, arrangment);

    Q = transition_matrix(1:trans_count,1:trans_count);
    N = inv(eye(trans_count) - Q);
%     absorbing_state = find(tracker>0);
%     transient_state = find(tracker<=0);
    hit_abs = sum(N,2);
    mean_hit_abs = mean(hit_abs);
    
end

