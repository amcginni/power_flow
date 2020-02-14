

close all;
       
data = readmatrix();

% Check that matrix length is correct
if height(data) - 1 == data(1, 1) + data(1, 2) + data(1, 3)
    % This loop Start iteration at second row.
    for i = 2:height(data)
        
        % Line type
        if data(i, 1) == 1
            %dostuff()
        end
        
        % Transformer type
        if data(i, 1) == 2
            %dostuff()
        end
        
        % Bus type
        if data(i, 1) == 3
            %dostuff
        end
    end
end
