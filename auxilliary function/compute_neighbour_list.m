%{ 
    compute the neighbour list for each genotype
%}
function neighbour_index = compute_neighbour_list(bit_len)
    % compute and store neighbour index
    % a.k.a neighbors
    % e.g. 0: [4,2,1], neighbours of 0 are 4, 2 and 1
    
    neighbour_index = zeros(2^bit_len, bit_len);
    num_genotype = 2^bit_len;
    genotypic_state = dec2bin([0:1:num_genotype-1]) - '0';
    % genotype neighborhood
    for i = 1:num_genotype
        current_genotype = genotypic_state(i,:);
        for j = 1:bit_len
           flipped_bit = current_genotype;
           flipped_bit(j) = ~flipped_bit(j);
           neighbour = bin_dec2dec(flipped_bit);
           neighbour_index(i, j) = neighbour;
        end
    end
end

