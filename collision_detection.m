classdef collision_detection < matlab.System
    % untitled Add summary here
    %This function detects rear-end collision, if collides, stop simulation
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties

    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = public)
        %vehicle frame in meter [length width]
        v1_frame = [4 2];
        v2_frame = [4 2];
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
           
        end

        function collision_flag = stepImpl(obj,v1_pos,v2_pos)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            distance = sqrt((v1_pos(1,1)-v2_pos(1,1))^2+(v1_pos(2,1)-v2_pos(2,1))^2);
            if(distance<20)
                collision_flag = check_collision(obj.v1_frame,obj.v2_frame,v1_pos,v2_pos)
            else
                collision_flag = false;
                return;
            end
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
    end
end
