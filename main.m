close all
clear all

%% load data
data = load('data/svmguide1.mat');
data_test = load('data/svmguide1-t.mat');

%% train data
net = build_multilayer_network(4, 2, 2, 1, 2, 'tansig');

[net, tr] = train(net, data.in', data.out');
plotperform(tr);

test_out = net(data_test.in');
plotconfusion(data_test.out', test_out);
[c, cm] = confusion(data_test.out', test_out);