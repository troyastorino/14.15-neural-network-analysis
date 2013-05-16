function plot_density_vs_confusion( density, c )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

figure;

errorbar(density, mean(c), std(c));
xlabel('Interlayer density', 'FontSize', 16)
ylabel('Percent mislabeled', 'FontSize', 16)
set(gca, 'FontSize', 14)

end