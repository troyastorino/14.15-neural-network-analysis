close all
clear all

%% load data
data = load('data/svmguide1.mat');
data_test = load('data/svmguide1-t.mat');

%% test density
[ density, c ] = test_density( ...
    5, 2, data.in', data.out', data_test.in', data_test.out', 10, 10);

plot_density_vs_confusion(density, c);