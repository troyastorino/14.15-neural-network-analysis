function [ net ] = build_multilayer_network( ...
    num_input, neurons_per_layer, num_layers, num_output, ...
    num_extra_conns, transfer_fn)
%build_network Constructs a neural network model with random connections
%between computation layers.  Connection placed between any two neurons in
%computation layers with probability p.  All neurons in layer i-1 will have
%at least one connection to neurons in layer i, and preferably these
%guaranteed connections will be on a 1-to-1 basis
%   num_input - number of input neurons
%   num_output - number of output neurons
%   layer_neurons - list of number of neurons in each of the computational
%   layers. For instance, if this was [2 4 3], it would mean 2 neurons were
%   in the 1st layer, 4 neurons were in the 2nd layer, and 3
%   neurons were in the 3rd layer. The last layer is the output layer
%   p - probability of a connection between between two neurons in adjacent
%   computation layers
%   transfer_fn - the transfer function to use at each of the neurons. Type
%   'help nntransfer' to see the list of options

net = network;
net.adaptFcn = 'adaptwb';
%net.adaptParam
net.derivFcn = 'defaultderiv';
net.divideFcn = 'dividerand';
net.divideMode = 'sample';
%net.divideParam;
net.initFcn = 'initlay';
net.trainFcn = 'trainscg';
net.performFcn = 'mse';
net.numInputs = 1;
net.inputs{1}.size = num_input;

num_layer_neurons = neurons_per_layer * num_layers;
net.numLayers = num_layer_neurons + num_output;

% set up layers
for i=1:net.numLayers
    net.layers{i}.transferFcn = transfer_fn;
    net.layers{i}.size = 1;
    net.layers{i}.initFcn = 'initnw';
end
% make transfer function for layer that connects to output
for i=((1:num_output) + num_layer_neurons)
    net.layers{i}.transferFcn = 'logsig';
end

% connect input neurons to the first layer
net.inputConnect = vertcat(...
    ones(neurons_per_layer, 1), zeros(net.numLayers - neurons_per_layer, 1));

% make the minimum connections between layers
layer_connections = zeros(net.numLayers);
% hidden layer connections
for i=1:num_layers-1
    for j=1:neurons_per_layer
        layer_connections(i*neurons_per_layer + j, ...
            (i-1)*neurons_per_layer + j) = 1;
    end
end
% output layer connections
for i=((1:num_output)+num_layer_neurons)
    layer_connections(i,:) = horzcat(...
        zeros(1, num_layer_neurons - neurons_per_layer), ...
        ones(1, neurons_per_layer), ...
        zeros(1, num_output));
end

% add the additional connections probabilistically
num_possible_conns = ...
    neurons_per_layer * (neurons_per_layer - 1) * (num_layers - 1);
possible_conns = zeros(num_possible_conns, 2);
current_conn = 1;
for i=1:num_layers-1
    for j=1:neurons_per_layer
        for k=1:neurons_per_layer
            if j~=k
                possible_conns(current_conn, :) = ...
                    [i*neurons_per_layer+k (i-1)*neurons_per_layer+j];
                current_conn = current_conn + 1;
            end
        end
    end
end
if num_extra_conns > 0
    if num_extra_conns > num_possible_conns
        error('More extra connections were asked for than is possible')
    end
    conn_idxs = randsample(num_possible_conns, num_extra_conns);
    for idx=conn_idxs'
        layer_connections(possible_conns(idx, 1), possible_conns(idx, 2)) = 1;
    end
end

net.layerConnect = layer_connections;

% make connections to the output layer
net.outputConnect = horzcat(...
    zeros(1, num_layer_neurons), ...
    ones(1, num_output));

net = init(net);

end

