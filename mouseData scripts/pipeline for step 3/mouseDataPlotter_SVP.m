%% This script will plot data from WT and Ati feeding sessions
%% separate data from each group; MAKE SURE to check that the Data variables are accessing the right rows! 
%% it changes depending on which comes first alphabetically
WTData = final(1:2:end);
U50Data = final(2:2:end);
AtiData = final(3:2:end);
SalData = final(4:2:end);

for i = 1:size(WTData,2)
    if i == 1
        WTTraces = WTData(i).unitAVG.startTS.caTraces;
      else
        WTTraces = cat(1, WTTraces, WTData(i).unitAVG.startTS.caTraces);
    end
end

for i = 1:size(U50Data,2)
    if i == 1
        U50Traces = U50Data(i).unitAVG.startTS.caTraces;
      else
        U50Traces = cat(1, U50Traces, U50Data(i).unitAVG.startTS.caTraces);
    end
end

for i = 1:size(AtiData,2)
    if i == 1
        AtiTraces = AtiData(i).unitAVG.startTS.caTraces;
      else
        AtiTraces = cat(1, AtiTraces, AtiData(i).unitAVG.startTS.caTraces);
    end
end

for i = 1:size(SalData,2)
    if i == 1
        SalTraces = SalData(i).unitAVG.startTS.caTraces;
      else
        SalTraces = cat(1, SalTraces, SalData(i).unitAVG.startTS.caTraces);
    end
end

% normalize traces
% WTTraces = normalize(WTTraces,2);
% AtiTraces = normalize(AtiTraces,2);

%% use if you dont want to normalize to pre-feeding period
scale = transpose((final(1).uv.evtWin(1)):.1:(final(1).uv.evtWin(2)-.1));
WTMean = nanmean(WTTraces);
WTMean = smooth(WTMean,5);
WTSem = nanstd(WTTraces)/sqrt(size(WTTraces,1));
WTSem = smooth(WTSem,5);

AtiMean = nanmean(AtiTraces);
AtiMean = smooth(AtiMean,5);
AtiSem = nanstd(AtiTraces)/sqrt(size(AtiTraces,1));
AtiSem = smooth(AtiSem,5);
%% plot WT and Ati
figure

fill([scale;flipud(scale)],[WTMean-WTSem;flipud(WTMean+WTSem)],'b','linestyle','-'); % Change values depending on what your cellTraces array is
hold
plot(scale,WTMean, 'k')
%set(gca,'FontSize', 16)
xlabel('Time relative to behav onset (s)', 'FontSize', 22)
ylabel('Z-score fluorescence','FontSize', 22)
set(gcf, 'Position',  [100, 100, 600, 600])

fill([scale;flipud(scale)],[AtiMean-AtiSem;flipud(AtiMean+AtiSem)],'r','linestyle','-'); % Change values depending on what your cellTraces array is
plot(scale,AtiMean, 'k')
%set(gca,'FontSize', 16)
xlabel('Time relative to behav onset (s)', 'FontSize', 22)
ylabel('Z-score fluorescence','FontSize', 22)
set(gcf, 'Position',  [100, 100, 600, 600])
%% norm to pre feed period
for c = 1:size(WTTraces,1)
   trace = WTTraces(c,:);
   avg = nanmean(WTTraces(c,1:100));
   std = nanstd(WTTraces(c,1:100));
   normTrace = (trace - avg) / std;
   normalizedWT(c,:) = normTrace;
end

for c = 1:size(U50Traces,1)
   trace = U50Traces(c,:);
   avg = nanmean(U50Traces(c,1:100));
   std = nanstd(U50Traces(c,1:100));
   normTrace = (trace - avg) / std;
   normalizedU50(c,:) = normTrace;
end

for c = 1:size(AtiTraces,1)
   trace = AtiTraces(c,:);
   avg = nanmean(AtiTraces(c,1:100));
   std = nanstd(AtiTraces(c,1:100));
   normTrace = (trace - avg) / std;
   normalizedAti(c,:) = normTrace;
end

for c = 1:size(SalTraces,1)
   trace = SalTraces(c,:);
   avg = nanmean(SalTraces(c,1:100));
   std = nanstd(SalTraces(c,1:100));
   normTrace = (trace - avg) / std;
   normalizedSal(c,:) = normTrace;
end

%% get mean of normalized traces
scale = transpose((final(1).uv.evtWin(1)):.1:(final(1).uv.evtWin(2)-.1));
WTMean = nanmean(normalizedWT);
WTMean = smooth(WTMean,6);
WTSem = nanstd(normalizedWT)/sqrt(size(normalizedWT,1));
WTSem = smooth(WTSem,6);

