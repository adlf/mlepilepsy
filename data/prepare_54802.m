% Script for preparing the data in 54802.mat to use with neural networks

% Load data
prepared_54802  = load('54802.mat');
prepared_54802.FeatVectSel = transpose(prepared_54802.FeatVectSel);
prepared_54802.Trg = transpose(prepared_54802.Trg);
length_54802 = length(prepared_54802.FeatVectSel);
target_54802 = zeros(4,length_54802);

% Change ones to threes
for i = 1:length_54802
    if prepared_54802.Trg(i) == 1
        prepared_54802.Trg(i) = 3;
    else
        prepared_54802.Trg(i) = 1;    
    end
end

% Find preictal and posictal states
state = 0;
for i = 1:length_54802
    trg = prepared_54802.Trg(i);
    
    % change 600 values to 2 before every seizure
    if state == 0 && trg == 3
        state = 1;
        for j = (i-600):(i-1)
            prepared_54802.Trg(j) = 2;
        end
    end
    
    % change 300 values to 4 after every seizure
    if state == 1 && trg == 1
        state = 0;
        for j = i:(i+299)
            if j <= length_54802
               prepared_54802.Trg(j) = 4;
            end
        end
    end    
end

% Create target matrix and calculate amounts of different values
for i = 1:length_54802
    trg = prepared_54802.Trg(i);
    switch trg
    case 1
        target_54802(:,i) = [1;0;0;0];
    case 2
        target_54802(:,i) = [0;1;0;0];
    case 3
        target_54802(:,i) = [0;0;1;0];
    case 4
        target_54802(:,i) = [0;0;0;1];
    end
end
    
prepared_54802.Trg = target_54802;

% Divide 21 seizures to training set and 10 to test set.
threshold = 395000;

train_54802 = prepared_54802;
train_54802.Trg = prepared_54802.Trg(:,1:threshold);
train_54802.FeatVectSel = prepared_54802.FeatVectSel(:,1:threshold);

test_54802.Trg = prepared_54802.Trg(:,threshold:length_54802);
test_54802.FeatVectSel = prepared_54802.FeatVectSel(:,threshold:length_54802);

% From the introduction.pdf:
% Equilibrate the number
% of points of the several classes in the training set,
% but not in the testing set. This is the class balancing approach.
% For a patient, a number of interictal points at most equal to
% the sum of the points of the other classes should be chosen, for example randomly.
% This corresponds to an undersampling of the interictal phase.

% Training set contains 395000 columns
% 343742 of them are interictal columns
% 51258 of them are ictal columns
% -> we should remove 292484 (85.09%) of interictal columns

equip = [];
equip.Trg = zeros(4,1);
equip.FeatVectSel = zeros(29,1);
threshold = 0.1491; % 1 - 85.09%
val = 0;
count = 1;

for i = 1:length(train_54802.Trg)
    if train_54802.Trg(:,i) == [1;0;0;0]
        val = val + 0.1491;
        if val >= 1
            val = val - 1;
            equip.Trg(:,count) = train_54802.Trg(:,i);
            equip.FeatVectSel(:,count) = train_54802.FeatVectSel(:,i);
            count = count + 1;
        end
    else
        equip.Trg(:,count) = train_54802.Trg(:,i);
        equip.FeatVectSel(:,count) = train_54802.FeatVectSel(:,i);
        count = count + 1;
    end
end

train_54802 = equip

train_54802_trg = train_54802.Trg;
train_54802_trg_interictal = train_54802.Trg(1,:);
train_54802_trg_preictal = train_54802.Trg(2,:);
train_54802_trg_ictal = train_54802.Trg(3,:);
train_54802_trg_posictal = train_54802.Trg(4,:);
train_54802_input = train_54802.FeatVectSel;

test_54802_trg = test_54802.Trg;
test_54802_trg_interictal = test_54802.Trg(1,:);
test_54802_trg_preictal = test_54802.Trg(2,:);
test_54802_trg_ictal = test_54802.Trg(3,:);
test_54802_trg_posictal = test_54802.Trg(4,:);
test_54802_input = test_54802.FeatVectSel;

save('train_54802_input', 'train_54802_input');
save('test_54802_input', 'test_54802_input');

save('train_54802_trg_interictal', 'train_54802_trg_interictal');
save('train_54802_trg_preictal', 'train_54802_trg_preictal');
save('train_54802_trg_ictal', 'train_54802_trg_ictal');
save('train_54802_trg_posictal', 'train_54802_trg_posictal');

save('test_54802_trg_interictal', 'test_54802_trg_interictal');
save('test_54802_trg_preictal', 'test_54802_trg_preictal');
save('test_54802_trg_ictal', 'test_54802_trg_ictal');
save('test_54802_trg_posictal', 'test_54802_trg_posictal');