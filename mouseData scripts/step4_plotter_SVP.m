%% This script will plot data from WT and Ati feeding sessions
%% separate data from each group; MAKE SURE to check that the Data variables are accessing the right rows! 
%% it changes depending on which comes first alphabetically
KG1Data = final(1:2:end);
KG2Data = final(2:2:end);
KG3Data = final(3:2:end);

for i = 1:size(KG1Data,2)
    if i == 1
        KG1Traces = KG1Data(i).unitAVG.startTS.caTraces;
      else
        KG1Traces = cat(1, KG1Traces, KG1Data(i).unitAVG.startTS.caTraces);
    end
end

for i = 1:size(KG2Data,2)
    if i == 1
        KG2Traces = KG2Data(i).unitAVG.startTS.caTraces;
      else
        KG2Traces = cat(1, KG2Traces, KG2Data(i).unitAVG.startTS.caTraces);
    end
end

for i = 1:size(KG3Data,2)
    if i == 1
        KG3Traces = KG3Data(i).unitAVG.startTS.caTraces;
      else
        KG3Traces = cat(1, KG3Traces, KG3Data(i).unitAVG.startTS.caTraces);
    end
end

% normalize traces
% KG1Traces = normalize(KG1Traces,2);
% KG2Traces = normalize(KG2Traces,2);
% KG3Traces = normalize(KG3Traces,2);

%% use if you dont want to normalize to pre-feeding period
% scale = transpose((final(1).uv.evtWin(1)):.1:(final(1).uv.evtWin(2)-.1));
% 
% KG1Traces = nanmean(KG1Traces);
% KG1Traces = smooth(KG1Traces,5);
% KG1Sem = nanstd(KG1Traces)/sqrt(size(KG1Traces,1));
% KG1Sem = smooth(KG1Sem,5);
% 
% KG2Traces = nanmean(KG2Traces);
% KG2Traces = smooth(KG2Traces,5);
% KG2Sem = nanstd(KG2Traces)/sqrt(size(KG2Traces,1));
% KG2Sem = smooth(KG2Sem,5);
% 
% KG3Traces = nanmean(KG3Traces);
% KG3Traces = smooth(KG3Traces,5);
% KG3Sem = nanstd(KG3Traces)/sqrt(size(KG3Traces,1));
% KG3Sem = smooth(KG3Sem,5);

%% norm to pre feed period
for c = 1:size(KG1Traces,1)
   trace = KG1Traces(c,:);
   avg = nanmean(KG1Traces(c,1:100));
   std = nanstd(KG1Traces(c,1:100));
   normTrace = (trace - avg) / std;
   normalizedKG1(c,:) = normTrace;
end

for c = 1:size(KG2Traces,1)
   trace = KG2Traces(c,:);
   avg = nanmean(KG2Traces(c,1:100));
   std = nanstd(KG2Traces(c,1:100));
   normTrace = (trace - avg) / std;
   normalizedKG2(c,:) = normTrace;
end

for c = 1:size(KG3Traces,1)
   trace = KG3Traces(c,:);
   avg = nanmean(KG3Traces(c,1:100));
   std = nanstd(KG3Traces(c,1:100));
   normTrace = (trace - avg) / std;
   normalizedKG3(c,:) = normTrace;
end

%% get mean of normalized traces
scale = transpose((final(1).uv.evtWin(1)):.1:(final(1).uv.evtWin(2)-.1));
KG1Traces = nanmean(normalizedKG1);
KG1Traces = smooth(KG1Traces,6);
KG1Sem = nanstd(normalizedKG1)/sqrt(size(normalizedKG1,1));
KG1Sem = smooth(KG1Sem,6);

KG2Traces = nanmean(normalizedKG2);
KG2Traces = smooth(KG2Traces,6);
KG2Sem = nanstd(normalizedKG2)/sqrt(size(normalizedKG2,1));
KG2Sem = smooth(KG2Sem,6);

KG3Traces = nanmean(normalizedKG3);
KG3Traces = smooth(KG3Traces,6);
KG3Sem = nanstd(normalizedKG3)/sqrt(size(normalizedKG3,1));
KG3Sem = smooth(KG3Sem,6);

cellPool = [normalizedKG1; normalizedKG2; normalizedKG3]
sortNum = mean(cellPool(:,90:200)');
sortCellTraces = cat(2,sortNum',cellPool);
temp = sortrows(sortCellTraces, 'descend');
sortCellTraces = temp(:,2:end);

%% plot heatplots and line graph for each condition
figure
clims = ([-5 5]);
imagesc(sortCellTraces,clims)
xline((-uv.evtWin(1,1)*10),'--')
xticklabels = (uv.evtWin(1,1)):20:(uv.evtWin(1,2));
xticks = linspace(1, length(cellPool), numel(xticklabels));
set(gca, 'XTick', xticks, 'XTickLabel', xticklabels)
set(gca,'FontName','Arial','FontSize',16)
xlabel('Time','FontSize',22)
ylabel('Cell index','FontSize',22)
title('Cell Index vs. time')
colormap('Summer')
colorbar;

box off
    