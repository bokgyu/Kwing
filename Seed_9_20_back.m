I  = imread('test1.png');
gray = rgb2gray(I);
% 
% se = strel('disk',10);
% closing = imclose(gray,se);
% gray_ori = gray;
% 
% gray = closing - gray;
% gray = 255-gray;

%  Stretching = imadjust(gray,stretchlim(gray),[]);
% G = Stretching .* gray;
% 
% bw = imbinarize(G);
% figure
% 
G = fspecial('gaussian',[3 3],0.8);
gray = imfilter(gray,G,'same');

% 
% se = strel(ones(3,3));
% gray = gray - imerode(gray, se);
% 


 


M = 3;
Weight = 0;

[height width channel] = size(I);
gray = padarray(gray,[25 25],'both');
% pad_gray = padarray(A,[25 25],'replicate','both');

Output = uint8(zeros(height+50,width+50));
F1 = zeros(height+50,width+50);
Pd1 = zeros(height+50,width+50);
Eccentricity1= zeros(height+50,width+50);

% Dp_total = zeros(M,M,height*width);

for y=27: height+24
    for x =27 : width+24
        Threshold_T = gray(y,x);
        Flag_boundray = 0;
        k_map = 0;
        
          
        
        
       for LocalWindow_size = 3 : 2 :M
           
         
        LocalWindow_for_mark = 1;
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
                
                
    
                mmin = max(max(LocalWindow.*(Dc_thresh_mark-Dp_thresh)));
   
                Dc_thresh((LocalWindow.*(Dc_thresh_mark-Dp_thresh))== mmin) = 1;
                Dp_thresh = Dc_thresh;
            else
    
            Dp_thresh = Dc_thresh;
        
            end
     

            Dp = LocalWindow.*Dp_thresh;
       
            
%% 2
            Threshold_T = Update_Threshold_seed(LocalWindow_size,Dp,Threshold_T,Weight);
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
     
     
      F =  ((4*stats.Area) / (pi*(stats.Perimeter^2)))*255;
      
      
%       Eccentricity = stats.Eccentricity;
      
%       
%       F1(y,x) = F;
%       Eccentricity1(y,x) = Eccentricity;
%             
%             Aver = sum(sum(Dp(:)));
%             
%             Aver = Aver / stats.Area;
%             
%             
%             Dp(Dp>Aver) =0;
%             
%             Dp_thresh(Dp==0) = 0;
%             
%          S = regionprops('table',Dp_thresh,'Area','EquivDiameter');
%          Area_ = S.Area;
%          Diameter = S.EquivDiameter;
%          
%          
%          
%          
%          
%          
%          
%          
%          
%          
%          
%          
%          
% 
% [height_,width_] =size(Dp_thresh);
% 
% [r,c] = find(Dp_thresh==1);
% rc = [r c];
% 
% max_distance = 0;
% 
% for lk =1 : size(r,1)
%     for ll=2:size(r,1)
%         
%         pos1 = rc(lk,:);
%         pos2 = rc(ll,:);
%         X = [pos1;pos2];
%         d = pdist(X,'euclidean');
%         
%         if(d > max_distance) 
%             max_distance = d;
%                 
%             
%         end
%         
%         
%     end
% end
%          
%          
%           Pd = (Area_) / (pi * (max_distance/2)^2);
%           PE= sprintf('Area : %d Diameter : %d d : %d Pd: %d F:%d  \n',Area_,Diameter,(pi * (max_distance/2)^2),Pd,F);
%           disp(PE);
%           if(isempty(Pd) == 1)
%               Pd = 1;
%           end
%           
%            
%           Pd1(y,x) = Pd;
%          
%        
      
  
      PE= sprintf('F: %d',F);
         disp(PE);
%      
%        if(F >180)
%            

        

          min_ = min(Dp(Dp_thresh==1));
        
               
               
          Output(y-LocalWindow_for_mark:y+LocalWindow_for_mark , x-LocalWindow_for_mark:x+LocalWindow_for_mark)=...
          (gray(y-LocalWindow_for_mark:y+LocalWindow_for_mark , x-LocalWindow_for_mark:x+LocalWindow_for_mark)) - min_;
         
      
  
       
       
       
    end
    
end
%% 
nor = mat2gray(Output);

nor = im2bw(nor,0.2);

figure,imshow(nor);












    



% 
% 
% 
% 
% 
% 
%     
% 
% bw = bwareaopen(C,Counting_threshold);
% 
% 
% 
% 
% [L,N_ob] = bwlabel(bw);


















