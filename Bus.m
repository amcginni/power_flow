classdef Bus < handle
    properties
        P_Generator
        Q_Generator
        P_Load
        Q_Load
        kV
        Reactance_pu
        Admittance
        delta
    end
    methods
        % Constructor
        function obj = Bus (PG, QG, PL, QL, kV, Xpu)
            obj.P_Generator = PG;
            obj.Q_Generator = QG;
            obj.P_Load = PL;
            obj.Q_Load = QL;
            obj.kV = kV;
            obj.Reactance_pu = Xpu;
        end
        function obj = calculateAdmittance(obj)
            Vpu = sqrt((obj.Q_Load-obj.Q_Generator)/obj.Reactance_pu);
            Resistance_pu = Vpu^2/(obj.P_Load-obj.P_Generator);
            obj.Admittance = 1/complex(Resistance_pu, obj.Reactance_pu);
        end
        function obj = calculateDelta(obj)
            obj.delta = atan( ( obj.Q_Generator - obj.Q_Load) / ( obj.P_Generator - obj.P_Load) );
        end
    end
end
