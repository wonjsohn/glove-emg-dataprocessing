%% glove / EMG data read and plot

% Eric W. Sohn
% wonjsohn@gmail.com

clc; clear
%% read data

currentFolder = 'F:\Dropbox\MATLAB\gloveEMG';
dir(fullfile(currentFolder));
cd(currentFolder)
% fname = 'output_20131022_155442_index_tapping.mat';
% fname = uigetfile('*.mat','Select the MATLAB code file');
% load(fname);

%% load all EMG * mat files in the current directory
files = dir('EMG*.mat');
for i=1:length(files)
    eval(['load ' files(i).name]);
    [pathstr,oldBaseName,ext] = fileparts(files(i).name) 
    newName = sprintf('%s_var',oldBaseName);
    eval([sprintf(newName) '=EMG;']);
end

files = dir('output*.mat');
for i=1:length(files)
    eval(['load ' files(i).name]);
    [pathstr,oldBaseName,ext] = fileparts(files(i).name) 
    newName = sprintf('%s_var',oldBaseName);
    eval([sprintf(newName) '=HeaderLines;']);
end

% files = dir('*p2p_array.mat');
% for i=1:length(files)
%     eval(['load ' files(i).name]);
%     [pathstr,oldBaseName,ext] = fileparts(files(i).name) 
%     newName = sprintf('%s_p2p_array',oldBaseName);
%     eval([sprintf(newName) '(:,1)=p2p_index_array;']);
%     eval([sprintf(newName) '(:,2)=p2p_middle_array;']);
% 
% end

n=6
ymax = 1000;
EMGDATA = EMG_both_to_palm_var;
subplot(n,1,1);
plot(EMGDATA(:,2));
legend('index flexor');
set(gca,'ylim',[-ymax ymax]);
subplot(n,1,2);
plot(EMGDATA(:,1));
legend('middle flexor');
set(gca,'ylim',[-ymax ymax]);
subplot(n,1,3);
plot(EMGDATA(:,3));
legend('index extensor');
set(gca,'ylim',[-ymax ymax]);
subplot(n,1,4);
plot(EMGDATA(:,4));
legend('middle extensor');
set(gca,'ylim',[-ymax ymax]);

subplot(n,1,5);
gloveData = output_20131022_161238_both_to_palm_var;
x = gloveData(:,1);
y1= gloveData(:,2);
y2= gloveData(:,3)
plot(x,y1);grid on
legend('index movement');
set(gca,'ylim',[-2.0 0.2]);
subplot(n,1,6);
plot(x,y2 );grid on
legend('middle movement');
set(gca,'ylim',[-2.0 0.2]);
title('EMG both to palm');
% subplot(4,2,5)
% plot(EMG_middle_to_palm_var(:,1));
% subplot(4,2,6)
% plot(EMG_middle_to_palm_var(:,2));
% subplot(4,2,7)
% plot(EMG_middle_to_palm_var(:,3));
% subplot(4,2,8)
% plot(EMG_middle_to_palm_var(:,4));
% 
