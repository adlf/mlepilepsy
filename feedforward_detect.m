train_input = train_112502.FeatVectSel;
train_target = train_112502.Trg(3,:);

test_input = test_112502.FeatVectSel;
test_target = test_112502.Trg(3,:);


net = feedforwardnet(16);
net = train(net,train_input,train_target);
%view(net);
y = net(test_input);
perf = perform(net,test_target,y)

count = 0
for i = 1:length(y)
    if y(i) > 0.5
        disp(y(i))
        count = count +1;
    end
end
count