function [Angle_Deg] = angle_graph(mark1,mark2,mark3,mark4,i,user_cent)
if mark3 == 0 && mark4 == 0
Ax1 = user_cent(i,mark1).Centroid(1);Ay1 = user_cent(i,mark1).Centroid(2);
Ax2 = user_cent(i,mark2).Centroid(1);Ay2 = user_cent(i,mark2).Centroid(2);
    if mark1 == 1 && mark2 == 2
        Bx1 = 0; By1 = 0; Bx2 = 30; By2 = 0;
    end
    if mark1 == 4 && mark2 == 5
        Bx1 = 0; By1 = 0; Bx2 = 0; By2 = 30;
    end
else
Ax1 = user_cent(i,mark1).Centroid(1);Ay1 = user_cent(i,mark1).Centroid(2);
Ax2 = user_cent(i,mark2).Centroid(1);Ay2 = user_cent(i,mark2).Centroid(2);
Bx1 = user_cent(i,mark3).Centroid(1);By1 = user_cent(i,mark3).Centroid(2); 
Bx2 = user_cent(i,mark4).Centroid(1);By2 = user_cent(i,mark4).Centroid(2);
end
Ax = Ax2 - Ax1; Ay = Ay2 - Ay1; Bx = Bx2 - Bx1; By = By2 - By1;
cos_A = (Ax*Bx + Ay*By)/(sqrt(Ax^2+Ay^2)*(sqrt(Bx^2+By^2)));
Angle_Deg = acosd(cos_A);