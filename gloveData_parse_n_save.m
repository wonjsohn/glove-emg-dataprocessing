% gloveEMG data processing
% this program load / extracts finger information / save mat file &
% x_marker in currentFolder 
% Eric W. Sohn
% wonjsohn@gmail.com

clc; clear
%% read data
currentFolder = 'F:\Dropbox\MATLAB\gloveEMG';
dir(fullfile(currentFolder, '\Maria\20131022\glove_data'))

% textread('output_20131022_155442_index_tapping.txt','headerlines', 3); 

fname = 'output_20131022_161238_both_to_palm.txt';
fid = fopen(fname);
% sample = fgetl(fid)
% foo = textscan(fid,'Size %f%f%f%*s','CollectOutput',true);
% sizeinfo = foo{1}

% time = '';
tline ='a'; %initial value

Block = 1;
while (~feof(fid)) % Quit if end of file
%  tline = fgetl(fid)  % read line
    time = textscan (fid, 'deltaT: %f',1, ...
        'delimiter','\n','CollectOutput', true);
    garbage_index = textscan (fid, '%s',1, ...
        'delimiter','\n','CollectOutput', true);
    thumb= textscan (fid, '0 %f %f %f',1, ...
        'delimiter','\n','CollectOutput', true);
    index = textscan (fid, '1 %f %f %f',1, ...
        'delimiter','\n','CollectOutput', true);
    middle = textscan (fid, '2 %f %f %f',1, ...
        'delimiter','\n','CollectOutput', true);
    ring = textscan (fid, '3 %f %f %f',1, ...
        'delimiter','\n','CollectOutput', true);
    pinky = textscan (fid, '4 %f %f %f',1, ...
        'delimiter','\n','CollectOutput', true);
    garbage_index = textscan (fid, '%s',3, ...
        'delimiter','\n','CollectOutput', true);

    HeaderLines(Block,1)=time{1};
    HeaderLines(Block,2)=index{1}(1); % record  only mcp joint
    HeaderLines(Block,3)=middle{1}(1); % record  only mcp joint
    Block = Block + 1;
end

fclose(fid);
%% parse data

subplot(2,1,1)
plot(HeaderLines(:,1), HeaderLines(:,2));

subplot(2,1,2)
plot(HeaderLines(:,1), HeaderLines(:,2));

x_marker=ginput(4); %% get start and ending x markers for analysis. 

%% save as mat file 

[pathstr,oldBaseName,ext] = fileparts(fname) 
newName = sprintf('%s.mat',oldBaseName);
newFullFuleName = fullfile(currentFolder, newName);
save(newFullFuleName,'-mat', 'HeaderLines','x_marker');
