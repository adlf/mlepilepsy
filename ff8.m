classdef ff8 < handle 

    properties
        Net
    end
    
    methods   
        function obj = ff8()
            obj.Net = feedforwardnet(8);
        end

        function obj = setNet(net)
            obj.Net = net;
        end
        
        function obj = train(obj, input, target)
            obj.Net = train(obj.Net,input,target);
        end
        
        function [se, sp, f] = test(obj, input, target)
            y = obj.Net(input);
            [se, sp, f] = calculate_performance(y, target);
        end
        
        function net = get.Net(obj)
           net = obj.Net;
        end
        
    end
end