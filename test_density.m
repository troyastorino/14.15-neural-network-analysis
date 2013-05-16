function [ density, c, epoch ] = test_density(neurons_per_layer, num_layers, ...
    x, t, x_test, t_test, n_densities, tests_per_density)
%test_density Trains a network at different densities and tests how well it
%has learned
%   Detailed explanation goes here

x_sz = size(x);
t_sz = size(t);

possible_extra_conns = ...
    neurons_per_layer * (neurons_per_layer - 1)* (num_layers - 1);

extra_conns = 0:floor(possible_extra_conns/n_densities):possible_extra_conns;
n_densities = length(extra_conns);
density = zeros(n_densities, 1);
c = zeros(tests_per_density, n_densities);
epoch = zeros(tests_per_density, n_densities);
for i=1:n_densities
    for j=1:tests_per_density
        [net, density(i)] = build_multilayer_network(x_sz(1), ...
            neurons_per_layer, num_layers, t_sz(1), extra_conns(i), 'tansig');
    
        [net, tr] = train(net, x, t);
        epoch(j, i) = length(tr.epoch);
    
        test_out = net(x_test);
        [c(j, i), cm] = confusion(t_test, test_out);
    end
end

end
