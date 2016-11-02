image_path = 'F:\영상자료\입력영상\'
Directory = dir(image_path);
Output_path = 'F:\영상자료\실험\';
Output_histo = 'F:\영상자료\Histogram\';
% 
% % 
% % 
% 
for Image_count=3: numel(Directory)
% 
    
    
    Image_name = Directory(Image_count).name;
    Image_name1 = Image_name(1:end-4);
    
    Image_full_path = strcat(image_path,Image_name);
    
    Output_Directory = strcat(Output_path,Image_name1);
    mkdir(Output_Directory);
    
  ori_image = imread(Image_full_path);
%   ori_image = imread('TTSS.png');


 [re_height re_width re_channel] = size(ori_image);
for Weight = 0:1


Y_3 = logical(zeros(height,width,2));


  figure;

C=1;

for z =1:1
    
    re_height = floor(height/C);
    re_width = floor(width/C);
    C = C*2;
    
    I = imresize(ori_image,[re_height,re_width],'bilinear');

% I = ori_image;


   Seed_Mat=Seed_nor_1(I);


%  I = imgaussfilt(I,0.5);
gray = rgb2gray(I);     
gray = 255-gray;
average = mean(gray(:))/255;
BW = imbinarize(gray,average-0.05);
BW2 = uint8(BW);
gray= 255-gray;
BW2 = uint8(BW).*gray;
J = imadjust(BW2,stretchlim(BW2),[]);
 J(J==0) = 255;
 gray = J;
 
stats =  struct('Area','Area','Perimeter','Perimeter','Diameter','Diameter','Per_Area','Per_Area','Thickness','Thickness','Width','Width','Pd','Pd','Ds','Ds','S','S','Length','Length','Average_intensity','Average_intensity','Circul','Circul');

M = 41;
% Weight = 1;

Flag = 0;
Pad_size = floor(M/2);

Rc_Mat = logical(zeros(re_height,re_width));
Rb_Mat = logical(zeros(re_height,re_width));
Rc_Mat = zeros(re_height,re_width);
R_Mat = zeros(re_height,re_width);

gray = padarray(gray,[5 5],'replicate','both');


gray = padarray(gray,[Pad_size-5 Pad_size-5],'both');


Rc_Mat = padarray(Rc_Mat,[Pad_size Pad_size],'both');
Rb_Mat = padarray(Rb_Mat,[Pad_size Pad_size],'both');
R_Mat = padarray(R_Mat,[Pad_size Pad_size],'both');
Seed_Mat = padarray(Seed_Mat,[Pad_size Pad_size],'both');




A = [];

Rc_Mat_boundary = logical(zeros(height+Pad_size*2,width+Pad_size*2));
% A = double(imdilate(Seed_Mat,se));
% gray = uint8(A).*gray;
% % Dp_total = zeros(M,M,height*width);

for y= Pad_size+1  : re_height+ Pad_size
    for x = Pad_size+1 : re_width+Pad_size
        
        
    if( Seed_Mat(y,x) == 1&&  Rc_Mat(y,x)~=1 && Rb_Mat(y,x)~=1)
       
        
                 [Rc_Mat,Rb_Mat,R_Mat]=MAking_GT(Seed_Mat,M,Weight,Rc_Mat,Rb_Mat,y,x,gray,R_Mat);
                 
    end
        
    end
    
end

%%
% Rc_Mat = Rc_Mat(26:height+25,26:width+25);
% se = strel('disk',2);
%   [N,Ob] = bwlabel(Rc_Mat);
% 
%      stats = regionprops(N, 'all');
%       for Circul = 1 : Ob
%           
%       stats(Circul).circularity = (4*(pi*(stats(Circul).Area)))./((stats(Circul).Perimeter) .^2 );
%       
%       if(stats(Circul).circularity>0.5)
%           
%           N(N==Circul)=0; 
%       else
%             stats(Circul).circularity 
%           
%           
%       
%       end
%       end
%       
%       N = imresize(N,[height,width],'bilinear');
%      Y_3(:,:,z) =N;
   
   
   
   
   
end

% save(strcat('F:\TestPol\New Folder\ABC\W_',num2str(Weight),'_',Image_name1,'인접픽셀바꿈_그대로.mat'),'Y_3');
save(strcat('F:\영상자료\실험\R_Mat\',num2str(Weight),'_',Image_name1,'R_Mat.mat'),'R_Mat');
% imwrite(Rc_Mat,strcat(Output_Directory,'_',num2str(Weight),'.png'));
   

end

end










