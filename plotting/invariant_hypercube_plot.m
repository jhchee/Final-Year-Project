
clc;
close all;
load("config.mat");
foldername = "data/possible_rotation/";
filename = strcat(foldername, "cube-", num2str(bit_len),  "_possible_rotation.mat");
load(filename);
foldername = "data/possible_reflection/";
filename = strcat(foldername, "cube-", num2str(bit_len),  "_possible_reflection.mat");
load(filename);

nodes = num2cellstr(0:num_genotype-1)';
A = hypercube(bit_len);
G = graph(A,nodes);
edge_number = bit_len * 2^(bit_len-1);
h = plot(G,'layout','force3', 'EdgeColor', hsv(edge_number));
ori.X = h.XData;
ori.Y = h.YData;
ori.Z = h.ZData;
close all;
max_height = 2;
max_width = 2;
marker_size = 2;
line_width = 2;
font_size = 10;
unit_size = 450;
fig_position = [500, 300, unit_size*max_width, unit_size*max_height];
% zoom_size = 1.3;
zoom_size = 1.2;

% rotation
possible_rotation = [[0:num_genotype-1]; possible_rotation];
rotation_counter = 0;
plt_num = @(j) mod(j,4);
foldername = strcat("data/plots/cube-", num2str(bit_len));
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
save_num = 1;
figure(save_num);
for k = 1:size(possible_rotation,1)
    camlight
    set(gca,'color','k')
    set(gcf,'color','k')
    subplot(max_height, max_width,plt_num(rotation_counter)+1);
    rotation_counter =  rotation_counter + 1;
    hold on;
    
    h = plot(G,'layout', 'force3', 'EdgeColor', hsv(edge_number));
    h.MarkerSize = marker_size;
    h.LineWidth = line_width;
    h.NodeFontSize = font_size;
    h.NodeLabelColor = [1 1 1];
    axis off square
    set(gca,'clipping','off')
    set(gcf, 'Position', fig_position)
    zoom(zoom_size);
    perm = possible_rotation(k,:) + 1;
    set(h,'XData', ori.X(perm))
    set(h,'YData', ori.Y(perm))
    set(h,'ZData', ori.Z(perm))
    t = title(strcat(num2str(bit_len), "-cube: ", "invariant #", num2str(rotation_counter)), 'Color', 'white');
    pos = get(t, 'position');
    text(0, 0-pos(2), strcat("mapping: ", num2str(perm)), ...
        'VerticalAlignment', 'cap', ...
        'HorizontalAlignment', 'center', 'Color', 'w');
  
    if plt_num(rotation_counter)==0
        filename = strcat(foldername, "/rotation_", num2str(save_num), ".fig");
        savefig(filename);
        save_num = save_num + 1;
         saveas(gca, "fd.png");
        if k~=size(possible_rotation, 1)
            close all;
            figure(save_num);
        end
    end
   
end


% reflection
reflection_counter = rotation_counter;
plt_num = @(j) mod(j,4);
foldername = strcat("data/plots/cube-", num2str(bit_len));
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
save_num = 1;
figure(save_num);
for k = 1:size(possible_reflection, 1)
    camlight
    set(gca,'color','k')
    set(gcf,'color','k')
    subplot(max_height,max_width,plt_num(reflection_counter)+1);
    reflection_counter =  reflection_counter + 1;
    hold on;
    
    h = plot(G,'layout','force3', 'EdgeColor', hsv(edge_number));
    h.MarkerSize = marker_size;
    h.LineWidth = line_width;
    h.NodeFontSize = font_size;
    h.NodeLabelColor = [1 1 1];
    axis off square
    set(gca,'clipping','off')
    set(gcf, 'Position', fig_position)
    zoom(zoom_size);
    perm = possible_reflection(k,:) + 1;
    set(h,'XData', ori.X(perm))
    set(h,'YData', ori.Y(perm))
    set(h,'ZData', ori.Z(perm))
    t = title(strcat(num2str(bit_len), "-cube: ", "invariant #", num2str(reflection_counter)), 'Color', 'white');
    pos = get(t, 'position');
    text(0, 0-pos(2), strcat("mapping: ", num2str(perm)), ...
        'VerticalAlignment', 'cap', ...
        'HorizontalAlignment', 'center', 'Color', 'w');
    
    if plt_num(reflection_counter)==0
        filename = strcat(foldername, "/reflection_", num2str(save_num), ".fig");
        savefig(filename);
        save_num = save_num + 1;
        if k~=size(possible_rotation, 1)
            close all;
            figure(save_num);
        end
    end
end

