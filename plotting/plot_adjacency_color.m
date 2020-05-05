% verify through another way

load("data/possible_reflection/cube-3_possible_reflection.mat");
load("data/possible_rotation/cube-3_possible_rotation.mat");
close all;
initial = hypercube(3);
bit_len = 3;
neighbour_index = compute_neighbour_list(bit_len);
adjacency_matrix = zeros(2^bit_len);

for k = 1:2^bit_len
    ind = neighbour_index(k,:);
    adjacency_matrix(k, ind+1) = k*10+ind+1;
end

plt_num = @(j) mod(j,4);
foldername = strcat("data/plots/adj/cube-", num2str(bit_len));
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
imagesc(adjacency_matrix);
save_num = 1;
figure(save_num);
for k = 1:10
    perm = possible_reflection(k,:)+1;
    im = imagesc(adjacency_matrix(perm, perm));
    colorbar
    t = title(strcat(num2str(bit_len), "-cube: ", "rotation #", num2str(k)));
    pos = get(t, 'position');
    text(pos(1), pos(2)*21, strcat("mapping: ", num2str(perm)), ...
        'HorizontalAlignment', 'center');
%         'VerticalAlignment', 'top', ...
        

%     if plt_num(k)==0
%         filename = strcat(foldername, "/rotation_", num2str(save_num), ".fig");
%         savefig(filename);
%         save_num = save_num + 1;
%         if k~=size(possible_rotation, 1)
% %             close all;
%             figure(save_num);
%         end
%     end
end