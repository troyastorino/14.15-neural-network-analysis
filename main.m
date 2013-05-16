%% load data
data = load('data/svmguide1.mat');
data_t = load('data/svmguide1-t.mat');

%% train data
net = build_network(4, [5 1], .5, 'tansig');

net = init(net);
[net, tr] = train(net, data.in', data.out');