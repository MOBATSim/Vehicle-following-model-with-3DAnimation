function [scenario, egoVehicle] = createDrivingScenario()
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Generated by MATLAB(R) 9.8 (R2020a) and Automated Driving Toolbox 3.1 (R2020a).
% Generated on: 07-Sep-2020 22:06:04

%get scenario data
load_system('ScenarioAnimation');
t = get_param('ScenarioAnimation','StopTime');
model_name = 'VehicleFollowing';
load_system(model_name);
set_param(model_name,'StopTime',t);
sim(model_name);
data = ans;
% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [0 0 0;
    1000 0 0];
laneSpecification = lanespec(3, 'Width', 2.5);
road(scenario, roadCenters, 'Lanes', laneSpecification);

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [str2double(get_param(append(model_name,'/Vehicle Model 3 - PID'),'X_init')) str2double(get_param(append(model_name,'/Vehicle Model 3 - PID'),'Y_init')) 0]);
    waypoints = [data.ego_info.InertFrm.Cg.Disp.X.Data data.ego_info.InertFrm.Cg.Disp.Y.Data data.ego_info.InertFrm.Cg.Disp.Z.Data];
    speed = sqrt(data.ego_info.InertFrm.Cg.Vel.Xdot.Data.^2+data.ego_info.InertFrm.Cg.Vel.Ydot.Data.^2);
    trajectory(egoVehicle, waypoints, speed);
% Add the non-ego actors
car1 = vehicle(scenario, ...
    'ClassID', 2, ...
    'Position', [str2double(get_param(append(model_name,'/Vehicle Model 1 - Manual'),'X_init')) str2double(get_param(append(model_name,'/Vehicle Model 1 - Manual'),'Y_init')) 0]);
    waypoints = [data.v1_info.InertFrm.Cg.Disp.X.Data data.v1_info.InertFrm.Cg.Disp.Y.Data data.v1_info.InertFrm.Cg.Disp.Z.Data];
    speed = sqrt(data.v1_info.InertFrm.Cg.Vel.Xdot.Data.^2+data.v1_info.InertFrm.Cg.Vel.Ydot.Data.^2);
    trajectory(car1, waypoints, speed);
car2 = vehicle(scenario, ...
    'ClassID', 3, ...
    'Position', [str2double(get_param(append(model_name,'/Vehicle Model 2 - MPC'),'X_init')) str2double(get_param(append(model_name,'/Vehicle Model 2 - MPC'),'Y_init')) 0]);
    waypoints = [data.v2_info.X.Data data.v2_info.Y.Data data.v2_info.Z.Data];
    speed = sqrt(data.v2_info.xdot.Data.^2+data.v2_info.ydot.Data.^2);
    trajectory(car2, waypoints, speed);
