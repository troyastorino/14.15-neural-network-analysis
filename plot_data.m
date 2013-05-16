function [ output_args ] = plot_data( title_str, density, c, epoch )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

plot_density_vs_confusion(density, c);
title(title_str, 'FontSize', 18);
plot_density_vs_training(density, epoch);
title(title_str, 'FontSize', 18);

end

