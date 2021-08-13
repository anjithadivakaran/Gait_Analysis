function step_loop(handles,angle,g,user_cent)
% angle = load('matlab_angle_4(adobe29,29).mat');
% angle = angle.angle;
Coeff_filt = load('Coeff_filt1.mat');
b = Coeff_filt.Coeff_filt;


for i = 1:length(user_cent)
    top_x(i) = user_cent(i,1).Centroid(1);
end

d_top_x = abs(diff(top_x));

assignin('base','top_x',top_x);
k = 1;
for i = 1:length(d_top_x)
    if d_top_x(i) > 200
        d(k) = i;
      switch k
          case 1
              for p = 1:4
                part_angle(p).(string('n'+string(k)))(1:d(1)) = ...
                    filtfilt(b,1,angle(1:d(k),p));
              end
              k = k + 1;
          otherwise
              for p = 1:3
                part_angle(p).(string('n'+string(k)))(1:(d(k)-d(k-1))) = ...
                    filtfilt(b,1,angle(d(k-1)+1:d(k),p));
              end
               k = k + 1;
      end
    end
    
    if i == length(d_top_x)
        if k == 1
            d(k) = i;
            for p = 1:4
               part_angle(p).(string('n'+string(k)))(:) = ...
                    filtfilt(b,1,angle(:,p));
            end
        else
            for p = 1:4
               part_angle(p).(string('n'+string(k)))(1:(i-d(k-1))) = ...
                    filtfilt(b,1,angle(d(k-1)+1:i,p));
            end
        end
    end
end

nom = 1;
for i = 1:length(fieldnames(part_angle))
        y = part_angle(4).(string('n'+string(i)));
        TF = islocalmax(y);
        I = find(TF);
            
        if length(I) >= 2
              for t = 1:length(I)-1
                  for p = 1:4    
                  part_angle2(p).(string('n'+string(nom)))(:) = ...
                      part_angle(p).(string('n'+string(i)))(I(t):I(t+1));
                  end
                  nom = nom + 1;
              end
        end 
end

for p  = 1:3
        for i = 1:length(fieldnames(part_angle2))
            p_a_y = part_angle2(p).(string('n'+string(i)))(:);
            shag = 100/length(p_a_y);
            p_a_x = 1*shag:1*shag:100;
            p_a_xx = (1:1:100);
            p_a_yy = spline(p_a_x, p_a_y, p_a_xx);
            s_l(i,:,p) = p_a_yy; 
        end
        
        Size = size(s_l);

     
        sr(p,:) = mean(s_l(:,:,p));
        sko(p,:) = std(s_l(:,:,p));
        sko_verh(p,:) =  sr(p,:) + sko(p,:)/2;
        sko_niz(p,:) = sr(p,:) - sko(p,:)/2;
        
        x = 1 : 100;
        curve1 = sko_verh(p,:);
        curve2 = sko_niz(p,:);
        x2 = [x, fliplr(x)];
        inBetween = [curve1, fliplr(curve2)];
        
        
        switch p
            case 1
                if g == 1
                    axes(handles.axes2);
                end
                for j = 1:Size(1)
                    plot(s_l(j,:,p));
                    xlabel('Frame Number');
                    ylabel('Angle Degree');
                    hold on
                end
                    grid on
            case 2
                if g == 1
                    axes(handles.axes3);
                end
                for j = 1:Size(1)
                    plot(s_l(j,:,p));
                    xlabel('Frame Number');
                    ylabel('Angle Degree');
                    hold on                    
                end
                    grid on                
            case 3
                if g == 1
                    axes(handles.axes4);
                end
                for j = 1:Size(1)
                    plot(s_l(j,:,p));
                    xlabel('Frame Number');
                    ylabel('Angle Degree');
                    hold on
                end
                    grid on
        end
        
        switch p
            case 1
                axes(handles.axes8);
                fill(x2, inBetween, 'black','edgecolor','none','facealpha', '0.2')
                hold on   
                plot(sr(p,:), 'linewidth', 1.5, 'color', 'blue');
                xlabel('Frame Number');
                ylabel('Angle Degree');
                grid on
            case 2
                axes(handles.axes9);                
                fill(x2, inBetween, 'black','edgecolor','none','facealpha', '0.2')
                hold on   
                plot(sr(p,:), 'linewidth', 1.5, 'color', 'blue');
                xlabel('Frame Number');
                ylabel('Angle Degree');
                grid on
            case 3
                axes(handles.axes10);
                fill(x2, inBetween, 'black','edgecolor','none','facealpha', '0.2')
                hold on   
                plot(sr(p,:), 'linewidth', 1.5, 'color', 'blue');
                xlabel('Frame Number');
                ylabel('Angle Degree');
                grid on
        end
end
assignin('base', 'part_angle', part_angle);
assignin('base', 'part_angle2', part_angle2);



  