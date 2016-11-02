function [ Rc_Mat ] = Percolation_3( I,Seed_Mat )
%PERCOLATION 이 함수의 요약 설명 위치
%   자세한 설명 위치

gray = rgb2gray(I);


% 
se = strel('disk',10);
closing = imclose(gray,se);
gray_ori = gray;
Seed_Mat = padarray(Seed_Mat,[25 25],'both');

gray = closing - gray;
gray = 255-gray;

% gray = mat2gray(gray);
% gray = uint8(255-gray);



stats =  struct('Area','Area','Perimeter','Perimeter','Diameter','Diameter','Per_Area','Per_Area','Thickness','Thickness','Width','Width','Pd','Pd','Ds','Ds','S','S','Length','Length','Average_intensity','Average_intensity','Circul','Circul');

M = 31;
Weight = 1;

Flag = 0;
[height width channel] = size(I);

Rc_Mat = logical(zeros(height,width));
Rb_Mat = logical(zeros(height,width));

gray = padarray(gray,[25 25],'both');

Rc_Mat = padarray(Rc_Mat,[25 25],'both');
Rb_Mat = padarray(Rb_Mat,[25 25],'both');



% figure;
A = [];

Rc_Mat_boundary = logical(zeros(height+50,width+50));

% Dp_total = zeros(M,M,height*width);


for y = 26 : height+25
    for x = 26 : width +25
   
        
        
    if( Seed_Mat(y,x) == 1)
       
        
                 [Rc_Mat,Rb_Mat]=MAking_GT(Seed_Mat,M,Weight,Rc_Mat,Rb_Mat,y,x,gray);
                 
                 
    end
        
                   
            
            
            
            
     
  
    
end

 
 

end

