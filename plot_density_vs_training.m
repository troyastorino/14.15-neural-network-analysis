function plot_density_vs_training( density, epoch )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

figure;
errorbar(density, mean(epoch), std(epoch));
xlabel('Interlayer density', 'FontSize', 16)
ylabel('Training time [number of samples]', 'FontSize', 16)
set(gca, 'FontSize', 14)

end