AtiMean = nanmean(normalizedAti);
AtiMean = smooth(AtiMean,6);
AtiSem = nanstd(normalizedAti)/sqrt(size(normalizedAti,1));
AtiSem = smooth(AtiSem,6);

SalMean = nanmean(normalizedSal);
SalMean = smooth(SalMean,6);
SalSem = nanstd(normalizedSal)/sqrt(size(normalizedSal,1));
SalSem = smooth(SalSem,6);

U50Mean = nanmean(normalizedU50);
U50Mean = smooth(U50Mean,6);
U50Sem = nanstd(normalizedU50)/sqrt(size(normalizedU50,1));
U50Sem = smooth(U50Sem,6);
%% plot WT and Ati normalized
figure

WTLegend = 'k';
U50Legend = 'r';
AtiLegend = 'c';
SalLegend = [.7 .7 .7];

% a = fill([scale;flipud(scale)],[WTMean-WTSem;flipud(WTMean+WTSem)],'k','linestyle','-'); % Change values depending on what your cellTraces array is
% hold
% plot(scale,WTMean, 'k')
% %set(gca,'FontSize', 16)
% xlabel('Time relative to behav onset (s)', 'FontSize', 22)
% ylabel('Z-score fluorescence','FontSize', 22)
% set(gcf, 'Position',  [100, 100, 600, 600])

% b = fill([scale;flipud(scale)],[U50Mean-U50Sem;flipud(U50Mean+U50Sem)],'r','linestyle','-'); % Change values depending on what your cellTraces array is
% plot(scale,U50Mean, 'k')
% %set(gca,'FontSize', 16)
% xlabel('Time relative to behav onset (s)', 'FontSize', 22)
% ylabel('Z-score fluorescence','FontSize', 22)
% set(gcf, 'Position',  [100, 100, 600, 600])

c = fill([scale;flipud(scale)],[AtiMean-AtiSem;flipud(AtiMean+AtiSem)],'c','linestyle','-'); % Change values depending on what your cellTraces array is
plot(scale,AtiMean, 'k')
%set(gca,'FontSize', 16)
xlabel('Time relative to behav onset (s)', 'FontSize', 22)
ylabel('Z-score fluorescence','FontSize', 22)
set(gcf, 'Position',  [100, 100, 600, 600])

grayColor = [.7 .7 .7];
% 
% d = fill([scale;flipud(scale)],[SalMean-SalSem;flipud(SalMean+SalSem)],grayColor,'linestyle','-'); % Change values depending on what your cellTraces array is
% plot(scale,SalMean, 'k')
% %set(gca,'FontSize', 16)
% xlabel('Time relative to behav onset (s)', 'FontSize', 22)
% ylabel('Z-score fluorescence','FontSize', 22)
% set(gcf, 'Position',  [100, 100, 600, 600])

% change title depending on what you are plotting
title(['Z-score fluorescence vs. time relative to behavior onset for Ati no swim treatments on KG1'], 'FontSize', 20)
%legend([c], {'Ati'});

