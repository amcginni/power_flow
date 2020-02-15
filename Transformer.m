classdef Transformer < Line
    properties
        Tap
    end
    methods
        function obj = Transformer (From, To, R, X, C, B, T)
            obj@Line(From, To, R, X, C, B);
            obj.Resistance = R;
            obj.Reactance = X;
            obj.Capacity = C;
            obj.Suceptance = B;
            obj.Tap = T;
        end
    end
end