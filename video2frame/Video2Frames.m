function [] = Video2Frames(vd, framedir, name_temp)

video = VideoReader(vd);

[vdpath, ~, ~] = fileparts(vd);

if ~exist('framedir', 'var')
    framedir = 'frames'
end

if ~strcmp(framedir(numel(framedir)), '/')
    framedir = [ framedir '/' ]
end

if ~exist('name_temp', 'var')
    name_temp = '%d.jpg';
end

% framedir = [ vdpath '/' framedir ]

if ~exist(framedir, 'dir')
    mkdir(framedir);
end
framelist = fopen([framedir '/framelist.txt'], 'wt');

fprintf('Width: %d\nHeight: %d\nFrame: %d\n', video.Width, video.Height, video.NumberOfFrame);
fprintf(framelist, '%d %d %d', video.Width, video.Height, video.NumberOfFrame);

for k = 1 : (video.NumberOfFrame-1)
    fprintf('\n%d/%d', k, video.NumberOfFrame);
    frame = read(video, k);
    % resize to 800x450
    frame = imresize(frame, [450, 800]);
    fname = sprintf(name_temp, k);
%     if mod(k, 10) == 0
        imwrite(frame, [ framedir '/' fname ]);
%     end
    fprintf(framelist, [ '\n' fname ]);
end

fclose(framelist);

end

