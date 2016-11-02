

net = feedforwardnet(5);
net = train(net,train_Feat,train_T);
%view(net);
y = net(test_Feat);
y = clean_output(y);
perf = perform(net,test_T,y);
