%  called by RUN_TRACKER to record the tracking box's position to text file
%  format: [topleft_x, topleft_y, bottomright_x, bottomright_y]

%  parameters:
%  	POSITIONS is an Nx2 matrix of target positions (the centroid) over time (in the format [rows, columns])
%  	TARGET_SZ is the size of the tracking box (format [height, width])
%  	VIDEO is the name of the text file
%
%  Jianyi Yi, 2015

function records = position_records(positions, target_sz, video)
	num = size(positions, 1);
	height = target_sz(1);
	width = target_sz(2);
	path = 'D:\ROSE\videos\videoRetrieval\videoRetrieval/tracking';
	filePath = strcat(path, '/', video, '.txt');
	records = zeros(num, 4);
	for i=1:num
		records(i,2) = positions(i,2) - floor(width/2);
		records(i,1) = positions(i,1) - floor(height/2);
		records(i,4) = records(i,2) + width;
		records(i,3) = records(i,1) + height;
		if records(i,1)<0
			records(i,1)=0;
		elseif records(i,1)>449
			records(i,1)>449;
		end

		if records(i,2)<0
			records(i,2)=0;
		elseif records(i,2)>799
			records(i,2)=799;
		end

		if records(i,3)<0
			records(i,3)=0;
		elseif records(i,3)>449
			records(i,3)>449;
		end

		if records(i,4)<0
			records(i,4)=0;
		elseif records(i,4)>799
			records(i,4)=799;
		end
	end
	dlmwrite(filePath,records,'delimiter','\t','precision',3);