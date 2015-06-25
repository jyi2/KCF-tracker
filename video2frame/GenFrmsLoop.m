frms_dir = 'others/';
videos_dir = 'others/';

dirData = dir(videos_dir);      %# Get the data for the current video directory
dirIndex = [dirData.isdir];  %# Find the index for directories
dirList = {dirData(~dirIndex).name}';  %'# Get a list of the files in current vchunk

for i = 1:size(dirList, 1)
    vname = dirList{i};
    loc = strfind(vname, '.mp4');
    if isempty(loc)
        continue;
    end
    Video2Frames([videos_dir vname], [frms_dir vname(1:loc-1)]);
end