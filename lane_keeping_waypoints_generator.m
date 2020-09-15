classdef lane_keeping_waypoints_generator < matlab.System
    % Untitled Add summary here
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
        
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function way_point = stepImpl(obj,pos)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            way_point = [pos+10 2.55];
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
    end
end
