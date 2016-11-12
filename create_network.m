function [net, name] = create_network(a,b)
	%- FeedForward neural network
	%- Distributed Delay neural network
	%- Time Delay neural network 
	%--- Layer Recurrent neural network
	%--- Radial Basis Neural network

    f = figure('Visible','off', 'Resize','off', 'Position',[0,0,300,400]); f.Name = 'Create a new network';
    movegui(f, 'northwest')
    f.Visible = 'on';
    
    network = [];
    
    left_panel = uipanel('Title','Create a network','FontSize',16,'Position',[0.02 0.02 0.95 0.95]);
    
    select_name_text          = uicontrol(left_panel,'Position',[10,320,200,25],'Style','text','String','Select the network name:','HorizontalAlignment','left');  
    select_name               = uicontrol(left_panel,'Position',[10,300,200,25],'Style','edit','HorizontalAlignment','left');
    select_description_text   = uicontrol(left_panel,'Position',[10,280,200,25],'Style','text','String','Description for the network:','HorizontalAlignment','left');  
    select_description        = uicontrol(left_panel,'Position',[10,260,200,25],'Style','edit','HorizontalAlignment','left');
    select_type_text          = uicontrol(left_panel,'Position',[10,240,200,25],'Style','text','String','Select the network type:','HorizontalAlignment','left');  
    select_type               = uicontrol(left_panel,'Position',[10,220,200,25],'Style','popupmenu','String',...
        {'FeedForward neural network','Distributed Delay neural','Time Delay neural network', 'Layer Recurrent neural network'},...
        'HorizontalAlignment','left','Callback',@select_network_callback);
    save_network_button       = uicontrol(left_panel,'Position',[160,10,100,25],'Style','pushbutton','String','Save & Close','Callback',@save_network);

    ui_controls = {};
    select_network_callback(select_type);
    
    function select_network_callback(source, eventdata)
        value = source.Value
        switch value
            case 1 % Feedforward
                clear_ui();
                ui_controls{1}   = uicontrol(left_panel,'Position',[10,200,200,25],'Style','text','String','Select amount(s) of hidden neurons:','HorizontalAlignment','left');  
                ui_controls{2}   = uicontrol(left_panel,'Position',[10,180,200,25],'Style','edit','HorizontalAlignment','left', 'String','[5]');
                ui_controls{3}   = uicontrol(left_panel,'Position',[10,160,200,25],'Style','text','String','Select training function:','HorizontalAlignment','left');  
                ui_controls{4}   = uicontrol(left_panel,'Position',[10,140,200,25],'Style','popupmenu', 'String',{'trainlm','trainbfg','trainrp','trainscg','traincgb','traincgf','traincgp','trainoss','traingdx'}	,'HorizontalAlignment','left');
                ui_controls{5}   = uicontrol(left_panel,'Position',[10,120,200,25],'Style','text','String','Select transfer function(s):','HorizontalAlignment','left');  
                ui_controls{8}   = uicontrol(left_panel,'Position',[10,100,200,25],'Style','edit','HorizontalAlignment','left', 'String','{''tansig'', ''purelin''}');
                ui_controls{6}   = uicontrol(left_panel,'Position',[20,10,100,25],'Style','pushbutton','String','Create network','Callback',@create_feedforward);          
                ui_controls{7}   = uicontrol(left_panel,'Position',[0,0,0,0],'Style','text', 'Visible','off');  

            case 2 % Distributed delay
                clear_ui();
                ui_controls{1}   = uicontrol(left_panel,'Position',[10,200,200,25],'Style','text','String','Select amount(s) of hidden neurons','HorizontalAlignment','left');
                ui_controls{2}   = uicontrol(left_panel,'Position',[10,180,200,25],'Style','edit','HorizontalAlignment','left', 'String','[5]');
                ui_controls{3}   = uicontrol(left_panel,'Position',[10,160,200,25],'Style','text','String','Select delays','HorizontalAlignment','left');
                ui_controls{4}   = uicontrol(left_panel,'Position',[10,140,200,25],'Style','edit','HorizontalAlignment','left','String','{1:2, 1:3}');
                ui_controls{5}   = uicontrol(left_panel,'Position',[10,120,200,25],'Style','text','String','Select training function:','HorizontalAlignment','left');  
                ui_controls{6}   = uicontrol(left_panel,'Position',[10,100,200,25],'Style','popupmenu', 'String',{'trainlm','trainbfg','trainrp','trainscg','traincgb','traincgf','traincgp','trainoss','traingdx'}	,'HorizontalAlignment','left');
                ui_controls{7}   = uicontrol(left_panel,'Position',[10,80,200,25],'Style','text','String','Select transfer function(s):','HorizontalAlignment','left');  
                ui_controls{8}   = uicontrol(left_panel,'Position',[10,60,200,25],'Style','edit','HorizontalAlignment','left', 'String','{''tansig'', ''purelin''}');
                ui_controls{9}   = uicontrol(left_panel,'Position',[20,10,100,25],'Style','pushbutton','String','Create network','Callback',@create_distdelay);                

            case 3 % Time Delay neural network 
                clear_ui();
                ui_controls{1}   = uicontrol(left_panel,'Position',[10,200,200,25],'Style','text','String','Select amount(s) of hidden neurons','HorizontalAlignment','left');
                ui_controls{2}   = uicontrol(left_panel,'Position',[10,180,200,25],'Style','edit','HorizontalAlignment','left', 'String','[5]');
                ui_controls{3}   = uicontrol(left_panel,'Position',[10,160,200,25],'Style','text','String','Select delays','HorizontalAlignment','left');
                ui_controls{4}   = uicontrol(left_panel,'Position',[10,140,200,25],'Style','edit','HorizontalAlignment','left','String','1:2');
                ui_controls{5}   = uicontrol(left_panel,'Position',[10,120,200,25],'Style','text','String','Select training function:','HorizontalAlignment','left');  
                ui_controls{6}   = uicontrol(left_panel,'Position',[10,100,200,25],'Style','popupmenu', 'String',{'trainlm','trainbfg','trainrp','trainscg','traincgb','traincgf','traincgp','trainoss','traingdx'}	,'HorizontalAlignment','left');
                ui_controls{7}   = uicontrol(left_panel,'Position',[10,80,200,25],'Style','text','String','Select transfer function(s):','HorizontalAlignment','left');  
                ui_controls{8}   = uicontrol(left_panel,'Position',[10,60,200,25],'Style','edit','HorizontalAlignment','left', 'String','{''tansig'', ''purelin''}');
                ui_controls{9}   = uicontrol(left_panel,'Position',[20,10,100,25],'Style','pushbutton','String','Create network','Callback',@create_timedelay);                

            case 4 % Layer recurrent neural network 
                clear_ui();
                ui_controls{1}   = uicontrol(left_panel,'Position',[10,200,200,25],'Style','text','String','Select amount(s) of hidden neurons','HorizontalAlignment','left');
                ui_controls{2}   = uicontrol(left_panel,'Position',[10,180,200,25],'Style','edit','HorizontalAlignment','left', 'String','[5]');
                ui_controls{3}   = uicontrol(left_panel,'Position',[10,160,200,25],'Style','text','String','Select delays','HorizontalAlignment','left');
                ui_controls{4}   = uicontrol(left_panel,'Position',[10,140,200,25],'Style','edit','HorizontalAlignment','left','String','1:2');
                ui_controls{5}   = uicontrol(left_panel,'Position',[10,120,200,25],'Style','text','String','Select training function:','HorizontalAlignment','left');  
                ui_controls{6}   = uicontrol(left_panel,'Position',[10,100,200,25],'Style','popupmenu', 'String',{'trainlm','trainbfg','trainrp','trainscg','traincgb','traincgf','traincgp','trainoss','traingdx'}	,'HorizontalAlignment','left');
                ui_controls{7}   = uicontrol(left_panel,'Position',[10,80,200,25],'Style','text','String','Select transfer function(s):','HorizontalAlignment','left');  
                ui_controls{8}   = uicontrol(left_panel,'Position',[10,60,200,25],'Style','edit','HorizontalAlignment','left', 'String','{''tansig'', ''purelin''}');
                ui_controls{9}   = uicontrol(left_panel,'Position',[20,10,100,25],'Style','pushbutton','String','Create network','Callback',@create_layrecnet);                
        end
    end

    function create_feedforward(source, eventdata)
        disp('Create feedforward');
        neurons = eval(ui_controls{2}.String)
        trainfnc = ui_controls{4}.String{ui_controls{4}.Value}
        net = feedforwardnet(neurons, trainfnc);
        net.userdata.type = 'feedforwardnet';
        net = common_settings(net);
    end

    function create_distdelay(source, eventdata)
        disp('Create distdelay');
        neurons = eval(ui_controls{2}.String)
        delays = eval(ui_controls{4}.String)
        trainfnc = ui_controls{6}.String{ui_controls{6}.Value}
        net = distdelaynet(delays, neurons, trainfnc)
        net.userdata.type = 'distdelaynet';
        net = common_settings(net);
    end

    function create_timedelay(source, eventdata)
        disp('Create timedelau');
        neurons = eval(ui_controls{2}.String)
        delays = eval(ui_controls{4}.String)
        trainfnc = ui_controls{6}.String{ui_controls{6}.Value}
        net = timedelaynet(delays, neurons, trainfnc)
        net.userdata.type = 'timedelaynet';
        net = common_settings(net);
    end

    function create_layrecnet(source, eventdata)
        disp('Create layrecnet');
        neurons = str2num(ui_controls{2}.String)
        delays = eval(ui_controls{4}.String)
        trainfnc = ui_controls{6}.String{ui_controls{6}.Value}
        net = layrecnet(delays, neurons, trainfnc)
        net.userdata.type = 'layrecnet';
        net = common_settings(net);
    end
    
    function net = common_settings(net)
        transferFcn = eval(ui_controls{8}.String)
        for i = 1:length(transferFcn)
            disp('change transferfunction')
            fcn = char(transferFcn{i})
            net.layers{i}.transferFcn
            net.layers{i}.transferFcn = fcn
        end
        net.name = char(select_description.String);
        net.divideParam.trainRatio = 0.7;
        net.divideParam.valRatio = 0.15;
        net.divideParam.testRatio = 0.15;
        net.trainParam.min_grad = 1e-20;
        view(net);
    end

    function clear_ui()
        disp('Clearing ui');
        for i = 1:length(ui_controls)
            ui_controls{i}.Visible = 'off';
            delete(ui_controls{i});
        end
        ui_controls = {};
    end

    function save_network(source, eventdata)
        netname = char(select_name.String);
        name = netname;
        uiresume(gcbf);
        delete(f);
    end

    uiwait(gcf);
end


