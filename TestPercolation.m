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
% % for Weight = 1


% Y_3 = logical(zeros(height,width,2));


%   figure;

% C=1;
% 
% for z =1:1
%     
%     re_height = floor(height/C);
%     re_width = floor(width/C);
%     C = C*2;
%     
%     I = imresize(ori_image,[re_height,re_width],'bilinear');

I = ori_image;


   Seed_Mat=Seed_nor(I);
   imwrite(Seed_Mat,strcat(Output_Directory,'_','.png'));



gray = rgb2gray(I);     

 
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


for y= Pad_size+1  : re_height+ Pad_size
    for x = Pad_size+1 : re_width+Pad_size
        
        
    if( Seed_Mat(y,x) == 1&&  Rc_Mat(y,x)~=1 && Rb_Mat(y,x)~=1)
       
        
                 [Rc_Mat,Rb_Mat,R_Mat]=MAking_GT(Seed_Mat,M,Weight,Rc_Mat,Rb_Mat,y,x,gray,R_Mat);
                 
    end
        
    end
    
end
   
   
   
   


% save(strcat('F:\TestPol\New Folder\ABC\W_',num2str(Weight),'_',Image_name1,'인접픽셀바꿈_그대로.mat'),'Y_3');
% save(strcat(Output_Directory,num2str(Weight),'_',Image_name1,'R_Mat.mat'),'R_Mat');
imwrite(Rc_Mat,strcat(Output_Directory,'_',num2str(Weight),'.png'));
   
end








