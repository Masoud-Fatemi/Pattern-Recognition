function [data_train] = read_images(path)
	
    folder = list_files(path);
    data_train=[];
    for i=1:length(folder)
        subject = folder{i};
		sub_subject = list_files([path, filesep, subject]);
        
        for j=1 : length(sub_subject)
		   goal = sub_subject{j};
		   images = list_files([path, filesep, subject,filesep, goal]);
		
		    for z=1 : length(images)
      	    filename =[path, filesep, subject, filesep, goal, filesep, images{z}]; 
            T = double(imread(filename));
            T=imresize(T,[32,32]);
            T=T/255;
            [L,M]=size(T);
            data_train = [data_train, reshape(T,L*M,1)];
            end
            
      		    		

        end
            
	end
		
end