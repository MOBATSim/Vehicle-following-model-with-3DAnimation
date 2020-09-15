function Hitbox = get_hitbox(v_frame,v_pos)
    centerP = [v_pos(1);v_pos(2)];
    angle = v_pos(3); % Vehicle orientation in rad
    a = v_frame(1)/2;
    b = v_frame(2)/2;
            
    p1 =[a; b];
    p2 =[a; -b];
    p3 =[-a; -b];
    p4 =[-a; b];
            
    Rmatrix = [cos(angle) -sin(angle); sin(angle) cos(angle)];
            
    p1r = centerP+Rmatrix*p1;
    p2r = centerP+Rmatrix*p2;
    p3r = centerP+Rmatrix*p3;
    p4r = centerP+Rmatrix*p4;
            
    Hitbox = [p1r p2r p3r p4r];
end