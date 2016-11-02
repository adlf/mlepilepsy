% GUI goals:
% 1. Select net architecture
% 2. Train network with selected data / select already trained network
% 3. Present the results (sensitivity and specify)

function gui
   close all
   
   state = [];
   state.selected_arch = [];
   state.selected_arch.name = '';
   state.selected_arch.value = '';
   
   state.selected_trained_nn = [];
   state.selected_trained_nn.name = '';
   state.selected_trained_nn.value = '';
   
   state.selected_training_data = [];
   state.selected_training_data.name = '';
   state.selected_training_data.value = '';
   
   state.network = [];
   
   % Create the GUI window
   f = figure('Visible','off', 'Resize','off', 'Position',[0,0,600,400]);   f.Name = 'Prediction and detection of epileptic seizures';
   f.Name = 'Prediction and detection of epileptic seizures';
   movegui(f, 'northwest')
   f.Visible = 'on';

   % Create GUI items
   
   left_panel = uipanel('Title','Neural network settings','FontSize',16,'Position',[0.02 0.02 0.45 0.96]);

   
   select_nn_architecture_text = uicontrol(left_panel, 'Style','text','String','1. Select the network architecture:',...
          'Position',[10,320,200,25],'HorizontalAlignment','left');  
   
   select_nn_architecture = uicontrol(left_panel, 'Style','popupmenu',...
      'String',{'', 'NN1','NN2','NN3'},...
      'Position',[10,300,200,25],'HorizontalAlignment','left',...
      'Callback',@select_nn_architecture_callback);
 
   select_trained_nn_text = uicontrol(left_panel, 'Style','text','String','2. Select trained NN:',...
          'Position',[10,270,200,25],'HorizontalAlignment','left');  
   
   select_trained_nn = uicontrol(left_panel, 'Style','popupmenu',...
      'String',{'', 'NN1','NN2','NN3'},...
      'Position',[10,250,200,25],'HorizontalAlignment','left',...
      'Callback',@select_trained_nn_callback);
   
   select_training_data_text = uicontrol(left_panel, 'Style','text','String','OR select training data:',...
          'Position',[10,220,200,25],'HorizontalAlignment','left');  
   
   select_training_data = uicontrol(left_panel, 'Style','popupmenu',...
      'String',{'', 'NN1','NN2','NN3'},...
      'Position',[10,200,200,25],'HorizontalAlignment','left',...
      'Callback',@select_training_data_callback);

  
   clear_settings_button = uicontrol(left_panel, 'Style','pushbutton','String','Clear settings',...
          'Position',[10,80,75,25],...
          'Callback',@clear_settings_button_callback);
  
   train_nn_button = uicontrol(left_panel, 'Style','pushbutton','String','Train network',...
          'Position',[90,80,75,25],...
          'Callback',@train_nn_button_callback);
  
   test_network_button = uicontrol(left_panel, 'Style','pushbutton','String','Do something',...
          'Position',[170,80,75,25],...
          'Callback',@test_network_button_callback);

   select_nn_architecture_text.Visible = 'on';
   select_nn_architecture.Visible = 'on';
   
   select_trained_nn_text.Visible = 'off';
   select_trained_nn.Visible = 'off';
   
   select_training_data_text.Visible = 'off';
   select_training_data.Visible = 'off';
   
   train_nn_button.Visible = 'off';
   test_network_button.Visible = 'off';
   clear_settings_button.Visible = 'off';

   
    % GUI callbacks
    function select_nn_architecture_callback(source,eventdata) 
        str = source.String
        val = source.Value
        selected = str{val}

        if strcmp(selected, '')
           select_trained_nn.Visible = 'off';
           select_trained_nn_text.Visible = 'off';
           select_training_data.Visible = 'off';
           select_training_data_text.Visible = 'off';
           test_network_button.Visible = 'off';
           clear_settings_button.Visible = 'off';
           train_nn_button.Visible = 'off';
        else
           select_trained_nn.Visible = 'on';
           select_trained_nn_text.Visible = 'on';
           select_training_data.Visible = 'on';
           select_training_data_text.Visible = 'on';
           test_network_button.Visible = 'off';
           clear_settings_button.Visible = 'on';
           train_nn_button.Visible = 'off';
           
           % TODO calculate next step choices
        end
    end

    function select_trained_nn_callback(source,eventdata) 
        str = source.String
        val = source.Value
        selected = str{val}

        select_training_data.Value = 1;
        
        if strcmp(selected, '')
           test_network_button.Visible = 'off';
           train_nn_button.Visible = 'off';
        else
           test_network_button.Visible = 'on';
           train_nn_button.Visible = 'off';
           
           % TODO calculate next step choices
        end    
    end

    function select_training_data_callback(source,eventdata) 
        str = source.String
        val = source.Value
        selected = str{val}

        select_trained_nn.Value = 1;
        
        if strcmp(selected, '')
           test_network_button.Visible = 'off';
           train_nn_button.Visible = 'off';
        else
           test_network_button.Visible = 'off';
           train_nn_button.Visible = 'on';
           
           % TODO calculate next step choices
        end 
    end

    function train_nn_button_callback(source,eventdata)
        test_network_button.Visible = 'on';
    end

    function test_network_button_callback(source,eventdata) 
        test_network_button.Visible = 'on';
    end

    function clear_settings_button_callback(source,eventdata) 
       select_trained_nn.Visible = 'off';
       select_trained_nn_text.Visible = 'off';
       select_training_data.Visible = 'off';
       select_training_data_text.Visible = 'off';
       test_network_button.Visible = 'off';
       clear_settings_button.Visible = 'off';
       train_nn_button.Visible = 'off';
       select_nn_architecture.Value = 1;
    end
end 