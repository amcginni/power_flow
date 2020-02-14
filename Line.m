classdef Line
    properties
        Resistance;
        Reactance;
        Capacity;
        Suceptance;
    end
    methods
        function obj = Line (R, X, C, B)
            obj.Resistance = R;
            obj.Reactance = X;
            obj.Capacity = C;
            obj.Suceptance = B;
        end
    end
end