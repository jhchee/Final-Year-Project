% compute hitting time for absorbing chain
% group states according to transient and absorbing state
% the rationale is to segregate the abs and transient state
% transient state is irreachable from an absorbing state
% argument: N, fundamental matrix
% function [hit_time_abs, hit_time_trans, absorbing_state, transient_state] = compute_hitting_time(transition_matrix)
function  [absorbing_state, transient_state, hit_time_abs, hit_time_trans] = compute_hitting_time(transition_matrix, bit_len)
    row_num = size(transition_matrix,1);
    tracker = zeros(row_num,1);
    trans_count = 0;
    for index = 1:row_num
       if 1 == transition_matrix(index,index) % if absorbing state
           tracker(index) = index; % absorbing chain is positive
       else
           trans_count = trans_count + 1;
           tracker(index) = index - row_num; % create negative index to help sorting
       end
    end
    [~, arrangment] = sort(tracker);
    % order the transition matrix by transient and then absorbing state 
    transition_matrix_c = transition_matrix(arrangment, arrangment);

    Q = transition_matrix_c(1:trans_count,1:trans_count);
    N = pinv(eye(trans_count) - Q);
    absorbing_state = find(tracker>0);
    transient_state = find(tracker<=0);
    num_trans = length(transient_state);
    
    % hitting time from transient to absorbing state
    hit_time_abs = sum(N,2)./size(N,1);

    % take the sum of the absorbing columns
    sum_abs_col = sum(transition_matrix(:, absorbing_state),2);
    sum_abs_col(absorbing_state, :) = [];
    temp_t = transition_matrix;
    temp_t(absorbing_state, :) = [];
    temp_t(:, absorbing_state) = [];
    temp_t = [temp_t, sum_abs_col];
    padding = zeros(1, num_trans+1);
    padding(end) = 1;
    temp_t = [temp_t; padding];
    
%     mc = dtmc(temp_t);
%     ht_transient = zeros(num_trans+1, num_trans+1);
%     for i = 1:size(temp_t,1)
%         ht_transient(:, i) = hittime(mc, i); 
%     end
    
    % remotely reachable state is not inf
    hit_time_abs = zeros(num_trans+1, num_trans+1);
    for i = 1:num_trans
        init_state = zeros(1,num_trans+1);
        init_state(1,i) = 1;
        r_prev = init_state;
        for j = 1:bit_len
            r = r_prev*temp_t;
            ind = intersect(find(r_prev==0),find(r>0)); % update if diff
            hit_time_abs(i, ind) = j;
            r_prev = r;
        end
    end
end