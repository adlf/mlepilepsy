function [ sensitivity, specificity, F, true_positives, true_negatives, false_positives, false_negatives, found_true_seizures, found_false_seizures, not_found_seizures] = calculate_performance( input, target )
    
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
    
    
    

    simplified = input;
    found_true_seizures = input;
    found_false_seizures = input;
    not_found_seizures = input;
    
    one_count = 0;
    
    for i = 1:length(simplified)
        val = simplified(i);
        if val == 1
            one_count = one_count + 1;
        else
            if one_count > 0 && one_count < 10
                for k = (i-one_count):i
                    simplified(k) = 0;
                end
            end
            one_count = 0;
        end
    end

    
    for i = 1:length(simplified)
        val = simplified(i);
        trg = target(i);
        
        found_true_seizures(i) = 0;
        found_false_seizures(i) = 0;
        not_found_seizures(i) = 0;
            
        if val == 1 && trg == 1
            found_true_seizures(i) = 1;
        elseif val == 1 && trg == 0
            found_false_seizures(i) = 1;
        elseif val == 0 && trg == 1
            not_found_seizures(i) = 1;
        end
        
    end
    



end

