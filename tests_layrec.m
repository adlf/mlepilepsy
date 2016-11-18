% 8.15 1 of 4 test sets ready
clear all;
load('data/train_112502_input.mat');
load('data/train_112502_trg_ictal.mat');
load('data/test_112502_input.mat');
load('data/test_112502_trg_ictal.mat');

test_name = 'layrec_ictal_112502';
iterations = 500;
results = {};
o_fscores = [];
fscores = [];
tr_i = train_112502_input;
tr_t = train_112502_trg_ictal;
te_i = test_112502_input;
te_t = test_112502_trg_ictal;
close all;
f = figure;
movegui(f, 'northwest');
hold on;

disp('Starting layrecnet ictal test with patient 112502');
for d = 1:5
    for i = 1:3
        delays = 1:2^d;
        layers = [i*20];
        disp(strcat(['112502 ictal D and i: ', num2str(d), ' and ',num2str(i)]))
        [se,sp,f,o_se,o_sp,o_f,threshold, name] = test_layrec(delays, layers, tr_i, tr_t, te_i, te_t,test_name, iterations);
        results.(name) = {}; 
        results.(name).se = se;
        results.(name).sp = sp;
        results.(name).f = f;
        results.(name).o_se = o_se;
        results.(name).o_sp = o_sp;
        results.(name).o_f = o_f;        
        o_fscores(length(o_fscores)+1) = o_f;
        fscores(length(fscores)+1) = f;
        stem(fscores,'b');
        stem(o_fscores,'r');
    end
end

eval(strcat([test_name,'=results;']));
path = strcat(['results/',test_name]);
save(path, test_name);


clear all;
load('data/train_54802_input.mat');
load('data/train_54802_trg_ictal.mat');
load('data/test_54802_input.mat');
load('data/test_54802_trg_ictal.mat');

test_name = 'layrec_ictal_54802';
iterations = 500;
results = {};
o_fscores = [];
fscores = [];
tr_i = train_54802_input;
tr_t = train_54802_trg_ictal;
te_i = test_54802_input;
te_t = test_54802_trg_ictal;
close all;
f = figure;
movegui(f, 'northwest');
hold on;

disp('Starting layrecnet ictal test with patient 54802');
for d = 1:5
    for i = 1:3
        delays = 1:2^d;
        layers = [i*20];
        disp(strcat(['54802 ictal D and i: ', num2str(d), ' and ',num2str(i)]))
        [se,sp,f,o_se,o_sp,o_f,threshold, name] = test_layrec(delays, layers, tr_i, tr_t, te_i, te_t,test_name, iterations);
        results.(name) = {}; 
        results.(name).se = se;
        results.(name).sp = sp;
        results.(name).f = f;
        results.(name).o_se = o_se;
        results.(name).o_sp = o_sp;
        results.(name).o_f = o_f;        
        o_fscores(length(o_fscores)+1) = o_f;
        fscores(length(fscores)+1) = f;
        stem(fscores,'b');
        stem(o_fscores,'r');
    end
end

eval(strcat([test_name,'=results;']));
path = strcat(['results/',test_name]);
save(path, test_name);


%%%% PREICTAL TESTS %%%%


clear all;
load('data/train_112502_input.mat');
load('data/train_112502_trg_preictal.mat');
load('data/test_112502_input.mat');
load('data/test_112502_trg_preictal.mat');

test_name = 'layrec_preictal_112502';
iterations = 500;
results = {};
o_fscores = [];
fscores = [];
tr_i = train_112502_input;
tr_t = train_112502_trg_preictal;
te_i = test_112502_input;
te_t = test_112502_trg_preictal;
close all;
f = figure;
movegui(f, 'northwest');
hold on;

disp('Starting layrecnet preictal test with patient 112502');
for d = 1:5
    for i = 1:3
        delays = 1:2^d;
        layers = [i*20];
        disp(strcat(['112502 preictal D and i: ', num2str(d), ' and ',num2str(i)]))
        [se,sp,f,o_se,o_sp,o_f,threshold, name] = test_layrec(delays, layers, tr_i, tr_t, te_i, te_t,test_name, iterations);
        results.(name) = {}; 
        results.(name).se = se;
        results.(name).sp = sp;
        results.(name).f = f;
        results.(name).o_se = o_se;
        results.(name).o_sp = o_sp;
        results.(name).o_f = o_f;        
        o_fscores(length(o_fscores)+1) = o_f;
        fscores(length(fscores)+1) = f;
        stem(fscores,'b');
        stem(o_fscores,'r');
    end
end

eval(strcat([test_name,'=results;']));
path = strcat(['results/',test_name]);
save(path, test_name);


clear all;
load('data/train_54802_input.mat');
load('data/train_54802_trg_preictal.mat');
load('data/test_54802_input.mat');
load('data/test_54802_trg_preictal.mat');

test_name = 'layrec_preictal_54802';
iterations = 500;
results = {};
o_fscores = [];
fscores = [];
tr_i = train_54802_input;
tr_t = train_54802_trg_preictal;
te_i = test_54802_input;
te_t = test_54802_trg_preictal;
close all;
f = figure;
movegui(f, 'northwest');
hold on;

disp('Starting layrecnet preictal test with patient 54802');
for d = 1:5
    for i = 1:3
        delays = 1:2^d;
        layers = [i*20];
        disp(strcat(['54802 preictal D and i: ', num2str(d), ' and ',num2str(i)]))
        [se,sp,f,o_se,o_sp,o_f,threshold, name] = test_layrec(delays, layers, tr_i, tr_t, te_i, te_t,test_name, iterations);
        results.(name) = {}; 
        results.(name).se = se;
        results.(name).sp = sp;
        results.(name).f = f;
        results.(name).o_se = o_se;
        results.(name).o_sp = o_sp;
        results.(name).o_f = o_f;        
        o_fscores(length(o_fscores)+1) = o_f;
        fscores(length(fscores)+1) = f;
        stem(fscores,'b');
        stem(o_fscores,'r');
    end
end

eval(strcat([test_name,'=results;']));
path = strcat(['results/',test_name]);
save(path, test_name);
















