clc
close all
clear all

%% load data
data = load('data/svmguide1.mat');
data_test = load('data/svmguide1-t.mat');

%% test density
[ density_a_4_2, c_a_4_2, epoch_a_4_2 ] = test_density( ...
    4, 2, data.in', data.out', data_test.in', data_test.out', 5, 30);
plot_data('Astrophysics Data, 4 Neurons/Layer, 2 Layers', density_a_4_2, c_a_4_2, epoch_a_4_2);

[ density_a_8_2, c_a_8_2, epoch_a_8_2 ] = test_density( ...
    8, 2, data.in', data.out', data_test.in', data_test.out', 5, 30);
plot_data('Astrophysics Data, 8 Neurons/Layer, 2 Layers', density_a_8_2, c_a_8_2, epoch_a_8_2);

[ density_a_4_3, c_a_4_3, epoch_a_4_3 ] = test_density( ...
    4, 3, data.in', data.out', data_test.in', data_test.out', 5, 30);
plot_data('Astrophysics Data, 4 Neurons/Layer, 3 Layers', density_a_4_3, c_a_4_3, epoch_a_4_3);

%% splice dataset
data = load('data/splice.mat');
data_test = load('data/splice-t.mat');

%% test density
[ density_s_15_2, c_s_15_2, epoch_s_15_2 ] = test_density( ...
    15, 2, data.in', data.out', data_test.in', data_test.out', 20, 5);
plot_data('Splice Data, 15 Neurons/Layer, 2 Layers', density_s_15_2, c_s_15_2, epoch_s_15_2);

[ density_s_30_2, c_s_30_2, epoch_s_30_2 ] = test_density( ...
    30, 2, data.in', data.out', data_test.in', data_test.out', 20, 5);
plot_data('Splice Data, 30 Neurons/Layer, 2 Layers', density_s_30_2, c_s_30_2, epoch_s_30_2);

[ density_s_15_3, c_s_15_3, epoch_s_15_3 ] = test_density( ...
    15, 3, data.in', data.out', data_test.in', data_test.out', 20, 5);
plot_data('Splice Data, 15 Neurons/Layer, 3 Layers', density_s_15_3, c_s_15_3, epoch_s_15_3);
