function lane_initial()
%frame and location of the whole road
    load('roads.mat','data');
    temp = data.RoadSpecifications;
    center = [(temp.Centers(1,1)+temp.Centers(2,1))/2 (temp.Centers(1,2)+temp.Centers(2,2))/2];
    angle = 0; % Vehicle orientation in rad
    a = temp.Centers(2,1)-temp.Centers(1,1);
    b = temp.Width;
    
%area of the lane far left
    center_l = center + [-sin(angle)*b/temp.Lanes.NumLanes cos(angle)*b/temp.Lanes.NumLanes];
    a_l = a;
    b_l = temp.Width/temp.Lanes.NumLanes;
    
    lane_l = get_lane_area(center_l,[a_l b_l angle]);
    
%area of the middle lane 
    center_m = center;
    a_m = a;
    b_m = temp.Width/temp.Lanes.NumLanes;
    
    lane_m = get_lane_area(center_m,[a_m b_m angle]);
    
%area of the lane far right
    center_r = center + [sin(angle)*b/temp.Lanes.NumLanes -cos(angle)*b/temp.Lanes.NumLanes];
    a_r = a;
    b_r = temp.Width/temp.Lanes.NumLanes;
    
    lane_r = get_lane_area(center_l,[a_r b_r angle]); 
    
%save 
    save('lane_area','lane_r','lane_m','lane_l');
end