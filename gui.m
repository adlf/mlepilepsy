% GUI goals:
% 1. Select one network from the network list
%    - All networks are trained with preictal or ictal
%    data of 54802 and 112502
% 2. Clear weights and / or train more
% 3. Test network with selected data
% 4. Show test results

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
    
    % Create the GUI window
    f = figure('Visible','off', 'Resize','off', 'Position',[0,0,600,400]); f.Name = 'Prediction and detection of epileptic seizures';
    movegui(f, 'northwest')
    f.Visible = 'on';

    % Create GUI items
    left_panel = uipanel('Title','Neural network settings','FontSize',16,'Position',[0.02 0.02 0.45 0.96]);

    select_nn_text = uicontrol(left_panel,'Style','text','String','1. Select the network:','Position',[10,320,200,25],'HorizontalAlignment','left');  
    select_nn_architecture = uicontrol(left_panel, 'Style','popupmenu','String',{'', 'NN1','NN2','NN3'},'Position',[10,300,200,25],'HorizontalAlignment','left','Callback',@select_nn_architecture_callback);
        
    select_train_data_text = uicontrol(left_panel, 'Style','text','String','Select training data:','Position',[10,220,200,25],'HorizontalAlignment','left');  
    select_train_data = uicontrol(left_panel, 'Style','popupmenu', 'String',{'', 'NN1','NN2','NN3'},'Position',[10,200,200,25],'HorizontalAlignment','left','Callback',@select_train_data_callback);
    
    select_test_data_text = uicontrol(left_panel, 'Style','text','String','3. Select test data','Position',[10,170,200,25],'HorizontalAlignment','left');  
    select_test_data = uicontrol(left_panel, 'Style','popupmenu','String',{'', 'NN1','NN2','NN3'},'Position',[10,150,200,25],'HorizontalAlignment','left','Callback',@select_test_data_callback);
        
    train_nn_button = uicontrol(left_panel, 'Style','pushbutton','String','Train network','Position',[90,60,75,25],'Callback',@train_nn_button_callback);
    test_network_button = uicontrol(left_panel, 'Style','pushbutton','String','Test network','Position',[170,60,75,25],'Callback',@test_network_button_callback);
    error_text = uicontrol(left_panel, 'ForegroundColor', 'red', 'Style','text','String','','Position',[10,30,200,25],'HorizontalAlignment','left');

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

    function select_train_data_callback(source,eventdata) 
        selected = source.String{source.Value}
        
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
       select_train_data.Value = 1;
       select_test_data.Value = 1;
       select_seizure_stage.Value = 1;
       error_text.String = '';
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
        
        set_visibilities()
    end

    function set_visibilities()
        % TODO Write visibility settings

        %select_train_data.Enable = 'off';
        %train_nn_button.Enable = 'off';
        %test_network_button.Enable = 'off';
        %select_seizure_stage.Enable = 'off';
        %select_test_data.Enable = 'off';
        
        nn_arch = select_nn_architecture.Value;
        training_data = select_train_data.Value;
        test_data = select_test_data.Value;

        
    end

%%%% NEURAL NETWORK FUNCTIONS %%%%

    function train_nn_button_callback(source,eventdata)        
        error_message = '';
        if select_nn_architecture.Value == 1
            error_message = 'Select the architecture';
        elseif select_train_data.Value == 1
            error_message = 'Select training data';
        elseif select_seizure_stage.Value == 1
            error_message = 'Select used seizure state';
        end
        
        if ~strcmp(error_message, '')
            disp(error_message);
            error_text.String = error_message;
            return
        end
        
        seizure_stage = select_seizure_stage.Value - 1;
        architecture_name = select_nn_architecture.String{select_nn_architecture.Value}
        network_class_handle = nn_list.(architecture_name).handle
        network_object = network_class_handle()
        training_data_name = select_train_data.String{select_train_data.Value}
        training_data = eval(training_data_name);
        network_object.train(training_data.FeatVectSel, training_data.Trg(seizure_stage,:))
    end

    function test_network_button_callback(source,eventdata) 

        error_message = '';
        if ~isobject(network_object)
            error_message = 'Neural network not found'; 
        end
        
        if ~strcmp(error_message, '')
            disp(error_message);
            error_text.String = error_message;
            return
        end
        
        seizure_stage = select_seizure_stage.Value - 1;
        test_data_name = select_test_data.String{select_test_data.Value}
        test_data = eval(test_data_name);
        [se, sp, f] = network_object.test(test_data.FeatVectSel, test_data.Trg(seizure_stage,:))
    end
end 