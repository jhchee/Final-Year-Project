%{ 
    convert binary to decimal
%}
function output = bin_dec2dec(input)
    num_bits = length(input);
    output = 0;
    for i = 1:num_bits
        output = output +  2^(num_bits-i)*input(i);
    end
end