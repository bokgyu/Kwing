close all;
clear;

addpath('F:\�� ����\�տ�\rdir');
% load image
% [fname, path] = uigetfile('*.*', 'Open File');
% I = imread(strcat(path, fname));


Directory = dir('F:\����(����ͳ�)\���迵��(����ͳ�)');
Directory_path = 'F:\����(����ͳ�)\���迵��(����ͳ�)\';
GT_dir = dir('F:\����(����ͳ�)\GT\����GT');
GT_path = 'F:\����(����ͳ�)\GT\����GT\';
%111111111111111111111111111111111111111111111111111111111
cnt = 0;

meto1 = 1;

% for i = 4:numel(Directory);
for i = 4:5;
    
 

    Directory_path_current = strcat(Directory_path,Directory(i).name,'\'); % F:����:����ͳ�:���迵��:
    
    Directory_Image = rdir(Directory_path_current);  %���� ��ġ Ȯ���ϰ�   
    
    GT_current = strcat(GT_path,GT_dir(i-1).name,'\');
    GT_Image = rdir(GT_current);  %���� ��ġ Ȯ���ϰ�   
    
    
    
    Splitname = strsplit(Directory(i).name,'.'); % ��ü Directory�� ���� �̸� �ҷ�����
    name_dir = Splitname(1); %��ü Directory�� ������ �ٿ� �̸� ����
    
    
    
    name_dir2 = char(name_dir);
%     mkdir(fullfile('F:\����(����ͳ�)\���迵��(����ͳ�)\output\', name_dir2));  %�ƿ�ǲ���ٰ� ����.
%     name_dir2_ba = strcat('F:\����(����ͳ�)\���迵��(����ͳ�)\output\', name_dir2,'\');% �׸��� ���� 
    
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
%     Splitname = strsplit(Directory_Image(k).name,'.'); % ��ü Directory�� ���� �̸� �ҷ�����
% %     name_dir = Splitname(1); %��ü Directory�� ������ �ٿ� �̸� ����
% %     
%     
%     
%     name_dir2 = char(name_dir);
% %     Kmate = strcat('F:\����(����ͳ�)\output\',Directory(i).name,'\');
%     mkdir(fullfile(name_dir2));  %�ƿ�ǲ���ٰ� ����.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     Splitname = strsplit(Directory_Image(k).name,'\'); % ��ü Directory�� ���� �̸� �ҷ�����
%         name_dir = Splitname(5); %��ü Directory�� ������ �ٿ� �̸� ����
%         name_dir2 = char(name_dir);       
%         name_dir2_full = strcat(name_dir2_ba,name_dir2);
%         
%     mkdir(fullfile(name_dir2_full));
    
gray_path = 'F:\�����ڸ���\Ori_\';
binary_path = 'F:\�����ڸ���\Binary_\';
Color_path = 'F:\�����ڸ���\Color_\';

grayn_path = 'F:\�����ڸ���\Ori_n\';
binaryn_path = 'F:\�����ڸ���\Binary_n\';
Colorn_path = 'F:\�����ڸ���\Color_n\';
    
    

        


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

 
 

 

				
			
