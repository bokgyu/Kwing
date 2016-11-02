function [ Rc_Mat,Rb_Mat ] = TestPPer( M,Weight,Rc_Mat,Rb_Mat,y,x,gray)
%TESTPPER 이 함수의 요약 설명 위치
%   자세한 설명 위치




A = [];
Threshold_T = gray(y,x);
Flag_boundray = 0;
k_map = 0;




for LocalWindow_size = 21 : 2 :M
    
    
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
        
        
        %             if(isequal(Dc_thresh_mark1,Dc_thresh_mark)==1)
        %                 BB = 1;
        %
        %             end
        
        Dc_thresh_mark = Dc_thresh;
        Dc_thresh(Dc <= Threshold_T) = 1; % Dc = Dp(T>Dp)
        Dc_thresh(Dc > Threshold_T) = 0;
        Dc_thresh(Dc_thresh_mark == 0) =0;
        
        if(isequal(Dc_thresh,Dp_thresh) == 1)
            
            if(k_map == 1 &&  Flag_boundray == 1) %  Kmap?
                k_map=2;
                break;
            end
            
            A = LocalWindow;
            
            A = A.*Dc_thresh;
            
            
            mmin = min(min(A(Dc_thresh_mark-Dp_thresh==1)));
            
            Dc_thresh((LocalWindow.*(Dc_thresh_mark-Dp_thresh))== mmin) = 1;
            Dp_thresh = Dc_thresh; % 최소값 = Dp
        else
            
            Dp_thresh = Dc_thresh; 
            
        end
        
        
        Dp = LocalWindow.*Dp_thresh;
        
        
        %% 2
        Threshold_T = Update_Threshold(LocalWindow_size,Dp,Threshold_T,Weight);
        %% 4
        Flag_boundray =Check_boundray(LocalWindow_size,Dp_thresh);  % 바운더리에 다 갔는가?
        
        if( Flag_boundray == 1) % 바운더리에 다 갔다면 종료 (while)
            break;
        end
        
        
    end
    
    
    if(k_map == 2)
        break;
    end
    
    
    
    Dp_thresh_temp = Dp_thresh; 
    
    
end



stats = regionprops('table',Dp_thresh,'Area','Perimeter','Eccentricity');




Eccentricity = stats.Eccentricity;


%     F1(y,x) = F;
Eccentricity1(y,x) = Eccentricity;

Aver = sum(sum(Dp(:)));

Aver = Aver / stats.Area;

S = regionprops('table',Dp_thresh,'Area');
Area_ = S.Area;

[height_,width_] =size(Dp_thresh);

[r,c] = find(Dp_thresh==1);
rc = [r c];

if(isempty(rc) == 0)
    
    D = pdist2(rc,rc,'euclidean');
    max_distance_2 = max(max(D(:)));
    
    
    Pd = (Area_) / (pi * (max_distance_2/2)^2);
    %     PE= sprintf('distance 2 :  %d , distance1 : %d',max_distance_2,max_distance);
    %     disp(PE);
    if(isempty(Pd) == 1)
        Pd = 1;
    end
    
    
    Pd1(y,x) = Pd;
    
end

Check_value=[];
F =  ((4*stats.Area) / (pi*(max_distance_2^2)))*255;

%    F =  (4*pi*stats.Area) / (max_distance_2^2);

%    if(F < 0.4 && Eccentricity > 0.85 && Pd < 0.2) && Pd< 0.5 && Eccentricity > 0.85


%   imshow(Dp_thresh,[]);

disp(sprintf('F:%f Pd%f',F,Pd));


if(F < 70 && Pd<=0.3 )
    
    Rc_Mat(y-LocalWindow_for_mark:y+LocalWindow_for_mark , x-LocalWindow_for_mark:x+LocalWindow_for_mark)=Rc_Mat(y-LocalWindow_for_mark:y+LocalWindow_for_mark , x-LocalWindow_for_mark:x+LocalWindow_for_mark)| Dp_thresh;
    %        Rc_Mat(y,x)=1;
   
%     Check_value = Test_value(Dp_thresh,Dp_thresh.*LocalWindow);
    
    
    
    
    %       imshow(Dp_thresh,[]);
    %       pause(0.01);
    
else
    Rb_Mat(y,x) = 1;
    
    
end








end












