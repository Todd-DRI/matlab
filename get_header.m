function [header_idx] = get_header(filename,str2find)
%get_header RETURNS the corresponding line index of 'str2find'

%% test section
% site = '10336610'
% filename = sprintf('SSC_%s.txt', site)
% str2find = 'agency_'

%%
fid = fopen(filename);
tmp = textscan(fid, '%s', 'delimiter', '\n', 'whitespace', ''); %read entire file and find where header lines begin
tmp = tmp{1};
fclose(fid);

header_idx = find(strncmp(tmp, str2find,length(str2find))); 
%headers 

%% find line format - NEVER FINISHED FOR NWIS
% text_format = string(tmp{header_idx+1,:})
% t = insertAfter(text_format, "  ", ",")
% 
% t = strrep(text_format, 's','%s')
% 
% read_format = strsplit(text_format, '\t' )
% for i = 1:length(read_format)
%     in = read_format(1,i)
%     in = [%% in]
%     t2 = strrep(read_format(i),
% end
% %% find header and column positions
% col_names = (tmp{header_idx,:})
% col_names = strsplit(col_names, '\t')


end

