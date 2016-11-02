function [ nor ] = Seed_nor( I )
% % SEED_NOR 이 함수의 요약 설명 위치
%   자세한 설명 위치
% 
% I = imread('00493 17(S2).png');

gray = rgb2gray(I);
% gray = I;

% gray = imgaussfilt(gray,0.8);
% % % 
% se = strel(ones(3,3));
% closing = imerode(gray,se);
% gray_ori = gray;
% 
% gray = gray-closing;
% 
[height width channel] = size(gray);
% gray = gray(31:height-30,31:width-30);

  


Median_gray = zeros(height,width,1); %메디안 필터 넣을 변수
Median_gray =  medfilt2(gray,[15,15]); % 필터사이즈 11 메디안 , 필터사이즈가 작으면 균열이 검출이 잘 안됨.

Sub = Median_gray - gray; %차이
Sub = mat2gray(Sub);
 
  nor = imbinarize(Sub,0);
  
  
  nor(Sub<0.03) = 0; % 
  nor = bwareaopen(nor,200);
  nor = padarray(nor,[25 25],'both');
  







%%

% % 
% % 
% % 
% % 
% % 
% 
% M = 3;
% Weight = 0;
% 
% [height width channel] = size(I);
% gray = padarray(gray,[25 25],'both');
% % pad_gray = padarray(A,[25 25],'replicate','both');
% 
% Output = zeros(height+50,width+50);
% 
% 
% 
% 
% for y=26:height+25
%     for x =26 : width+25
%         Threshold_T = gray(y,x);
%         Flag_boundray = 0;
%         k_map = 0;
%     
%        for LocalWindow_size = 3 : 2 :M
%            
%          
%         LocalWindow_for_mark = 1;
% %% 1        
%         LocalWindow = uint8(gray(y-LocalWindow_for_mark:y+LocalWindow_for_mark , x-LocalWindow_for_mark:x+LocalWindow_for_mark)); % Create Local Window
% 
%         CenterPixel = ceil(LocalWindow_size/2); % CenterPoint of Local Window
%         
%         Dp_thresh = uint8(zeros(LocalWindow_size,LocalWindow_size));
%         
%         if( Flag_boundray==1)
%         Dp_thresh(2:size(Dp_thresh_temp,1)+1,2:size(Dp_thresh_temp,1)+1) = Dp_thresh_temp;
%         k_map = 1;
%         end
%        
% %% 3
%         Dp_thresh(  CenterPixel,  CenterPixel) = 1;
%         
%         while(true)
%                Dp_thresh(  CenterPixel,  CenterPixel) = 1;
%             Dc_thresh = Neighborhood_DC(LocalWindow_size,Dp_thresh);
%             Dc = uint8(Dc_thresh) .* LocalWindow;
% 
% 
%             Dc_thresh_mark = Dc_thresh;
%             Dc_thresh(Dc > Threshold_T) = 1; % Dc = Dp(T>Dp)
%             Dc_thresh(Dc < Threshold_T) = 0;
%             Dc_thresh(Dc == Threshold_T) =0;
%              
%             
%            
%             
%             Dc_thresh(Dc_thresh_mark ~=1) =0;
%         
%             if(isequal(Dc_thresh,Dp_thresh) == 1 || isempty(Dc_thresh)==1)
%                 
%                 if(k_map == 1 &&  Flag_boundray == 1)
%                     k_map=2;
%                      break;
%                 end
%                     A = LocalWindow;
%                 
%     
%               mmin = max(max(A((Dc_thresh_mark-Dp_thresh)==1)));
%               
%                  if(isempty(mmin)==1)
%                     mmin = max(max(A(:)));
%                   end
%    
%                 Dc_thresh((LocalWindow.*(Dc_thresh_mark-Dp_thresh))== mmin) = 1;
%                 Dp_thresh = Dc_thresh;
%             else
%     
%             Dp_thresh = Dc_thresh;
%         
%             end
%      
% 
%             Dp = LocalWindow.*Dp_thresh;
%         %% 2
%             Threshold_T = Update_Threshold_seed(LocalWindow_size,Dp_thresh.*LocalWindow,Threshold_T,Weight);
%             
% 
% %% 4        
%             Flag_boundray =Check_boundray(LocalWindow_size,Dp_thresh);
%            
%             if( Flag_boundray == 1)
%                        break;
%             end
%             
%         
%         end
%         
%         
%                 if(k_map == 2)
%                 break;
%                 end
%         
%        
%         
%         Dp_thresh_temp = Dp_thresh;
%      
%        end
%       
%        
%        
% 
% stats = regionprops('table',Dp_thresh,'Area','Perimeter','Eccentricity');
% 
% 
% 
% 
% Eccentricity = stats.Eccentricity;
% 
% 
% %     F1(y,x) = F;
% Eccentricity1(y,x) = Eccentricity;
% 
% Aver = sum(sum(Dp(:)));
% 
% Aver = Aver / stats.Area;
% 
% S = regionprops('table',Dp_thresh,'Area');
% Area_ = S.Area;
% 
% [height_,width_] =size(Dp_thresh);
% 
% [r,c] = find(Dp_thresh==1);
% rc = [r c];
% 
% if(isempty(rc) == 0)
%     
%     D = pdist2(rc,rc,'euclidean');
%     max_distance_2 = max(max(D(:)));
%     
% %     
% %     Pd = (Area_) / (pi * (max_distance_2/2)^2);
% %     %     PE= sprintf('distance 2 :  %d , distance1 : %d',max_distance_2,max_distance);
% %     %     disp(PE);
% %     if(isempty(Pd) == 1)
% %         Pd = 1;
% %     end
% %     
% %     
% %     Pd1(y,x) = Pd;
%     
% end
% 
% % Check_value=[];
% % F =  ((4*stats.Area) / (pi*(max_distance_2^2)))*255;
% 
% %    F =  (4*pi*stats.Area) / (max_distance_2^2);
% 
% %    if(F < 0.4 && Eccentricity > 0.85 && Pd < 0.2) && Pd< 0.5 && Eccentricity > 0.85
% 
% 
% 
%           min_ = max(Dp(Dp_thresh==1));
% %                    if(gray(y,x) ~= min_)
%           Output(y,x)=double(gray(y,x))- double(min_);
% %                    end
%            
%      
%     
%       x
%       y
%      
%     end
% end
% 
% 
%     
%  
% % 
% % 
% % Output = Output(27:height+24,27:width+24);
% % 
% % % [Gmag,Gdir] = imgradient(Output);
% nor = mat2gray(Output);
% nor = nor*255;
% nor = imbinarize(nor,180);
% nor = ~nor;
% % 
% % 
% % 
% % nor = padarray(nor,[26 26],'both');
% % se = strel('disk',2);
% % nor = imclose(nor,se);
% % 
% % 
% % 
% % 
% % 
% % 
% % end





% 
% 
% 
% 
% % [Gmag,Gdir] = imgradient(Output);
% se = strel(ones(3,3));
% Diliate = imdilate(gray,se);
% % figure,imshow(Diliate);
% Output = Diliate - gray;
% nor = mat2gray(Output);
% nor = nor*255;
% % nor = 255-nor;
% nor = imbinarize(nor,80);
% % nor = ~nor;
% 
% nor = padarray(nor,[25 25],'both');
% % se = strel('disk',2);
% % nor = imclose(nor,se);