sortNum = mean(normalizedSal(:,90:200)');
sortCellTraces = cat(2,sortNum',normalizedSal);
temp = sortrows(sortCellTraces);
sortCellTraces = temp(:,2:end);

%% plot heatplots and line graph for each condition
figure
% subplot(121)
% sortNum = mean(normalizedWT(:,90:200)');
% sortCellTraces = cat(2,sortNum',normalizedWT);
% temp = sortrows(sortCellTraces);
% sortCellTraces = temp(:,2:end);
% clims = ([-5 5]);
% imagesc(sortCellTraces,clims)
% xline((-uv.evtWin(1,1)*10),'--')
% xticklabels = (uv.evtWin(1,1)):20:(uv.evtWin(1,2));
% xticks = linspace(1, length(normalizedWT), numel(xticklabels));
% set(gca, 'XTick', xticks, 'XTickLabel', xticklabels)
% set(gca,'FontName','Arial','FontSize',16)
% xlabel('Time from consumption entry (s)','FontSize',22)
% ylabel('Cell number','FontSize',22)
% title('WT');
% colormap('Summer')
% colorbar;

subplot(121)
% sortNum = mean(normalizedAti(:,90:200)');
% sortCellTraces = cat(2,sortNum',normalizedAti);
% temp = sortrows(sortCellTraces);
% sortCellTraces = temp(:,2:end);
clims = ([-5 5]);
imagesc(sortCellTraces,clims)
xline((-uv.evtWin(1,1)*10),'--')
xticklabels = (uv.evtWin(1,1)):20:(uv.evtWin(1,2));
xticks = linspace(1, length(normalizedAti), numel(xticklabels));
set(gca, 'XTick', xticks, 'XTickLabel', xticklabels)
set(gca,'FontName','Arial','FontSize',16)
xlabel('Time from consumption entry (s)','FontSize',22)
ylabel('Cell number','FontSize',22)
title('Atica')
colormap('Summer')
colorbar;
% 
% subplot(425)
% sortNum = mean(normalizedSal(:,90:200)');
% sortCellTraces = cat(2,sortNum',normalizedSal);
% temp = sortrows(sortCellTraces);
% sortCellTraces = temp(:,2:end);
% clims = ([-5 5]);
% imagesc(sortCellTraces,clims)
% xline((-uv.evtWin(1,1)*10),'--')
% xticklabels = (uv.evtWin(1,1)):20:(uv.evtWin(1,2));
% xticks = linspace(1, length(normalizedSal), numel(xticklabels));
% set(gca, 'XTick', xticks, 'XTickLabel', xticklabels)
% set(gca,'FontName','Arial','FontSize',16)
% xlabel('Time from consumption entry (s)','FontSize',22)
% ylabel('Cell number','FontSize',22)
% title('Saline')
% colormap('Summer')
% colorbar;

% subplot(223)
% sortNum = mean(normalizedU50(:,90:200)');
% sortCellTraces = cat(2,sortNum',normalizedU50);
% temp = sortrows(sortCellTraces);
% sortCellTraces = temp(:,2:end);
% clims = ([-5 5]);
% imagesc(sortCellTraces,clims)
% xline((-uv.evtWin(1,1)*10),'--')
% xticklabels = (uv.evtWin(1,1)):20:(uv.evtWin(1,2));
% xticks = linspace(1, length(normalizedU50), numel(xticklabels));
% set(gca, 'XTick', xticks, 'XTickLabel', xticklabels)
% set(gca,'FontName','Arial','FontSize',16)
% xlabel('Time from consumption entry (s)','FontSize',22)
% ylabel('Cell number','FontSize',22)
% title('U50')
% colormap('Summer')
% colorbar;

%subplot(2,2,[2 4])
subplot(3,3,[3,6])
%  fill([scale;flipud(scale)],[WTMean-WTSem;flipud(WTMean+WTSem)],'k','linestyle','-'); % Change values depending on what your cellTraces array is
% hold
% plot(scale,WTMean, 'k')
% set(gca,'FontSize', 16)
% xlabel('Time relative to start of trial', 'FontSize', 22)
% ylabel('Z-score fluorescence','FontSize', 22)
% set(gcf, 'Position',  [100, 100, 600, 600])
% set(gca,'FontName','Arial')

fill([scale;flipud(scale)],[AtiMean-AtiSem;flipud(AtiMean+AtiSem)],'c','linestyle','-'); % Change values depending on what your cellTraces array is
plot(scale,AtiMean, 'k')
set(gca,'FontSize', 16)
xlabel('Time relative to consumption onset (s)', 'FontSize', 22)
ylabel('Z-score fluorescence','FontSize', 22)
set(gcf, 'Position',  [100, 100, 600, 600])
xline(0,'--')
set(gca,'FontName','Arial')

% fill([scale;flipud(scale)],[SalMean-SalSem;flipud(SalMean+SalSem)],grayColor,'linestyle','-'); % Change values depending on what your cellTraces array is
% plot(scale,SalMean, 'k')
% set(gca,'FontSize', 16)
% xlabel('Time relative to consumption onset (s)', 'FontSize', 22)
% ylabel('Z-score fluorescence','FontSize', 22)
% set(gcf, 'Position',  [100, 100, 600, 600])
% xline(0,'--')
% set(gca,'FontName','Arial')

% fill([scale;flipud(scale)],[U50Mean-U50Sem;flipud(U50Mean+U50Sem)],'r','linestyle','-'); % Change values depending on what your cellTraces array is
% plot(scale,U50Mean, 'k')
% set(gca,'FontSize', 16)
% xlabel('Time relative to consumption onset (s)', 'FontSize', 22)
% ylabel('Z-score fluorescence','FontSize', 22)
% set(gcf, 'Position',  [100, 100, 600, 600])
% xline(0,'--')
% set(gca,'FontName','Arial')
box off
    