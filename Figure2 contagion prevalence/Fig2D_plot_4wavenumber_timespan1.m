clear all;
close all;
clc; 
FS = 28;



%%
load data_calc_Sim_sk_Delta12_3072 datSk2 

data_Delta12_3072 = datSk2;
timeseries = data_Delta12_3072(:,1);
meanqmax_Delta12_3072 = zeros(length(data_Delta12_3072), 1); % 存储平均值
stdqmax_Delta12_3072 = zeros(length(data_Delta12_3072), 1); % 存储方差

for i=1:length(data_Delta12_3072)
    qmaxValues = data_Delta12_3072(i, 2:end);
    meanqmax_Delta12_3072(i) = mean(qmaxValues, 'omitnan'); % 计算平均值，忽略NaN值
    stdqmax_Delta12_3072(i) = std(qmaxValues, 'omitnan'); 
end

%%
load data_calc_Sim_sk_Poisson12_3072 datSk2 

data_Poisson12_3072 = datSk2;
timeseries = data_Poisson12_3072(:,1);
meanqmax_Poisson12_3072 = zeros(length(data_Poisson12_3072), 1); % 存储平均值
stdqmax_Poisson12_3072 = zeros(length(data_Poisson12_3072), 1); % 存储方差

for i=1:length(data_Poisson12_3072)
    qmaxValues = data_Poisson12_3072(i, 2:end);
    meanqmax_Poisson12_3072(i) = mean(qmaxValues, 'omitnan'); % 计算平均值，忽略NaN值
    stdqmax_Poisson12_3072(i) = std(qmaxValues, 'omitnan'); 
end
%%
load data_calc_Sim_sk_Powerlaw12_3072 datSk2 

data_Powerlaw12_3072 = datSk2;
timeseries = data_Powerlaw12_3072(:,1);
meanqmax_Powerlaw12_3072 = zeros(length(data_Powerlaw12_3072), 1); % 存储平均值
stdqmax_Powerlaw12_3072 = zeros(length(data_Powerlaw12_3072), 1); % 存储方差

for i=1:length(data_Powerlaw12_3072)
    qmaxValues = data_Powerlaw12_3072(i, 2:end);
    meanqmax_Powerlaw12_3072(i) = mean(qmaxValues, 'omitnan'); % 计算平均值，忽略NaN值
    stdqmax_Powerlaw12_3072(i) = std(qmaxValues, 'omitnan'); 
end

%%

start=251;
span=5;

x=data_Delta12_3072(start:span:end,1);
x=data_Delta12_3072(398:span:500,1);

figure('Position', [300 200 600+20 500]);
hold on

% errorbar(data_Delta4_3072(start:span:end,1),meanqmax_Delta4_3072(start:span:end),stdqmax_Delta4_3072(start:span:end), ...
%     'LineWidth',2,'color','b');
% y=187.868941*x.^-0.164377;
% loglog(x,y,'LineWidth',2,'LineStyle','--','Color','k');

% errorbar(data_Delta12_3072(start:span:end,1),meanqmax_Delta12_3072(start:span:end),stdqmax_Delta12_3072(start:span:end), ...
%     'LineWidth',2,'color','c');

loglog(data_Delta12_3072(start:span:end,1), meanqmax_Delta12_3072(start:span:end), ...
    'D', 'markersize', 6, 'color', 'b', 'DisplayName', 'Original data');
y=134.052455*x.^-0.242149+0.3; %0.003
loglog(x,y,'LineWidth',2,'LineStyle','-','Color','k');
text('FontSize',20,'Rotation',-15,'Interpreter','latex',...
    'String','Delta: $q_{\rm{max}}\sim t^{-0.24\pm0.01}$',...
    'Position',[885.863366318446 28.5118212083346 0],...
    'Color','b');

