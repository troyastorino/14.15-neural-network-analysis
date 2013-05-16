function [ net ] = build_network( ...
    num_input, layer_neurons, p, transfer_fn )
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

% set up layers
layer_neurons_num = sum(layer_neurons);
net.numLayers = layer_neurons_num;
for i = 1:layer_neurons_num
    net.layers{i}.transferFcn = transfer_fn;
    net.layers{i}.size = 1;
    net.layers{i}.initFcn = 'initnw';
end

% make transfer function for layer that connects to output
for i=(1:layer_neurons(end)) + sum(layer_neurons(1:end-1))
    net.layers{i}.transferFcn = 'logsig';
end

% connect input neurons to the first layer
first_layer_num = layer_neurons(1);
net.inputConnect = vertcat(...
    ones(first_layer_num, 1), zeros(layer_neurons_num - first_layer_num, 1));

% make all the connections between layers
layer_connections = zeros(layer_neurons_num);
last_neuron = 0; % the last neuron in the previous layer
num_layers = length(layer_neurons);
for i=1:num_layers-1
    neurons_in_layer = layer_neurons(i); % neurons in the current layer
    for j=1:neurons_in_layer
        current_neuron = last_neuron + j;
        neruons_in_next_layer = layer_neurons(i+1);
        % make guaranteed connections between neurons at i and i+1
        neuron_to = last_neuron + neurons_in_layer + ...
            mod(j-1, neruons_in_next_layer) + 1;
        layer_connections(current_neuron, neuron_to) = 1;
        
        % make probabilistic connection
        for k=1:neruons_in_next_layer
            potential_neuron = last_neuron + neurons_in_layer + k;
            if potential_neuron ~= neuron_to && rand() < p
                layer_connections(current_neuron, potential_neuron) = 1;
            end
        end
    end
    last_neuron = last_neuron + neurons_in_layer;
end
net.layerConnect = layer_connections';

% make connections to the output layer
net.outputConnect = horzcat(...
    zeros(1, layer_neurons_num - layer_neurons(end)), ...
    ones(1, layer_neurons(end)));

net = init(net);

end

