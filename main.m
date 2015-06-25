%	the main.m calls the internface RUN_TRACKER to perform tracking on% 
%	the videos provided in the tacker.txt
%	Jianyi Yi, 2015

%%	open tracker.txt and load its content
parent = 'D:\ROSE\videos\videoRetrieval\videoRetrieval';
tracker = strcat(parent, '/rvp_init_boxes/', 'tracker1.txt');
f = fopen(tracker);
assert(f ~= -1, ['No videos to load ("' tracker '").'])
try
	videos = textscan(f, '%s', 'ReturnOnError',false);  
catch  %#ok, try different format (no commas)
	frewind(f);
	videos = textscan(f, '%s');  
end
videos = cat(2, videos{:});
fclose(f);
%display(videos);

%%	split tacker.txt contents to base_path and videoName and frame number
%	e.g. 'D:\ROSE\videos\videoRetrieval\videoRetrieval\others\100plus6/76.jpg' to
%	'D:\ROSE\videos\videoRetrieval\videoRetrieval\others', '100plus6' and '76'
num = size(videos);
video_list = cell(num, 3);
expr1 = '\\';
expr2 = '\\[\w\.]+/';
expr3 = '\d+.jpg';
for i=1:num
	str = videos{i};
	startIndex = regexp(str, expr1);
	temp = str(1: startIndex-1);
	video_list{i, 1} = [parent '\videos\' temp];
	[startIndex, endIndex] = regexp(str, expr2);
	video_list{i, 2} = str(startIndex+1: endIndex-1);
	[startIndex, endIndex] = regexp(str, expr3);
	video_list{i, 3} = str(startIndex: endIndex-4);
	start_pos = str2num(video_list{i, 3});
	%video_list{i,1}
	disp(videos{i});
	run_tracker(start_pos, video_list{i,1},video_list{i,2});
end

