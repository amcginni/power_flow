function [delta] = delta(data)
%Y Create an admittance matrix from imported tabular data
%   Detailed explanation goes here
% This is mainly for checking that the number of rows in the matrix matches
% the number of circuit elements
dataRows = size(data);
dataRows = dataRows(1);

% For each element type, we create an array of classes, the length of the
% number of elements of that type.  We also need to iterate through the
% arrays seprately from the iterator i in the main loop.

BusArray(1:data(1,1)) = Bus(0, 0, 0, 0, 0, 0);
% No iterator required for busses, since bus number is specified in data

% Initialize the admittance matrix now.  Y is an n x n matrix, n being the
% number of busses in the system.
internal_delta = zeros(data(1,1), 1);

% Enter main loop section
% Check that matrix length is correct, then populate objects with real data
if dataRows - 1 == data(1, 1) + data(1, 2) + data(1, 3)
    % This loop Start iteration at second row.
    for i = 2:dataRows        
        % Bus type
        if data(i, 1) == 3
            BusArray(data(i, 2)).P_Generator = data(i, 4);
            BusArray(data(i, 2)).Q_Generator = data(i, 5);
            BusArray(data(i, 2)).P_Load = data(i, 6);
            BusArray(data(i, 2)).Q_Load = data(i, 7);
            BusArray(data(i, 2)).kV = data(i, 8);
            BusArray(data(i, 2)).Reactance_pu = data(i, 9);
            
            % Calculate bus voltage angle delta
            BusArray(data(i, 2)).calculateDelta();
            internal_delta(data(i, 2)) = internal_delta(data(i, 2)) + BusArray(data(i, 2)).delta;
       end       
    end
end
    delta = internal_delta;
end

