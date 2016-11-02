

Directory_path = 'C:\Users\gnoses\Desktop\잘림\';
Directory = dir(Directory_path);

Output_path = 'F:\영상(산곡터널)\GT\GT_Output\'

Ori_Directory_path = 'C:\Users\gnoses\Desktop\잘라낸\'
Ori_Directory = dir(Ori_Directory_path);
for Directory_count = 3: 4
% for Directory_count = 3: numel(Directory)
    
    Category_path = strcat(Directory_path,Directory(Directory_count).name,'\');
    Ori_Category_path = strcat(Ori_Directory_path,Directory(Directory_count).name,'\');
    Output_path_Category = strcat(Output_path,Directory(Directory_count).name,'\')
    mkdir(Output_path_Category);
    Category = dir(Category_path);
    
    
    
    for Category_count =12: numel(Category)
        
        Image_path = strcat(Category_path,Category(Category_count).name);
        Ori_path  =strcat(Ori_Category_path,Category(Category_count).name);
        Output_path_Image = strcat(Output_path_Category,Category(Category_count).name,'\');
%         mkdir(Output_path_Image);
        
        I = imread(Image_path);
        Ori = imread(Ori_path);
        
        
        
        
        
        
        
        
        
        [height,width,channel] = size(I);
        
        R = I(:,:,1);
        G = I(:,:,2);
        B = I(:,:,3);
        
        K = logical(zeros(height,width));
        
        
        for i=1: height
            for j=1:width
                
                if(R(i,j) >=70 && G(i,j) < 50 && B(i,j)<50)
                    K(i,j) =1;
                else
                    K(i,j)=0;
                end
                
            end
        end
        
        K1= bwareaopen(K,15);
        
        figure,imshow(K1);
        
        for i=1: height
            for j=1:width
                
                if(K1(i,j)==1)
                    I(i,j,1) = 255;
                    I(i,j,2:3) = 0;
                elseif(I(i,j,3)==255 && I(i,j,2)==0)
                    I(i,j,:) = I(i,j,:);     
                else
                    I(i,j,:) = Ori(i,j,:);
                                                 
                end
                
                
            end
        end
        
    for i=1: height
            for j=1:width
                
                if(B(i,j) ==255 && G(i,j) ==0 && R(i,j)==0)
                    I(i,j,:) = Ori(i,j,:);
                end
                
            end
        end







        imwrite(I,strcat('C:\Users\gnoses\Desktop\새 폴더\',Category(Category_count).name));
%         imwrite(I,strcat('F:\영상(산곡터널)\GT\GT_Output\그림자\GT\',Category(Category_count).name));
        
        
        
        
        
        
        
        
    end
    
end






