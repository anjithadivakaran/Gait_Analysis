function [angle, user_cent] = main_f(handles,video,frameNo)

max_Frame = floor(video.Duration) * video.FrameRate - 1;
axes(handles.axes1);
for i = 1:350%350%571%max_Frame
 frameNo = frameNo + 1;   
    [Center, BC] = obj_count(video, frameNo);
    while BC ~= 5
         frameNo = frameNo + 1;
         [Center, BC] = obj_count(video, frameNo);
         if frameNo > max_Frame
              break;
         end       
    end
    if frameNo > max_Frame
         break;
    end  
    
    for s = 1:5
        switch s
         case 1                 
            for p = 1:5
                YTop(p) = Center(p).Centroid(2);
            end
            [yMin, yMin_Ind] = min(YTop(:));
            user_cent(i,s).Centroid = Center(yMin_Ind).Centroid;
            Center(yMin_Ind).Centroid(1) = NaN;                                                      
         otherwise                                                    
            [min_bliz, min_bliz_ind] = bliz_k_predf(s, Center, i, user_cent);
            user_cent(i,s).Centroid = Center(min_bliz_ind).Centroid;
            Center(min_bliz_ind).Centroid(1) = NaN;
        end
    end
    
    user_cent(i,6).Centroid = frameNo;
    insert_line(handles, user_cent, video, frameNo, i);
    
    for z = 1:4
        switch z
            case 1
                mark1=1; mark2=2; mark3=0; mark4 = 0; 
            case 2
                mark1=2; mark2=1; mark3=2; mark4 = 3;
            case 3
                mark1=3; mark2=2; mark3=4; mark4 = 5;
            case 4
                mark1=4; mark2=5; mark3=0; mark4 = 0;
        end
        angle(i,z) = angle_graph(mark1,mark2,mark3,mark4,i,user_cent);
    end
    angle(i,5) = frameNo; 
end

angle(:,1) =  90 - angle(:,1); 
angle(:,2) =  180 - angle(:,2); 
angle(:,3) =  90 - angle(:,3);
assignin('base', 'user_cent', user_cent);
assignin('base', 'angle', angle);