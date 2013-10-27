function [new_locs_index, new_pks_index] = peaksInTheRegion(old_locs_index, old_pks_index, last_xmarker) 
    % remove peaks outside of range between x_markers
    pks_index_ind = find(old_locs_index <= last_xmarker, 1, 'last');  % return last index before..
    new_locs_index = old_locs_index(1:pks_index_ind);  % cut whatever peaks after the marker
    new_pks_index = old_pks_index(1: pks_index_ind);
end


