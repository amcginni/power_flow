classdef Bus
    properties
        P_Generator
        Q_Generator
        P_Load
        Q_Load
        kV
        Reactance_pu
    end
    methods
        function obj = Bus (PG, QG, PL, QL, kV, Xpu)
            obj.P_Generator = PG;
            obj.Q_Generator = QG;
            obj.P_Load = PL;
            obj.Q_Load = QL;
            obj.kV = kV;
            obj.Reactance_pu = Xpu;
        end
    end
    
end