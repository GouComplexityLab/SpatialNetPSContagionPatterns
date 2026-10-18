
clc; clear all;

starting_time = datetime;
tic 

data_path1 = ['./Step1 logtime Cupy Powerlaw12 Data p=0.300'];

load('./data_logtime.mat')
Time = nplot_time;
StartT=1;
datSk1=[]; 
datSk2=[];  
ij=1;
%% 
for nfile=1:5
    data_path2 = ['/ICn=' num2str(nfile) ];

    ij=1;
    % StartT=40; % 50 for DDA; 20 for SDF
    StartT0=StartT;
    for kk=StartT:1:length(Time) %size(treename,1); 
        [nfile kk]
        mat_name = ['/SpatialConfigurationPattern T=' num2str(Time(kk),'%.4f') '.mat'];
        load([data_path1 data_path2 mat_name])
        PT1 = reshape(S0,3072,3072);

        % PT1=datDDA(:,:,kk);
        PT2=mat2gray(PT1);

        k =(1:1:floor(min(size(PT2))/3))';
        [SK] = Circularly_averaged_Sk_raster(PT2,k);
        qmax=sum(SK(:,1).*SK(:,2))./sum(SK(:,2));
        datSk1(ij,1)=Time(kk);
        datSk1(ij,2)=qmax;
        datSk2(ij,1)=Time(kk);
        datSk2(ij,nfile+1)=qmax;

        ij=ij+1;
    end
end

save('./data_calc_Sim_sk_Powerlaw12_3072p=0.300.mat', 'datSk2')

toc
ending_time = datetime;
disp(starting_time)
disp(ending_time) 
disp(toc)


 