function [ Rc_Mat,Rb_Mat ] = TestSeed( M,Weight,Rc_Mat,Rb_Mat,y,x,gray)
%TESTSEED 이 함수의 요약 설명 위치
%   자세한 설명 위치

    Threshold_T = gray(y,x);
    Flag_boundray = 0;
    k_map = 0;




    for LocalWindow_size = 3 : 2 :M


        LocalWindow_for_mark = floor(LocalWindow_size/2);
        %% 1
        LocalWindow = uint8(gray(y-LocalWindow_for_mark:y+LocalWindow_for_mark , x-LocalWindow_for_mark:x+LocalWindow_for_mark)); % Create Local Window

        CenterPixel = ceil(LocalWindow_size/2); % CenterPoint of Local Window

        Dp_thresh = uint8(zeros(LocalWindow_size,LocalWindow_size));

        if( Flag_boundray==1)
            Dp_thresh(2:size(Dp_thresh_temp,1)+1,2:size(Dp_thresh_temp,1)+1) = Dp_thresh_temp;
            k_map = 1;
        end

        %% 3
        Dp_thresh(CenterPixel,CenterPixel) = 1;

        while(true)

            Dc_thresh = Neighborhood_DC(LocalWindow_size,Dp_thresh);
            Dc = uint8(Dc_thresh) .* LocalWindow;


            Dc_thresh_mark = Dc_thresh;
            Dc_thresh(Dc >= Threshold_T) = 1; % Dc = Dp(T>Dp)
            Dc_thresh(Dc < Threshold_T) = 0;
            Dc_thresh(Dc_thresh_mark ~=1) =0;

            if(isequal(Dc_thresh,Dp_thresh) == 1)

                if(k_map == 1 &&  Flag_boundray == 1)
                    k_map=2;
                    break;
                end



                mmin = min(min(LocalWindow.*Dc_thresh));

                Dc_thresh((LocalWindow.*Dc_thresh)== mmin) = 1;
                Dp_thresh = Dc_thresh;
            else

                Dp_thresh = Dc_thresh;

            end


            Dp = LocalWindow.*Dp_thresh;


            %% 2
            Threshold_T = Update_Threshold(LocalWindow_size,Dp,Threshold_T,Weight);
            %% 4
            Flag_boundray =Check_boundray(LocalWindow_size,Dp_thresh);

            if( Flag_boundray == 1)
                break;
            end


        end


        if(k_map == 2)
            break;
        end



        Dp_thresh_temp = Dp_thresh;






    end



    stats = regionprops('table',Dp_thresh,'Area','Perimeter','Eccentricity','EquivDiameter');


    F =  (4*pi*stats.Area) / (stats.Perimeter^2);
    Eccentricity = stats.Eccentricity;


    F1(y,x) = F;
    Eccentricity1(y,x) = Eccentricity;

    Aver = sum(sum(Dp(:)));

    Aver = Aver / stats.Area;


    Dp(Dp>Aver) =0;

    Dp_thresh(Dp==0) = 0;

    S = regionprops('table',Dp_thresh,'Area','EquivDiameter');
    Area_ = S.Area;
    Diameter = S.EquivDiameter;





% 
% 
% 
% 
% 
% 
% 
% 
% 
%     [height_,width_] =size(Dp_thresh);
% 
%     [r,c] = find(Dp_thresh==1);
%     rc = [r c];
% 
%     max_distance = 0;
% 
%     for lk =1 : size(r,1)
%         for ll=lk:size(r,1)
% 
%             pos1 = rc(lk,:);
%             pos2 = rc(ll,:);
%             X = [pos1;pos2];
%             d = pdist(X,'euclidean');
% 
%             if(d > max_distance)
%                 max_distance = d;
% 
% 
%             end
% 
% 
%         end
%     end
% 
% 
%     Pd = (Area_) / (pi * (max_distance/2)^2);
%     PE= sprintf('Area : %d Diameter : %d d : %d Pd: %d  \n',Area_,Diameter,(pi * (max_distance/2)^2),Pd);
%     disp(PE);
%     if(isempty(Pd) == 1)
%         Pd = 1;
%     end
% 
% 
%     Pd1(y,x) = Pd;
% 





    if(F < 0.4 )

%     if(F < 0.4 && Eccentricity > 0.85 && isempty(Area_)~=1 && Pd <= 0.2)

        Rc_Mat(y,x) = 1;
        figure,imshow(Dp_thresh,[]);
        
    else
        Rb_Mat(y,x) = 1;


    end








 end











