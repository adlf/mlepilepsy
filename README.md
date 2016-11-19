Machine learning project.
1. Read Introduction.pdf to understand the problem.
2. Run gui.m to run the application

Structure:

Related with GUI:
gui.m:                  The application GUI
calculate_performance:  a function used in GUI for calculating neural network performance
create_network.m:       a function used in GUI for creating neural networks

/data:                  Original data, data preparing functions and prepared data
/networks:              Neural network objects used in the application

Not related with GUI:
plot_results.m:         a function for plotting results in /results
test_feedforward.m:     a function for creating and testing feedforward networks
test_layrec.m:          a function for creating and testing layer recurrent networks
tests_feedforward.m:    function for training and testing feedforward networks with test_feedforward.m
tests_layrec.m:         function for training and testing layer recurrent networks with test_layrec.m

/images:                Figures from results. Created using data in results folder by result_images.m
/results:               Results from tests in tests_feedforward_multilayer.m and tests_layrec.m

Files probably contain weird solutions because this is my first MATLAB application.
