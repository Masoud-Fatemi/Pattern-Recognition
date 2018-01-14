function L = list_files(path)
	%% List all files in a folder and return it as a cell array.


	L = dir(path);
	L = L(3:length(L));
	L = struct2cell(L);
	L = L(1,:);
end