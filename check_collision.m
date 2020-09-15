function collision_flag=check_collision(v1_frame,v2_frame,v1_pos,v2_pos)
    BoxA = get_hitbox(v1_frame,v1_pos);
    BoxB = get_hitbox(v2_frame,v2_pos);
    CornersAx = transpose(BoxA(1,:));
    CornersAy = transpose(BoxA(2,:));
    CornersBx = transpose(BoxB(1,:));
    CornersBy = transpose(BoxB(2,:));
    
    in = inpolygon(CornersAx,CornersAy,CornersBx,CornersBy);
    
    if max(in) > 0
                collision_flag = true;
                return;
            else
                in = inpolygon(CornersBx,CornersBy,CornersAx,CornersAy);
                if max(in) > 0
                    collision_flag = true;
                    % To plot the collision scene
                    %plot(CornersAx,CornersAy,CornersBx,CornersBy)
                    return;
                else
                    collision_flag = false;
                    return;                 
                end
                
    end
end