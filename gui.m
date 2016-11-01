function gui
   close all
   
   % Create the GUI window
   f = figure('Visible','off', 'Resize','off', 'Position',[0,0,600,400]);   f.Name = 'Prediction and detection of epileptic seizures';
   f.Name = 'Prediction and detection of epileptic seizures';
   movegui(f, 'northwest')
   f.Visible = 'on';

   % Create GUI items
   select_nn_to_train_text = uicontrol('Style','text','String','Select NN to train:',...
          'Position',[0,360,100,25]);  
   
   select_nn_to_train = uicontrol('Style','popupmenu',...
      'String',{'NN1','NN2','NN3'},...
      'Position',[0,340,100,25],...
      'Callback',@select_nn_to_train_callback);
 
   select_trained_nn_text = uicontrol('Style','text','String','Select trained NN:',...
          'Position',[0,300,100,25]);  
   
   select_trained_nn = uicontrol('Style','popupmenu',...
      'String',{'NN1','NN2','NN3'},...
      'Position',[0,280,100,25],...
      'Callback',@select_trained_nn_callback);

   
   calculate_button = uicontrol('Style','pushbutton','String','Do something',...
          'Position',[0,240,100,25],...
          'Callback',@calculate_button_callback);

   
   f.Units = 'normalized';
   select_nn_to_train.Units = 'normalized';
   select_nn_to_train_text.Units = 'normalized';
   select_trained_nn.Units = 'normalized';
   select_trained_nn_text.Units = 'normalized';
   calculate_button.Units = 'normalized';

   
  % GUI callbacks
  function select_nn_to_train_callback(source,eventdata) 
     str = source.String
     val = source.Value     
  end
 
  function select_trained_nn_callback(source,eventdata) 
     str = source.String
     val = source.Value      
  end

   function calculate_button_callback(source,eventdata) 
        'calculate'
   end
end 