function [rand_OPT] = urs(number_of_parameters,num_model_runs,upper,lower)
%Uniform random search model for parameter generation

i = 1;
while i <=number_of_parameters;
    rand('state',i)
    rand_OPT(:,i) = zeros(num_model_runs,1);
    rand_OPT(:,i) = (rand(num_model_runs,1)*(upper(i) - lower(i)) + lower(i));
    i = i + 1;
end



