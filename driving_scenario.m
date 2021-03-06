function [allData, scenario, sensor] = driving_scenario()
%roads - Returns sensor detections
%    allData = roads returns sensor detections in a structure
%    with time for an internally defined scenario and sensor suite.
%
%    [allData, scenario, sensors] = roads optionally returns
%    the drivingScenario and detection generator objects.

% Generated by MATLAB(R) 9.8 (R2020a) and Automated Driving Toolbox 3.1 (R2020a).
% Generated on: 06-Sep-2020 22:12:53

% Create the drivingScenario object and ego car
[scenario, egoVehicle] = createDrivingScenario;

% Create all the sensors
sensor = createSensor(scenario);

allData = struct('Time', {}, 'ActorPoses', {}, 'ObjectDetections', {}, 'LaneDetections', {});
% Generate the target poses of all actors relative to the ego vehicle
poses = targetPoses(egoVehicle);
time  = scenario.SimulationTime;

% Generate detections for the sensor
laneDetections = [];
[objectDetections, numObjects, isValidTime] = sensor(poses, time);
objectDetections = objectDetections(1:numObjects);

% Aggregate all detections into a structure for later use
if isValidTime
    allData(end + 1) = struct( ...
        'Time',       scenario.SimulationTime, ...
        'ActorPoses', actorPoses(scenario), ...
        'ObjectDetections', {objectDetections}, ...
        'LaneDetections',   {laneDetections});
end

% Release the sensor object so it can be used again.
release(sensor);

%%%%%%%%%%%%%%%%%%%%
% Helper functions %
%%%%%%%%%%%%%%%%%%%%

% Units used in createSensors and createDrivingScenario
% Distance/Position - meters
% Speed             - meters/second
% Angles            - degrees
% RCS Pattern       - dBsm

function sensor = createSensor(scenario)
% createSensors Returns all sensor objects to generate detections

% Assign into each sensor the physical and radar profiles for all actors
profiles = actorProfiles(scenario);
sensor = radarDetectionGenerator('SensorIndex', 1, ...
    'SensorLocation', [3.7 0], ...
    'MaxRange', 100, ...
    'ActorProfiles', profiles);

function [scenario, egoVehicle] = createDrivingScenario
% createDrivingScenario Returns the drivingScenario defined in the Designer
%get scenario data
% open_system('VehicleFollowing');
% sim('VehicleFollowing');

% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [0 0 0;
    400 0 0];
laneSpecification = lanespec(2, 'Width', 3);
road(scenario, roadCenters, 'Lanes', laneSpecification);

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [8.4 -1.6 0]);

% Add the non-ego actors
vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [74.5 -1.5 0]);

vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [122.4 -1.6 0]);

