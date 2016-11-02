close all;
clear;

addpath('F:\새 폴더\균열\rdir');
% load image
% [fname, path] = uigetfile('*.*', 'Open File');
% I = imread(strcat(path, fname));


Directory = dir('F:\영상(산곡터널)\실험영상(산곡터널)');
Directory_path = 'F:\영상(산곡터널)\실험영상(산곡터널)\';
GT_dir = dir('F:\영상(산곡터널)\GT\이은GT');
GT_path = 'F:\영상(산곡터널)\GT\이은GT\';
%111111111111111111111111111111111111111111111111111111111
cnt = 0;

meto1 = 1;

% for i = 4:numel(Directory);
for i = 4:5;
    
 

    Directory_path_current = strcat(Directory_path,Directory(i).name,'\'); % F:영상:산곡터널:실험영상:
    
    Directory_Image = rdir(Directory_path_current);  %파일 위치 확인하고   
    
    GT_current = strcat(GT_path,GT_dir(i-1).name,'\');
    GT_Image = rdir(GT_current);  %파일 위치 확인하고   
    
    
    
    Splitname = strsplit(Directory(i).name,'.'); % 전체 Directory의 파일 이름 불러오기
    name_dir = Splitname(1); %전체 Directory에 폴더를 붙여 이름 생성
    
    
    
    name_dir2 = char(name_dir);
%     mkdir(fullfile('F:\영상(산곡터널)\실험영상(산곡터널)\output\', name_dir2));  %아웃풋에다가 생성.
%     name_dir2_ba = strcat('F:\영상(산곡터널)\실험영상(산곡터널)\output\', name_dir2,'\');% 그림자 까지 
    
%     if(meto1 ==1)
%         meto=7;
%         meto1=0;
%     else
%         meto=1;
%     end
%     
    
    
    
    for k=1:numel(Directory_Image)

% %            
% % %     
%     Splitname = strsplit(Directory_Image(k).name,'.'); % 전체 Directory의 파일 이름 불러오기
% %     name_dir = Splitname(1); %전체 Directory에 폴더를 붙여 이름 생성
% %     
%     
%     
%     name_dir2 = char(name_dir);
% %     Kmate = strcat('F:\영상(산곡터널)\output\',Directory(i).name,'\');
%     mkdir(fullfile(name_dir2));  %아웃풋에다가 생성.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     Splitname = strsplit(Directory_Image(k).name,'\'); % 전체 Directory의 파일 이름 불러오기
%         name_dir = Splitname(5); %전체 Directory에 폴더를 붙여 이름 생성
%         name_dir2 = char(name_dir);       
%         name_dir2_full = strcat(name_dir2_ba,name_dir2);
%         
%     mkdir(fullfile(name_dir2_full));
    
gray_path = 'F:\파일자르기\Ori_\';
binary_path = 'F:\파일자르기\Binary_\';
Color_path = 'F:\파일자르기\Color_\';

grayn_path = 'F:\파일자르기\Ori_n\';
binaryn_path = 'F:\파일자르기\Binary_n\';
Colorn_path = 'F:\파일자르기\Color_n\';
    
    

        


I = imread(Directory_Image(k).name);
GT_image = imread(GT_Image(k).name);

% figure,imshowpair(GT_image,I,'montage');


            
        
           BW_GT_r = uint8(zeros(2880,2880));
           BW_GT_g = uint8(zeros(2880,2880));
           BW_GT_b = uint8(zeros(2880,2880));
           
           BW_GT_r(GT_image(:,:,1)==255)=1;
           BW_GT_g(GT_image(:,:,2)==0)=1;
           BW_GT_b(GT_image(:,:,3)==0)=1;
           
           
           BW_GT_r_2 = uint8(zeros(2880,2880));
           BW_GT_g_2 = uint8(zeros(2880,2880));
           BW_GT_b_2 = uint8(zeros(2880,2880));
           
           BW_GT_r_2(GT_image(:,:,1)==0)=1;
           BW_GT_g_2(GT_image(:,:,2)==0)=1;
           BW_GT_b_2(GT_image(:,:,3)==255)=1;
                      
           BW_GT = BW_GT_r&BW_GT_g&BW_GT_b;
           BW_GT_2 = BW_GT_r_2&BW_GT_g_2&BW_GT_b_2;

gray = rgb2gray(I);


gray_ = uint8(zeros(128,128));
Color_ = uint8(zeros(128,128,3));

binary = logical(zeros(128,128));
binary_check=logical(zeros(128,128));



for height_ = 1:40: 2720
    for width_ = 1:40: 2720
        
        binary_ = BW_GT(height_:height_+128,width_:width_+128);
        gray_ = gray(height_:height_+128,width_:width_+128);
        Color_ = I(height_:height_+128,width_:width_+128,:);
        binary_check = BW_GT_2(height_:height_+128,width_:width_+128);
        
        if(sum(sum(binary_check(:)))< 1600)
        
        if(sum(sum(binary_(:)))> 20)
     
        imwrite(gray_,strcat(gray_path,num2str(cnt),'.jpg'));
        imwrite(binary_,strcat(binary_path,num2str(cnt),'.png'));
        imwrite(Color_,strcat(Color_path,num2str(cnt),'.jpg'));
        
       
        
        else
            
     
        
        imwrite(gray_,strcat(grayn_path,num2str(cnt),'.jpg'));
        imwrite(binary_,strcat(binaryn_path,num2str(cnt),'.png'));
        imwrite(Color_,strcat(Colorn_path,num2str(cnt),'.jpg'));
            
            
            
        end
         cnt = cnt+1;
         
        
        end
        
        
        
    end
end

        








   
        
        

  end
 end

 
 

 

				
			
