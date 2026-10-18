
clc
close all
clear all

addpath('./incodes/')

L = 100;

data_path1 = ['./Generated powerlaw Lattice Embedded Networks L=' num2str(L) ' mu=3.6231'];
data_path2 = ['/mat_matrices'];
mat_name = ['/matrices_mypowerlawLEN_L=' num2str(L) '_mu=3.6231_number=1.mat'];
net_name = ['powerlaw12L' num2str(L)];
show_step = 9;

%%
data_pathname = strcat(data_path1,data_path2,mat_name);

load([data_pathname])
weight_adjacent = full(adjacent_matrix); 

Nx = sqrt(size(weight_adjacent, 1));
Ny = sqrt(size(weight_adjacent, 2));

[x_2d, y_2d] = meshgrid((1:Nx)-0.5, (1:Ny)-0.5);

D = Nx;
%%
x = x_2d(:); y = y_2d(:);

hfig=figure('Color',[1 1 1]);
set(0,'DefaultFigureVisible', 'on')
set(gcf,'Position', [100    100    600    600]);
hold on
lw = 1.5;
plot([0,0],[0,D],'linewidth',lw,'color',[0.5 0.5 0.5 ])
plot([0,D],[D,D],'linewidth',lw,'color',[0.5 0.5 0.5 ])
plot([D,D],[0,D],'linewidth',lw,'color',[0.5 0.5 0.5 ])
plot([D,0],[0,0],'linewidth',lw,'color',[0.5 0.5 0.5 ])


colorname = 'k'; lw = 0.3;
Number_nodes = size(weight_adjacent,1);
for i=1:Number_nodes
    disp(['i = ' num2str(i)])
      for j=find(weight_adjacent(i,:)==1)
          startpoint = [x(j) y(j)];
          endpoint = [x(i) y(i)];
          [distance position_cases] = distance_computing(x(i),y(i),x(j),y(j),D);
          R = distance * 1.5;
          plot_PBc(startpoint,endpoint,R,D,colorname, lw);
      end
end      


degree = sum(weight_adjacent,1);

max(degree)

pos1_ = find(degree>36);
pos2_ = find(degree<50);
pos_ = intersect(pos1_,pos2_);
degree_ = degree(pos_);
central_point_index1 = pos_(35)
central_point_degree = degree(central_point_index1)
[central_nodex central_nodey] = conv_index_to_coordinate2d(central_point_index1, Ny );
% central_nodex = fix(Nx/2); central_nodey = fix(Ny/2);
% central_nodex = 4; central_nodey = 1;
central_point_index = conv_coordinate2d_to_index(central_nodex, central_nodey, Ny )

colorname = 'b'; lw = 1.0;
for i=central_point_index
    disp(['i = ' num2str(i) ',   number neighbor = ' num2str(length(find(weight_adjacent(i,:)==1)))])
      for j=find(weight_adjacent(i,:)==1)
          startpoint = [x(j) y(j)];
          endpoint = [x(i) y(i)];
          [distance position_cases] = distance_computing(x(i),y(i),x(j),y(j),D);
          R = distance * 1.5;
          plot_PBc(startpoint,endpoint,R,D,colorname, lw);
      end
end   


scatter(x,y,10,'MarkerEdgeColor','k',...
    'MarkerFaceColor','k',...
    'Marker','.')

center_point_color = 'r';
plot(central_nodex-0.5,central_nodey-0.5,'LineStyle','none',...
    'MarkerSize',3,'Marker','pentagram','LineWidth',1.5,...
    'MarkerFaceColor',center_point_color,'MarkerEdgeColor',center_point_color);

axis equal
axis off
% view(3)
%%


x_low = central_nodex-show_step;
x_top = central_nodex+show_step-1;
y_low = central_nodey-show_step;
y_top = central_nodey+show_step-1;
lw = 1.0; colorname= [1 0.411764705882353 0.16078431372549];
plot([x_low,x_low],[y_low,y_top],'linewidth',lw,'color',colorname);
plot([x_top,x_low],[y_top,y_top],'linewidth',lw,'color',colorname);
plot([x_top,x_top],[y_top,y_low],'linewidth',lw,'color',colorname);
plot([x_low,x_top],[y_low,y_low],'linewidth',lw,'color',colorname);

set(gca, 'LooseInset', [0.01,0.01,0.01,0.01]);

eps_name = ['./Fig1A.eps'];
print(eps_name,'-depsc')
saveas(gcf,['./Fig1A.jpg'])
disp('save eps done!')
