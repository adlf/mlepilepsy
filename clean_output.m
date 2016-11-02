function [ input ] = clean_output( input )
    for i = 1:length(input)
        c1 = input(1,i);
        c2 = input(2,i);
        c3 = input(3,i);
        c4 = input(4,i);

        if  c1 > c2 && c1 > c3 && c1 > c4
            input(:,i) = [1;0;0;0];
        end
        if c2 > c1 && c2 > c3 && c2 > c4
            input(:,i) = [0;1;0;0];
        end
        if c3 > c1 && c3 > c2 && c3 > c4
            input(:,i) = [0;0;1;0];
        end
        if c4 > c1 && c4 > c2 && c4 > c3
            input(:,i) = [0;0;0;1];
        end
        if c1 == c2 && c2 == c3 && c3 == c4
            disp('All  same!!');
            input(:,i) = [0;0;0;0];
        end
    end
end

