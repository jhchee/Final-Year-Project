% return utility matrices for the computation of some metrics
% return:   N, fundamental matrix
%           Q, TR->TR
%           R, TR->ABS
%           canonical_mat, canonical matrix
%           arragement, reorder indices
function [N, Q, R, canonical_mat, arrangment] = compute_utility_matrix(transition_matrix)
    row_num = size(transition_matrix,1);
    tracker = zeros(row_num,1);
    abs_count = 0;
    for index = 1:row_num
       if ismember(1, transition_matrix(index,:))
           tracker(index) = index;
       else
           abs_count = abs_count + 1;
           tracker(index) = index - row_num; % create negative index to help sorting
       end
    end
    [~, arrangment] = sort(tracker);
    % order the transition matrix by transient and then absorbing state 
    transition_matrix = transition_matrix(arrangment, :);
    transition_matrix = transition_matrix(:, arrangment);
    
    canonical_mat = transition_matrix;
    R = transition_matrix(1:abs_count,abs_count+1:end); 
    Q = transition_matrix(1:abs_count,1:abs_count);
    N = inv(eye(abs_count) - Q);
end