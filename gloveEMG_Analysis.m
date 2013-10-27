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

prompt = 'Do you like to use previously tailored peak arrays?  1: yes, 0: no  ?';
dontsave = input(prompt)
if (dontsave)    
    peak_array_fname = uigetfile('*.mat','Select the MATLAB code file');
    load(peak_array_fname);
else
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
       
    % mean values
    index_mean= mean(indexData(ind_start:ind_end))
    middle_mean= mean(middleData(mid_start:mid_end))

end



%% plotting

loopOn = 1;

while (loopOn)

    %% statistical values 
    % making a peak-to-peak value array 
    % same index to same index
    line = 1;
    for i=1:length(new_pks_index)
        p2p_index_array(line) = abs(new_pks_index(i) - new_neg_pks_index(i));
        line = line + 1;
        if i ~= length(new_pks_index) 
            p2p_index_array(line) = abs(new_pks_index(i) - new_neg_pks_index(i+1));
            line = line + 1; 
        else
            break
        end
    end

    line = 1;
    for i=1:length(new_pks_middle)
        p2p_middle_array(line) = abs(new_pks_middle(i) - new_neg_pks_middle(i));
        line = line + 1;
        if i ~= length(new_pks_middle) 
            p2p_middle_array(line) = abs(new_pks_middle(i) - new_neg_pks_middle(i+1));
            line = line + 1; 
        else
            break
        end
    end


    mean(p2p_index_array)
    mean(p2p_middle_array)
    
    clf;
    plotting( p2p_index_array, p2p_middle_array, time,indexData, new_locs_index, new_pks_index, new_neg_locs_index, new_neg_pks_index, x_marker, middleData,new_locs_middle, new_pks_middle, new_neg_locs_middle, new_neg_pks_middle )
    
    if (dontsave) % prevent accidently saving to a tailored peak array. 
        break;
    end
    prompt = 'Are you satisfied with the peaks?  1 = yes .../ 2 = change index  / 3 = change middle:  ';
    result = input(prompt)
    switch result
        case 1
            [pathstr,oldBaseName,ext] = fileparts(fname) 
            newName = sprintf('%s_p2p_array.mat',oldBaseName);
            newFullFuleName = fullfile(currentFolder, newName);
            save(newFullFuleName,'-mat', 'new_pks_index', 'new_locs_index', 'new_neg_pks_index', 'new_neg_locs_index', 'new_pks_middle', 'new_locs_middle', 'new_neg_pks_middle', 'new_neg_locs_middle',    'p2p_index_array','p2p_middle_array'); 
            loopOn = 0;
        case 2
            transpose(new_pks_index)
            prompt = 'pks_index: choose a index of wrong peak to remove, 99 if pass : ';
            ind_to_remove = input(prompt)
            if ind_to_remove ~= 99
                new_pks_index(ind_to_remove) = []; 
                new_locs_index(ind_to_remove) = []; 
            else 
                transpose(new_neg_pks_index)
                prompt = 'neg_pks_index: choose a index of wrong peak to remove, 99 if pass : ';
                ind_to_remove = input(prompt)
                if ind_to_remove ~= 99
                     new_neg_pks_index(ind_to_remove) = []; 
                     new_neg_locs_index(ind_to_remove) = []; 
                    
                end
            end
        case 3
           transpose(new_pks_middle)
            prompt = 'pks_middle: choose a index of wrong peak to remove, 99 if pass : ';
            ind_to_remove = input(prompt)
            if ind_to_remove ~= 99
                new_pks_middle(ind_to_remove) = []; 
                new_locs_middle(ind_to_remove) = []; 
            else 
                transpose(new_neg_pks_middle)
                prompt = 'neg_pks_middle: choose a index of wrong peak to remove, 99 if pass : ';
                ind_to_remove = input(prompt)
                if ind_to_remove ~= 99
                     new_neg_pks_middle(ind_to_remove) = []; 
                     new_neg_locs_middle(ind_to_remove) = []; 
                    
                end
            end
        otherwise
            disp('Wrong choice');
            
    end
    
end


