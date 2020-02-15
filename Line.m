classdef Line
    properties
        BusFrom;
        BusTo;
        Resistance;
        Reactance;
        Capacity;
        Suceptance;
    end
    methods
        function obj = Line (From, To, R, X, C, B)
            obj.BusFrom = From;
            obj.BusTo = To;
            obj.Resistance = R;
            obj.Reactance = X;
            obj.Capacity = C;
            obj.Suceptance = B;
        end
    end
end