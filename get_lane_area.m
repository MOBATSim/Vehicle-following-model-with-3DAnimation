function lane_area = get_lane_area(center,frame)
    a = frame(1)/2;
    b = frame(2)/2; 
    angle = frame(3);
    
    p1 =[a b];
    p2 =[a -b];
    p3 =[-a -b];
    p4 =[-a b];
    
    Rmatrix = [cos(angle) sin(angle); -sin(angle) cos(angle)];
            
    p1r = center+p1*Rmatrix;
    p2r = center+p2*Rmatrix;
    p3r = center+p3*Rmatrix;
    p4r = center+p4*Rmatrix;
            
    lane_area = [p1r' p2r' p3r' p4r'];
end