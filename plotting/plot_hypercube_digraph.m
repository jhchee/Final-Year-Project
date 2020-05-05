close all;
load("config");

A = hypercube(3);
nodes = cellstr(dec2bin(0:8-1));
G = graph(A,nodes);
plot(G)
view(100,100)
axis equal off
print(gcf,'./plotting/cube_3.png','-dpng','-r1000');

figure
x = cubelet;
x = [3*x; x];
nodes = cellstr(dec2bin(0:16-1));
A = hypercube(4);
G = graph(A,nodes);
plot(G,'xdata',x(:,1),'ydata',x(:,2),'zdata',x(:,3))
axis equal off
view(-20,11)
print(gcf,'./plotting/cube_4.png','-dpng','-r1000');