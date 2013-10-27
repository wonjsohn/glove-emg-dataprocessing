% gloveEMG data processing
% this program load / extracts finger information / save mat file &
% x_marker in currentFolder 
% Eric W. Sohn
% wonjsohn@gmail.com

clc; clear
%% read data
currentFolder = 'F:\Dropbox\MATLAB\gloveEMG';
dir(fullfile(currentFolder, '\Maria\20131022\emg_data'))

% textread('output_20131022_155442_index_tapping.txt','headerlines', 3); 

fname = 'both_tapping.txt';
fid = fopen(fname);
% sample = fgetl(fid)
% foo = textscan(fid,'Size %f%f%f%*s','CollectOutput',true);
% sizeinfo = foo{1}

% time = '';
tline ='a'; %initial value

Block = 1;
% while (~feof(fid)) % Quit if end of file
%  tline = fgetl(fid)  % read line

% remove first six lines 
for i=1:6
    tline = fgetl(fid);  % read line
end
    

emg_pre = textscan (fid, '%d %d %d %d','delimiter','\t','CollectOutput', true);

EMG = emg_pre{1};
%     HeaderLines(Block,1)=emg{1};
%     HeaderLines(Block,2)=index{1}(1); % record  only mcp joint
%     HeaderLines(Block,3)=middle{1}(1); % record  only mcp joint
%     Block = Block + 1;
% end

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
