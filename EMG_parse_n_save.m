% gloveEMG data processing
% this program load / extracts finger information / save mat file &
% x_marker in currentFolder 
% Eric W. Sohn
% wonjsohn@gmail.com

clc; clear
%% read data
currentFolder = 'F:\Dropbox\MATLAB\gloveEMG';
dir(fullfile(currentFolder, '\Maria\20131022\emg_data'))

fname = 'both_tapping.txt';
fid = fopen(fname);


% time = '';
tline ='a'; %initial value

Block = 1;

% remove first six lines 
for i=1:6
    tline = fgetl(fid);  % read line
end
    

emg_pre = textscan (fid, '%d %d %d %d','delimiter','\t','CollectOutput', true);


fclose(fid);
%% parse data

subplot(2,1,1)
plot(EMG(:,1));

subplot(2,1,2)
plot(EMG(:,2));
% 

%% save as mat file 
% 
[pathstr,oldBaseName,ext] = fileparts(fname) 
newName = sprintf('EMG_%s.mat',oldBaseName);
newFullFuleName = fullfile(currentFolder, newName);
save(newFullFuleName,'-mat', 'EMG');
