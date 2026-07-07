% my_colors  returns color vector (size n) for my preferred color schemes and symbolse
%   Updated 12/8/2021 to color paletted from file exchance .mat - added as
%   vectors here. 
%   https://www.mathworks.com/matlabcentral/fileexchange/46802-color-blind-friendly-colormap
%
%   BACKGROUND
%     This script is based on http://blogs.nature.com/nautilus/2007/02/post_4.html public domain and may be distributed freely.
%     This blog details color patterns suitable for 3 major types of color
%     blindness. The actual percentages of RGB are from http://chronicle.com/
%     blogs/profhacker/color-blind-accessible-figures/59189?cid=at&utm_source=at&utm_medium=en

%%
function [out] = my_colors(n)
myColors(1,:) = rgb('Black');
myColors(2,:) = rgb('Blue');
myColors(3,:) = rgb('Orange');
myColors(4,:) = rgb('Darkgray');
myColors(5,:) = rgb('Yellow');
myColors(6,:) = rgb('Red');
myColors(7,:) = rgb('Magenta');
myColors(8,:) = rgb('Teal');
myColors(9,:) = rgb('darkblue');
myColors(10,:) = rgb('darkgreen');
myColors(11,:) = rgb('cyan');
myColors(12,:) = rgb('darkorchid');
out = myColors(1:n,:);

%% old version 
% function [out] = my_colors(n)
% myColors(1,:) = [ 0  0  0]; %black
% myColors(2,:) = rgb('Yellow');
% %myColors(2,:) = [204/255 85/255 0]; %burnt orange
% myColors(3,:) = rgb('SkyBlue');
% myColors(4,:) = [0  .60  .50]; %bluish green
% myColors(5,:) = [0.8  0.40 0]; %vermillion
% myColors(6,:) = rgb('MediumPurple');
% myColors(7,:) = [1.0000    0.0781    0.5742]; %DeepPink
% myColors(8,:) = rgb('orange');
% myColors(9,:) = [0.6602    0.6602    0.6602]; %DarkGray
% myColors(10,:) = rgb('Blue');
% out = myColors(1:n,:);