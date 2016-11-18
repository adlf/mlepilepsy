function [ sensitivity, specificity, F, true_positives, true_negatives, false_positives, false_negatives] = calculate_performance( input, target )
    
    % True positive: Seizures correctly identified as seizures
    % False positive: interictal states incorrectly identified as seizures
    % True negative: Interictal states correctly identified as interictal
    % False negative: Seizures people incorrectly identified as interictal
    % states

    true_positives = 0;
    true_negatives = 0;
    false_positives = 0;
    false_negatives = 0;
    
    for i = 1:length(input)
        
        inp = input(i);
        trg = target(i);
        
        if inp == trg && trg == 1
            true_positives = true_positives + 1;
        end
        
        if inp == trg && trg == 0
            true_negatives = true_negatives + 1;
        end
        
        if inp ~= trg && trg == 0
            false_positives = false_positives + 1;
        end
        
        if inp ~= trg && trg == 1
            false_negatives = false_negatives + 1;
        end
    end

    % Sensitivity, the true positive rate, the recall, or probability of detection
    sensitivity = true_positives / (true_positives + false_negatives);
    
    % Specificity, the true negative rate
    specificity = true_negatives / (true_negatives + false_positives);

    % F-score reaches its best value at 1 and worst at 0.
    F = 2 * sensitivity * specificity / (sensitivity + specificity);
end

