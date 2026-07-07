function [h1d_flux, h_sim, q_sim, T_sim] = func_read_h1d(dir_sim)
% Function reads Hydrus all output in \dir_sim and returns it as tables 
% v1.0, 12/8/25: Typical read of T_level.out and OBS_NODE.OUT in function
%   form
warning('off', 'MATLAB:table:ModifiedAndSavedVarnames');

dir_cur = pwd; 

cd(dir_sim)

opts = detectImportOptions('T_Level.out','FileType','text','VariableNamesLine',7);
opts.DataLines = [10 Inf];
h1d_flux = readtable('T_Level.out',opts);
h1d_flux(end,:) = [];

sim_data = importdata('OBS_NODE.OUT', ' ', 11);
h1d_nodes = sim_data.data;

dim = size(h1d_nodes);
nodes = (dim(2)-1)/3;

%---Partition ave daily data into variables q, h, T
q_sim = zeros(dim(1), nodes);
h_sim = zeros(dim(1), nodes);
T_sim = zeros(dim(1), nodes);

l = 0;
for k = 1:nodes
    h_sim(:,k) = h1d_nodes(:,l + 2);
    q_sim(:,k) = h1d_nodes(:,l + 3);    
    T_sim(:,k) = h1d_nodes(:,l + 4);
    l = l + 3; %'l' moves across matrix in 3 column steps
end

cd(dir_cur)

end