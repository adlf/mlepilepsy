% GUI goals:
% 1. Select net architecture
% 2. Train network with selected data / select already trained network
% 3. Present the results (sensitivity and specify)

function gui
    close all
    
    network_object = [];
    nn_list = [];
    train_data_list = [];
    test_data_list = [];
    
    train_112502 = [];
    train_54802 = [];
    test_112502 = [];
    test_54802 = [];
        
    load('nn_list.mat')
    load('train_data_list.mat');
    load('test_data_list.mat');
   
    load('data/test_54802.mat')
    load('data/test_112502.mat')
    load('data/train_112502.mat')
    load('data/train_54802.mat')
    
    % Create the GUI window
    f = figure('Visible','off', 'Resize','off', 'Position',[0,0,600,400]); f.Name = 'Prediction and detection of epileptic seizures';
    movegui(f, 'northwest')
    f.Visible = 'on';

    % Create GUI items
    left_panel = uipanel('Title','Neural network settings','FontSize',16,'Position',[0.02 0.02 0.45 0.96]);

    select_nn_architecture_text = uicontrol(left_panel,'Style','text','String','1. Select the network architecture:','Position',[10,320,200,25],'HorizontalAlignment','left');  
    select_nn_architecture = uicontrol(left_panel, 'Style','popupmenu','String',{'', 'NN1','NN2','NN3'},'Position',[10,300,200,25],'HorizontalAlignment','left','Callback',@select_nn_architecture_callback);
    select_trained_nn_text = uicontrol(left_panel, 'Style','text','String','2. Select trained NN:','Position',[10,270,200,25],'HorizontalAlignment','left');  
    select_trained_nn = uicontrol(left_panel, 'Style','popupmenu','String',{'', 'NN1','NN2','NN3'},'Position',[10,250,200,25],'HorizontalAlignment','left','Callback',@select_trained_nn_callback);
    select_train_data_text = uicontrol(left_panel, 'Style','text','String','OR select training data:','Position',[10,220,200,25],'HorizontalAlignment','left');  
    select_train_data = uicontrol(left_panel, 'Style','popupmenu', 'String',{'', 'NN1','NN2','NN3'},'Position',[10,200,200,25],'HorizontalAlignment','left','Callback',@select_train_data_callback);
    select_test_data_text = uicontrol(left_panel, 'Style','text','String','3. Select test data','Position',[10,170,200,25],'HorizontalAlignment','left');  
    select_test_data = uicontrol(left_panel, 'Style','popupmenu','String',{'', 'NN1','NN2','NN3'},'Position',[10,150,200,25],'HorizontalAlignment','left','Callback',@select_test_data_callback);
    select_seizure_stage_text = uicontrol(left_panel, 'Style','text','String','4. Select searched seizure state','Position',[10,120,200,25],'HorizontalAlignment','left');  
    select_seizure_stage = uicontrol(left_panel, 'Style','popupmenu','String',{'', 'Interictal', 'Preictal', 'Ictal','Posictal'},'Position',[10,100,200,25],'HorizontalAlignment','left','Callback',@select_seizure_stage_callback);
    clear_settings_button = uicontrol(left_panel, 'Style','pushbutton','String','Clear settings','Position',[10,60,75,25],'Callback',@clear_settings_button_callback);
    train_nn_button = uicontrol(left_panel, 'Style','pushbutton','String','Train network','Position',[90,60,75,25],'Callback',@train_nn_button_callback);
    test_network_button = uicontrol(left_panel, 'Style','pushbutton','String','Test network','Position',[170,60,75,25],'Callback',@test_network_button_callback);
    
    set_visibilities();
    get_nn_architectures();
    get_train_data_list();
    get_test_data_list();
    
%%%% GUI CALLBACKS %%%%
    function select_nn_architecture_callback(source,eventdata) 
        selected = source.String{source.Value}
        if ~strcmp(selected, '')
           get_trained_nns();
        end
        set_visibilities();    
    end

    function select_trained_nn_callback(source,eventdata) 
        selected = source.String{source.Value}

        select_train_data.Value = 1;
        
        if ~strcmp(selected, '')
           % TODO calculate next step choices
        end
        set_visibilities();
    end

    function select_train_data_callback(source,eventdata) 
        selected = source.String{source.Value}

        select_trained_nn.Value = 1;
        
        if ~strcmp(selected, '')           
           % TODO calculate next step choices
        end
        set_visibilities();
    end

    function select_test_data_callback(source,eventdata) 
        selected = source.String{source.Value}
        set_visibilities();
    end

    function select_seizure_stage_callback(source,eventdata) 
        selected = source.String{source.Value}
        set_visibilities();
    end

    function clear_settings_button_callback(source,eventdata) 
       select_nn_architecture.Value = 1;
       select_trained_nn.Value = 1;
       select_train_data.Value = 1;
       select_test_data.Value = 1;
       select_seizure_stage.Value = 1;
       set_visibilities();
    end

%%%% OTHER GUI RELATED FUNCTIONS %%%%
   
    function get_train_data_list()
        select_train_data.String = [{''} train_data_list];
    end
    
    function get_test_data_list()
        select_test_data.String = [{''} test_data_list];
    end

    function get_nn_architectures()
        list = {' '};
        names = transpose(fieldnames(nn_list));
        list = [list, names];
        select_nn_architecture.String = list;
    end

    function get_trained_nns()
        selected_nn = select_nn_architecture.String{select_nn_architecture.Value};
        list = {' '};
        networks = nn_list.(selected_nn).networks;
        
        if ~isempty(networks)
            names = transpose(fieldnames(networks))
            list = [list, names]
        end
        
        select_trained_nn.String = list;
        set_visibilities()
    end

    function set_visibilities()
        % TODO Write visibility settings

        %select_trained_nn.Enable = 'off';
        %select_train_data.Enable = 'off';
        %train_nn_button.Enable = 'off';
        %test_network_button.Enable = 'off';
        %select_seizure_stage.Enable = 'off';
        %select_test_data.Enable = 'off';
        
        nn_arch = select_nn_architecture.Value;
        trained_nn = select_trained_nn.Value;
        training_data = select_train_data.Value;
        test_data = select_test_data.Value;
        seizure_stage = select_seizure_stage.Value;
        
                
        %if nn_arch ~= 1
        %    if length(select_trained_nn.String) > 1
        %        select_trained_nn.Enable = 'on';
        %    end
        %    select_train_data.Enable = 'on';
        %end
        % 
        %if trained_nn ~= 1
        %    select_test_data.Enable = 'on';
        %end
        %        
        %if test_data ~= 1
        %    select_seizure_stage.Enable = 'on';
        %end
        % 
        %if seizure_stage ~= 1
        %    test_network_button.Enable = 'on';
        %end
        
    end

%%%% NEURAL NETWORK FUNCTIONS %%%%

    function train_nn_button_callback(source,eventdata)
        architecture_name = select_nn_architecture.String{select_nn_architecture.Value}
        network_class_handle = nn_list.(architecture_name).handle
        network_object = network_class_handle()
        training_data_name = select_train_data.String{select_train_data.Value}
        training_data = eval(training_data_name);
        network_object.train(training_data.FeatVectSel, training_data.Trg)
    end

    function test_network_button_callback(source,eventdata) 
        test_data_name = select_test_data.String{select_test_data.Value}
        test_data = eval(test_data_name);
        [se, sp, f] = network_object.test(test_data.FeatVectSel, test_data.Trg)
    end

end 