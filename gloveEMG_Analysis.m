%% glove / EMG data nalysis 

% Eric W. Sohn
% wonjsohn@gmail.com

clc; clear
%% read data

currentFolder = 'F:\Dropbox\MATLAB\gloveEMG';
dir(fullfile(currentFolder));
cd(currentFolder)
% fname = 'output_20131022_155442_index_tapping.mat';
fname = uigetfile('*.mat','Select the MATLAB code file');
load(fname);

%% variables
time=HeaderLines(:,1);
indexData=HeaderLines(:,2);
middleData=HeaderLines(:,3);

% get index of start / end of each graph for stat analysis
ind_start = find(time >= x_marker(1), 1, 'first');  % return first 1 index 
ind_end = find(time >= x_marker(2), 1, 'first');  % return first 1 index 

mid_start = find(time >= x_marker(3), 1, 'first');  % return first 1 index 
mid_end = find(time >= x_marker(4), 1, 'first');  % return first 1 index 

% find peaks
[pks_index,locs_index] = findpeaks(indexData);
[pks_middle,locs_middle] = findpeaks(middleData);
[neg_pks_index,neg_locs_index] = findpeaks(-1*indexData);
[neg_pks_middle,neg_locs_middle] = findpeaks(-1*middleData);
neg_pks_index = -1* neg_pks_index;
neg_pks_middle = -1*neg_pks_middle;

% remove peaks outside of range between x_markers
[new_locs_index, new_pks_index] = peaksInTheRegion(locs_index, pks_index, ind_end);
[new_locs_middle, new_pks_middle] = peaksInTheRegion(locs_middle, pks_middle, mid_end);
[new_neg_locs_index, new_neg_pks_index] = peaksInTheRegion(neg_locs_index, neg_pks_index, ind_end);
[new_neg_locs_middle, new_neg_pks_middle] = peaksInTheRegion(neg_locs_middle, neg_pks_middle, mid_end);


%% statistical values 
% mean values
index_mean= mean(indexData(ind_start:ind_end))
middle_mean= mean(middleData(mid_start:mid_end))

% making a peak-to-peak value array 
% same index to same index
line = 1;
for i=1:length(new_locs_index)
    p2p_index_array(line) = abs(new_pks_index(i) - new_neg_pks_index(i));
    line = line + 1;
    if i ~= length(new_locs_index) 
        p2p_index_array(line) = abs(new_pks_index(i) - new_neg_pks_index(i+1));
        line = line + 1; 
    else
        break
    end
end

line = 1;
for i=1:length(new_locs_middle)
    p2p_middle_array(line) = abs(new_pks_middle(i) - new_neg_pks_middle(i));
    line = line + 1;
    if i ~= length(new_locs_middle) 
        p2p_middle_array(line) = abs(new_pks_middle(i) - new_neg_pks_middle(i+1));
        line = line + 1; 
    else
        break
    end
end


mean(p2p_index_array)
mean(p2p_middle_array)



%% plotting


subplot(2,1,1)
plot(time, indexData, time(new_locs_index), new_pks_index, 'rv',  time(new_neg_locs_index), new_neg_pks_index, 'rv'); grid on
legend('index finger');
hold on
x=[x_marker(1),x_marker(1)];
y=[-2, 0];
plot(x,y, 'r', 'LineWidth',2.0);
hold on
x=[x_marker(2),x_marker(2)];
y=[-2, 0];
plot(x,y, 'r', 'LineWidth',2.0);
set(gca,'ylim',[-2 0.5]);

subplot(2,1,2)
plot(time, middleData, time(new_locs_middle), new_pks_middle, 'rv',  time(new_neg_locs_middle), new_neg_pks_middle, 'rv'); grid on
legend('middle finger');
hold on
x=[x_marker(3),x_marker(3)];
y=[-2, 0];
plot(x,y, 'r', 'LineWidth',2.0)
hold on
x=[x_marker(4),x_marker(4)];
y=[-2, 0];
plot(x,y, 'r', 'LineWidth',2.0)
set(gca,'ylim',[-2 0.5]);
title( sprintf( 'mean index AMP: %f, VAR: %f, middle AMP: %f, var: %f', mean(p2p_index_array), var(p2p_index_array), mean(p2p_middle_array), var(p2p_middle_array) ));
