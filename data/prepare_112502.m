% Script for preparing the data in 112502.mat to use with neural networks

prepared_112502  = load('112502.mat');
prepared_112502.FeatVectSel = transpose(prepared_112502.FeatVectSel);
prepared_112502.Trg = transpose(prepared_112502.Trg);
length_112502 = length(prepared_112502.FeatVectSel);
target_112502 = zeros(4,length_112502);

% Change 1:s to 3:s
for i = 1:length_112502
    if prepared_112502.Trg(i) == 1
        prepared_112502.Trg(i) = 3;
    else
        prepared_112502.Trg(i) = 1;    
    end
end

% Find pre-ictal and post-ictal states
state = 0;
for i = 1:length_112502
    trg = prepared_112502.Trg(i);
    
    % change 600 values to 2 before every seizure
    if state == 0 && trg == 3
        state = 1;
        for j = (i-600):(i-1)
            prepared_112502.Trg(j) = 2;
        end
    end
    
    % change 300 values to 4 after every seizure
    if state == 1 && trg == 1
        state = 0;
        for j = i:(i+299)
            if j <= length_112502
               prepared_112502.Trg(j) = 4;
            end
        end
    end    
end

% Create target matrix and calculate amounts of different values
for i = 1:length_112502
    trg = prepared_112502.Trg(i);
    switch trg
    case 1
        target_112502(:,i) = [1;0;0;0];
    case 2
        target_112502(:,i) = [0;1;0;0];
    case 3
        target_112502(:,i) = [0;0;1;0];
    case 4
        target_112502(:,i) = [0;0;0;1];
    end
end

prepared_112502.Trg = target_112502;

% Divide 10 seizures to training set and 4 to test set
threshold = 150000;

train_112502 = prepared_112502;
train_112502.Trg = prepared_112502.Trg(:,1:threshold);
train_112502.FeatVectSel = prepared_112502.FeatVectSel(:,1:threshold);

test_112502.Trg = prepared_112502.Trg(:,threshold:length_112502);
test_112502.FeatVectSel = prepared_112502.FeatVectSel(:,threshold:length_112502);

% From Introduction.pdf:
% Equilibrate the number
% of points of the several classes in the training set,
% but not in the testing set. This is the class balancing approach.
% For a patient, a number of interictal points at most equal to
% the sum of the points of the other classes should be chosen, for example randomly.
% This corresponds to an undersampling of the interictal phase.

% Training set contains 150000 columns
% 139701 of them are interictal columns
% 10299 of them are ictal columns
% -> we should remove 129402 (92.63%) of interictal columns

equip = [];
equip.Trg = zeros(4,1);
equip.FeatVectSel = zeros(29,1);
threshold = 0.9263;
val = 0;
count = 1;

for i = 1:length(train_112502.Trg)
    if train_112502.Trg(:,i) == [1;0;0;0]
        val = val + 0.1491;
        if val >= 1
            val = val - 1;
            equip.Trg(:,count) = train_112502.Trg(:,i);
            equip.FeatVectSel(:,count) = train_112502.FeatVectSel(:,i);
            count = count + 1;
        end
    else
        equip.Trg(:,count) = train_112502.Trg(:,i);
        equip.FeatVectSel(:,count) = train_112502.FeatVectSel(:,i);
        count = count + 1;
    end
end

train_112502 = equip

train_112502_trg = train_112502.Trg;
train_112502_trg_interictal = train_112502.Trg(1,:);
train_112502_trg_preictal = train_112502.Trg(2,:);
train_112502_trg_ictal = train_112502.Trg(3,:);
train_112502_trg_posictal = train_112502.Trg(4,:);
train_112502_input = train_112502.FeatVectSel;

test_112502_trg = test_112502.Trg;
test_112502_trg_interictal = test_112502.Trg(1,:);
test_112502_trg_preictal = test_112502.Trg(2,:);
test_112502_trg_ictal = test_112502.Trg(3,:);
test_112502_trg_posictal = test_112502.Trg(4,:);
test_112502_input = test_112502.FeatVectSel;

save('train_112502_input', 'train_112502_input');
save('test_112502_input', 'test_112502_input');

save('train_112502_trg_interictal', 'train_112502_trg_interictal');
save('train_112502_trg_preictal', 'train_112502_trg_preictal');
save('train_112502_trg_ictal', 'train_112502_trg_ictal');
save('train_112502_trg_posictal', 'train_112502_trg_posictal');

save('test_112502_trg_interictal', 'test_112502_trg_interictal');
save('test_112502_trg_preictal', 'test_112502_trg_preictal');
save('test_112502_trg_ictal', 'test_112502_trg_ictal');
save('test_112502_trg_posictal', 'test_112502_trg_posictal');
    