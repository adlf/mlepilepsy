function [se, sp, f, o_se, o_sp, o_f, threshold, name] = test_layrec(delays, layers, train_input, train_target, test_input, test_target,type,iterations)

    disp('Create network')
    net = layrecnet(delays,layers,'trainscg');
    net.divideParam.trainRatio = 1;
    net.divideParam.valRatio = 0;
    net.divideParam.testRatio = 0;
    net.trainParam.epochs = iterations;

    disp('Configure network')
    net = configure(net, train_input, train_target);
    net = init(net);
        
    if isempty(gcp('nocreate'))
        disp('Train network as single thread')
        net = train(net, train_input, train_target,'useParallel','no');
    else
        disp('Train network as parallel')
        net = train(net, train_input, train_target,'useParallel','yes');        
    end

    disp('Calculate results')
    result = net(test_input);
    
    [o_se, o_sp, o_f] = calculate_performance(round(result), test_target);

    maxf = 0;
    maxi = 0;
    
    disp('Find the best bias')
    for i = 0:0.05:1
       if i == 0 || i == 0.2 || i == 0.4 || i == 0.6 || i == 0.8 || i == 1
           disp(strcat([num2str(i*100),'%']))
       end
       rounded_res = result > i;
       [se, sp, f] = calculate_performance(rounded_res, test_target);
       if f > maxf
           maxf = f;
           maxi = i;
       end
    end

    threshold = maxi;
    
    disp('Save and return')
    rounded_res = result > maxi;
    [se, sp, f] = calculate_performance(rounded_res, test_target);
    
    delaystr = num2str(length(delays));
    layerstr = '';
    for i = 1:length(layers)
        layerstr = strcat(layerstr, '_',num2str(layers(i)));
    end
    
    name = strcat([type,layerstr, '_D_', delaystr]);
    
    eval(strcat([name,'=net;']));
    path = strcat(['networks/',name]);
    save(path, name);
end
