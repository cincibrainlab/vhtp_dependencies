% File to test the use of local efficiency measure of a binary undirected graph.
%
% See also Graph, GraphBU.

% Author: Mite Mijalkov, Ehsan Kakaei & Giovanni Volpe
% Date: 2016/01/01

close all
clear all
clc

%% Create Graph and Calculate Local Efficiency
A = [0 1 0 1 0 0 0 0;...
     0 0 1 0 1 0 0 0;...
     1 0 0 0 1 0 0 0;...
     0 0 1 0 1 0 0 0;...
     0 0 0 0 0 1 1 0;...
     0 0 0 0 0 0 0 1;...
     0 0 0 0 0 0 0 1;...
     0 0 0 0 0 0 0 0];
graph = GraphBU(A,'threshold',0);
N = graph.nodenumber();
[a,b] = graph.leff();
disp('local efficiency of nodes:')
disp(b)
disp('local efficiency of graph:')
disp(a)

%% Show the Graph 
x = [0 15 15 15 30 45 45 60];
y = [0 15 0 -15 0 8 -8 0];
figure('Position',[300 150 500 500],'Color','w')
hold on
plot(x,y,'.r','MarkerSize',40)
for j = 1:1:N
    AA = char('A'+j-1);
    if sign(x(1,j))<1
        text(x(1,j)+3*sign(x(1,j)), y(1,j)+.5*sign(y(1,j)), AA,'Interpreter','latex','FontSize',20)
    else
        text(x(1,j)+sign(x(1,j)), y(1,j)+.5*sign(y(1,j)), AA,'Interpreter','latex','FontSize',20)
    end
    for i = 1:1:N
        if graph.A(i,j)==1
            line([x(1,i),x(1,j)],[y(1,i),y(1,j)],'Color','k','LineWidth',2);
        end
    end
end
axis equal
axis off