% errorbar(data_Poisson12_3072(start:span:end,1),meanqmax_Poisson12_3072(start:span:end),stdqmax_Poisson12_3072(start:span:end), ...
%     'LineWidth',2,'color','r');
loglog(data_Poisson12_3072(start:span:end,1), meanqmax_Poisson12_3072(start:span:end), ...
    'D', 'markersize', 6, 'color', 'r', 'DisplayName', 'Original data');
y=127.419129*x.^-0.271085+0.3; %0.005
loglog(x,y,'LineWidth',2,'LineStyle','-','Color','k');
text('FontSize',20,'Rotation',-15,'Interpreter','latex',...
    'String','Poisson: $q_{\rm{max}}\sim t^{-0.27\pm0.01}$',...
    'Position',[551.888385738594 14.7438950790216 0],...
    'Color','r');
% errorbar(data_Powerlaw12_3072(start:span:end,1),meanqmax_Powerlaw12_3072(start:span:end),stdqmax_Powerlaw12_3072(start:span:end), ...
%     'LineWidth',2,'color','m');
loglog(data_Powerlaw12_3072(start:span:end,1), meanqmax_Powerlaw12_3072(start:span:end), ...
    'D', 'markersize', 6, 'color', 'm', 'DisplayName', 'Original data');
y=64.661619*x.^-0.284936+0.1; % 0.003
loglog(x,y,'LineWidth',2,'LineStyle','-','Color','k');
text('FontSize',20,'Rotation',-15,'Interpreter','latex',...
    'String','Power-law: $q_{\rm{max}}\sim t^{-0.28\pm0.01}$',...
    'Position',[360.46670515056 7.29827715861784 0],...
    'Color','m');
% text(151.61882566846, 10.8506486483043,'$q_{\rm{max}}\sim t^{-0.139214\pm0.003}$', ...
%     'Interpreter','latex','fontsize',24,'Color','r')
% text('FontSize',24,'Rotation',-55,'Interpreter','latex',...
%     'String','$q_{\rm{max}}\sim t^{-0.134\pm0.003}$',...
%     'Position',[336.967036523581 5.74500414115928 0],...
%     'Color',[1 0 0]);
%plot(x,y,'--'); 

% title(['time: ' num2str(timeseries(348),'%.1f') '$\sim$' num2str(timeseries(430),'%.1f') ], ...
%     'Interpreter','latex','Color','r')
% xline(timeseries(348))
% xline(timeseries(430))

set(gca,'xtick',[500,1000,3000,8000])
set(gca,'xticklabel',[500,1000,3000,8000])
set(gca,'ytick',[5,10,20,30])
set(gca,'yticklabel',[5,10,20,30])

xlim([270 1e4+300]);
ylim([4 32])
box on

set(gca,'XScale','log','YScale','log');
set(gca,'fontsize',FS,'linewidth',2,'xminortick','on','yminortick','on',...
    'ticklength',[0.025 0.025]);
set(gca,'FontName','Times'); set(gcf,'Color',[1,1,1]);

% xlabel('Time, $t$ ','Interpreter','latex','fontsize',26);
% ylabel(['Dominant wavenumbers' newline '$q_{\rm{max}}$'],'Interpreter','latex','fontsize',26);
xlabel('Time, $t$ ','Interpreter','latex','fontsize',28);
ylabel(['Dominant wavenumbers' newline '$q_{\rm{max}}$'],'Interpreter','latex','fontsize',28);

ax = gca;
ax.XAxis.FontSize = 28;  
ax.XAxis.FontName = 'Times New Roman';  
ax.YAxis.FontSize = 28;  
ax.YAxis.FontName = 'Times New Roman';  
ax.XAxis.TickDirection = 'in';
ax.XAxis.TickLength = [0.025 0.025];
ax.YAxis.TickDirection = 'in';
ax.XAxis.TickLabelInterpreter = 'latex';
ax.YAxis.TickLabelInterpreter = 'latex';

str = ['./Fig2D.eps'];
print(str,'-depsc')