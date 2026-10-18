clear all
close all
clc 
FS = 28;


load data_calc_wavelength_Delta12_3072 dataLS wavelength PSDTime
dataLS_Delta12_3072 = dataLS;
timeseries_Delta12_3072=dataLS(1,:);
MeanWave_Delta12_3072=mean(dataLS(2:end,:));
SDWave_Delta12_3072=std(dataLS(2:end,:));

load data_calc_wavelength_Poisson12_3072 dataLS wavelength PSDTime
dataLS_Poisson12_3072 = dataLS;
timeseries_Poisson12_3072=dataLS(1,:);
MeanWave_Poisson12_3072=mean(dataLS(2:end,:));
SDWave_Poisson12_3072=std(dataLS(2:end,:));

load data_calc_wavelength_Powerlaw12_3072 dataLS wavelength PSDTime
dataLS_Powerlaw12_3072 = dataLS;
timeseries_Powerlaw12_3072=dataLS(1,:);
MeanWave_Powerlaw12_3072=mean(dataLS(2:end,:));
SDWave_Powerlaw12_3072=std(dataLS(2:end,:));



figure('Position', [10 10 600 500]);
hold on

span=3;
x=dataLS_Delta12_3072(1,1:span:end);
x=dataLS_Delta12_3072(1,308:span:430);
% errorbar(dataLS_Delta4_3072(1,1:span:end),MeanWave_Delta4_3072(1:span:end),SDWave_Delta4_3072(1:span:end), ...
%     'LineWidth',2,'color','b');
% 
% y=34.959813*x.^0.107926;
% loglog(x,y,'LineWidth',2,'LineStyle','--','Color','k');

errorbar(dataLS_Delta12_3072(1,1:span:end),MeanWave_Delta12_3072(1:span:end),SDWave_Delta12_3072(1:span:end), ...
    'Marker','o','MarkerSize',5,'LineStyle','none','LineWidth',2,'Color','b','CapSize',5);
y=59.670188*x.^0.162481; %0.010
y=91.218693*x.^0.108058; % 0.008

text('FontSize',20,'Rotation',0,'Interpreter','latex',...
    'String','Delta: $l\sim t^{0.11\pm0.01}$',...
    'Position',[1263.14363478334 160.624247986374 0],...
    'Color','b');
loglog(x,y,'LineWidth',2,'LineStyle','-','Color','k');

errorbar(dataLS_Poisson12_3072(1,1:span:end),MeanWave_Poisson12_3072(1:span:end),SDWave_Poisson12_3072(1:span:end), ...
    'Marker','o','MarkerSize',5,'LineStyle','none','LineWidth',2,'Color','r','CapSize',5);
y=42.244687*x.^0.246397; % 0.021
y=86.983073*x.^0.153553; % 0.021

text('FontSize',20,'Rotation',0,'Interpreter','latex',...
    'String','Poisson: $l\sim t^{0.15\pm0.02}$',...
    'Position',[658.145944523346 316.904470816309 0],...
    'Color','r');
loglog(x,y,'LineWidth',2,'LineStyle','-','Color','k');

errorbar(dataLS_Powerlaw12_3072(1,1:span:end),MeanWave_Powerlaw12_3072(1:span:end),SDWave_Powerlaw12_3072(1:span:end), ...
    'Marker','o','MarkerSize',5,'LineStyle','none','LineWidth',2,'Color','m','CapSize',5);
y=50.592117*x.^0.331543; % 0.018
y=87.425727*x.^0.261232; % 0.012
text('FontSize',20,'Rotation',0,'Interpreter','latex',...
    'String','Powerlaw: $l\sim t^{0.26\pm0.01}$',...
    'Position',[649.03847260943 807.673152007475 0],...
    'Color','m');
loglog(x,y,'LineWidth',2,'LineStyle','-','Color','k');

% loglog(timeseries_Delta4_3072(348:430),MeanWave_Delta4_3072(348:430),'D','markersize',6, ...
%     'color','magenta')
% errorbar(timeseries_Delta4_3072(348:430),MeanWave_Delta4_3072(348:430),SDWave_Delta4_3072(348:430),'color','c');

% x=timeseries_Delta4_3072(348:430);
% y=34.861609*x.^0.108285;
% loglog(x,y,'r--','linewidth',2)
% text('FontSize',18,'Rotation',25,'Interpreter','latex',...
%     'String','$l\sim t^{0.108\pm0.002}$',...
%     'Position',[460.885178845936 272.451279939185 0],...
%     'Color',[1 0 0]);

% title(['time: ' num2str(timeseries_Delta4_3072(348),'%.1f') '$\sim$' num2str(timeseries_Delta4_3072(430),'%.1f') ], ...
%     'Interpreter','latex','Color','r')
% xline(timeseries_Delta4_3072(348))
% xline(timeseries_Delta4_3072(430))

set(gca,'xtick',[1000,2000,4000])
set(gca,'xticklabel',[1000,2000,4000])
set(gca,'ytick',[200,400,600,800])
set(gca,'yticklabel',[200,400,600,800])

ylim([140 1000]);
% xlim([6e2 4e3+300])
xlim([270 1e4+300]);

box on

set(gca,'XScale','log','YScale','log');
set(gca,'fontsize',FS,'linewidth',2,'xminortick','on','yminortick','on',...
    'ticklength',[0.025 0.025]);
set(gca,'FontName','Times'); set(gcf,'Color',[1,1,1]);

xlabel('Time, $t$ ','Interpreter','latex');
ylabel('Spatial scale, $\ell$','Interpreter','latex');

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

str = ['./Fig2C.eps'];
print(str,'-depsc')

