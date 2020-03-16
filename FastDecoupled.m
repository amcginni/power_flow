classdef FastDecoupled
    %FASTDECOUPLED Perfroms the fast decoupled power flow algorithm
    %   This class constructs the B', B'', V, and Theta matrices from raw
    %   data per the algorithm perscribed in B. Stott, "Fast Decoupled
    %   Load Flow," IEEE Trans. PAS, 90(January-February 1971), pp.
    %   103-108.
    %   
    %   With B' and B'' in -B, with B the imaginary part of the admitance
    %   matrix Y, B' and B'' are constructed independently.  The algorithm 
    %   constructs B' from only the reactive components of PV and QV 
    %   busses.  B'' is constructed from the reactive components of all 
    %   elements except transformers.
    
    properties
        Data
        Bprime
        B2prime
        V
        Theta
    end
    
    methods
        function obj = FastDecoupled(data)
            %FASTDECOUPLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.Data = data
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        function B (data)
            %Y Create an admittance matrix from imported tabular data
            %   Detailed explanation goes here
            % This is mainly for checking that the number of rows in the matrix matches
            % the number of circuit elements
            dataRows = size(data);
            dataRows = dataRows(1);

            % For each element type, we create an array of classes, the length of the
            % number of elements of that type.  We also need to iterate through the
            % arrays seprately from the iterator i in the main loop.
            PowerLinesArray(1:data(1, 2)) = Line(0, 0, 0, 0, 0, 0);
            LineIterator = 1;

            TransfomerArray(1:data(1, 3)) = Transformer(0, 0, 0, 0, 0, 0, 0);
            TransformerIterator = 1;

            BusArray(1:data(1,1)) = Bus(0, 0, 0, 0, 0, 0);
            % No iterator required for busses, since bus number is specified in data

            % Initialize the admittance matrix now.  Y is an n x n matrix, n being the
            % number of busses in the system.
            Y = zeros(data(1,1));

            % Enter main loop section
            % Check that matrix length is correct, then populate objects with real data
            if dataRows - 1 == data(1, 1) + data(1, 2) + data(1, 3)
                % This loop Start iteration at second row.
                for i = 2:dataRows
                    % Line type
                    if data(i, 1) == 1
                        PowerLinesArray(LineIterator).BusFrom = data(i, 2);
                        PowerLinesArray(LineIterator).BusTo = data(i, 3);
                        PowerLinesArray(LineIterator).Resistance = data(i, 4);
                        PowerLinesArray(LineIterator).Reactance = data(i, 5);
                        PowerLinesArray(LineIterator).Capacity = data(i, 6);
                        PowerLinesArray(LineIterator).Suceptance = data(i, 7);          
            
                        % Start building admittance matrix in main loop
                        Y(PowerLinesArray(LineIterator).BusFrom, PowerLinesArray(LineIterator).BusTo) = -1/complex(PowerLinesArray(LineIterator).Resistance, PowerLinesArray(LineIterator).Reactance);
                        % Copy yjk to ykj
                        Y(PowerLinesArray(LineIterator).BusTo, PowerLinesArray(LineIterator).BusFrom) = Y(PowerLinesArray(LineIterator).BusFrom, PowerLinesArray(LineIterator).BusTo);
            
                        % Add this admittance to the bus admittance
                        Y(PowerLinesArray(LineIterator).BusFrom, PowerLinesArray(LineIterator).BusFrom) = -Y(PowerLinesArray(LineIterator).BusFrom, PowerLinesArray(LineIterator).BusTo);
            
                        % Iterate power line number index
                        LineIterator = LineIterator + 1;
                    % Transformer type
                    elseif data(i, 1) == 2
                        TransformerArray(TransformerIterator).BusFrom = data(i, 2);
                        TransformerArray(TransformerIterator).BusTo = data(i, 3);
                        TransformerArray(TransformerIterator).Resistance = data(i, 4);
                        TransformerArray(TransformerIterator).Reactance = data(i, 5);
                        TransformerArray(TransformerIterator).Capacity = data(i, 6);
                        TransformerArray(TransformerIterator).Suceptance = data(i, 7);
            
                        % Start building admittance matrix in main loop
                        Y(TransformerArray(TransformerIterator).BusFrom, TransformerArray(TransformerIterator).BusTo) = -1/complex(TransformerArray(TransformerIterator).Resistance, TransformerArray(TransformerIterator).Reactance);
                        % Copy yjk to ykj
                        Y(TransformerArray(TransformerIterator).BusTo, TransformerArray(TransformerIterator).BusFrom) = Y(TransformerArray(TransformerIterator).BusFrom, TransformerArray(TransformerIterator).BusTo);
            
                        % Add admitance to bus admittance
                        Y(TransformerArray(TransformerIterator).BusFrom, TransformerArray(TransformerIterator).BusFrom) = -Y(TransformerArray(TransformerIterator).BusFrom, TransformerArray(TransformerIterator).BusTo);
            
                        % Iterate transformer number index
                        TransformerIterator = TransformerIterator + 1;
        
                    % Bus type
                    elseif data(i, 1) == 3
                        BusArray(data(i, 2)).P_Generator = data(i, 4);
                        BusArray(data(i, 2)).Q_Generator = data(i, 5);
                        BusArray(data(i, 2)).P_Load = data(i, 6);
                        BusArray(data(i, 2)).Q_Load = data(i, 7);
                        BusArray(data(i, 2)).kV = data(i, 8);
                        BusArray(data(i, 2)).Reactance_pu = data(i, 9);
            
                        % Calculate bus admittance, and add to admittance matrix
                        BusArray(data(i, 2)).calculateAdmittance();
                        Y(data(i, 2), data(i, 2)) = Y(data(i, 2), data(i, 2)) + BusArray(data(i, 2)).Admittance;
                    else
                        fprintf("Invalid data type\n");
                    end       
                end
            else
                fprintf("Array size does not match specified number of components\n");
            end
            y = Y;
        end
    end
end

