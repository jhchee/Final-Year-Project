%{ 
    Take one norm between two PR vectors
%}
function one_norm = page_rank_one_norm(source, target)
    one_norm = sum(abs(source-target),2);
end