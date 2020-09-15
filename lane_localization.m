classdef lane_localization < matlab.System
    % Untitled3 Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties

    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)
    lane_r = [1000,1000,0,0;-1.27500000000000,-3.82500000000000,-3.82500000000000,-1.27500000000000];
    lane_m = [1000,1000,0,0;1.27500000000000,-1.27500000000000,-1.27500000000000,1.27500000000000];
    lane_l = [1000,1000,0,0;3.82500000000000,1.27500000000000,1.27500000000000,3.82500000000000];
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function lane_property = stepImpl(obj,X,Y)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            if(check_lane_location(obj.lane_r,[X Y])==1)
                lane_property = 1;
            elseif(check_lane_location(obj.lane_m,[X Y])==1)
                lane_property = 2;
            elseif(check_lane_location(obj.lane_l,[X Y])==1)
                lane_property = 3;
            else 
                lane_property = 4;
            end

        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
    end
end
