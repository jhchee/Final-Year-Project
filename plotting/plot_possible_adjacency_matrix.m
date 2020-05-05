bit_len = 4;
neighbour_index = compute_neighbour_list(bit_len);
adjacency_matrix = zeros(2^bit_len);

for i = 1:2^bit_len
    ind = neighbour_index(i,:);
    adjacency_matrix(i, ind+1) = i+5;
end

imagesc(adjacency_matrix);