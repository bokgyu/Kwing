function [Rc_Mat] = Percolation_2(I,Seed_Mat)
%PERCOLATION_2 이 함수의 요약 설명 위치
% 간단하게 작고 큰 윈도우가 계속 돌아가면서 최적의 낮은 값을 찾아냄
%

gray = rgb2gray(I);


% 
se = strel('disk',10);
closing = imclose(gray,se);
gray_ori = gray;

gray = closing - gray;
gray =  255-gray;

% gray = mat2gray(gray);
% % gray = uint8(255-gray);



stats =  struct('Area','Area','Perimeter','Perimeter','Diameter','Diameter','Per_Area','Per_Area','Thickness','Thickness','Width','Width','Pd','Pd','Ds','Ds','S','S','Length','Length','Average_intensity','Average_intensity','Circul','Circul');

M = 21;
Weight = 0;

Flag = 0;
[height width channel] = size(I);

Rc_Mat = logical(zeros(height,width));
Rb_Mat = logical(zeros(height,width));

gray = padarray(gray,[25 25],'both');
Seed_Mat = padarray(Seed_Mat,[25 25],'both');

Rc_Mat = padarray(Rc_Mat,[25 25],'both');
Rb_Mat = padarray(Rb_Mat,[25 25],'both');



% figure;
A = [];

Rc_Mat_boundary = logical(zeros(height+50,width+50));

% Dp_total = zeros(M,M,height*width);

iy = 26;



while(iy <height+25)
    ix = 26;
    while(ix<width+25)
        
        if(Flag ==0)
            x = ix;
            y = iy;
        end
        
       
        
        if(Seed_Mat(y,x) == 1 && Rc_Mat(y,x)~=1 && Rb_Mat(y,x)~=1)
            [Rc_Mat Rb_Mat ] =TestPPer(M,Weight,Rc_Mat,Rb_Mat,y,x,gray);
            
            
            
           
          
            
            if(Rc_Mat(y,x) == 1)
                %%
                Rc_Mat_boundary1 = logical(zeros(height+50,width+50));
                Rc_Mat_boundary1 = Neighborhood_DC(0,Rc_Mat,height+50,width+50);
                               
               
                [B,L] =bwboundaries(Rc_Mat_boundary1,'noholes');
                
                
                
                for k=1:length(B);
                    
                    boundary1 = B{k};
                    for k1 = 1: length(boundary1(:,1));
                        
                        Rc_Mat_boundary(boundary1(k1,1), boundary1(k1,2)) = 1;
                        
                    end
                end
                
                 if((Rc_Mat_boundary & Rb_Mat) == Rc_Mat_boundary)
                        Flag = 0;
                   
                    
                 else
                
                Rc_Mat_boundary = Rc_Mat_boundary - Rc_Mat;
                Rc_Mat_boundary = Rc_Mat_boundary - Rb_Mat;
                
                
                
                [r,c] = find(Rc_Mat_boundary == 1);
                idx = randi([1,size(r,1)],1);
                
                
                y = r(idx);
                x = c(idx);
                
                
                Flag = 1;
                 end
                
                
            end
            
        else
            Flag = 0;
            
            
            
            
            
            
            
            
        end
        
        if(Flag==0)
            ix=ix+1;
        end
        
    end
    
    
    iy = iy+1;
 
    
end



Rc_Mat = Rc_Mat(26:height+25,26:width+25);
% figure,imshow(Rc_Mat,[]);
end






