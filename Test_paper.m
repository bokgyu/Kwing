I = imread('00493 17(S2).png');

[height width channel] = size(I);
gray = rgb2gray(I);

down_1_2 = imresize(gray,[height/2,width/2],'bilinear');
down_1_4 = imresize(gray,[height/4,width/4],'bilinear');
down_1_8 = imresize(gray,[height/8,width/8],'bilinear');



A = [-1,1,1,1,-1;-1,1,1,1,-1;-1,1,1,1,-1;-1,1,1,1,-1;-1,1,1,1,-1;];
% A = imresize(A,[5,5]);

se_0 = strel(A);
se_45 = strel(imrotate(A,45));
se_90 = strel(imrotate(A,90));
se_135 = strel(imrotate(A,135));

SE = [se_0 se_45 se_90 se_135];

Y = uint8(zeros(height,width,16));
Y_1 = uint8(zeros(height,width,4));
Y_2 = logical(zeros(height,width,4));
Y_3 = logical(zeros(height,width,4));
Y_4 = zeros(height,width,4);

C=1;

for z = 1:4
    
    re_height = floor(height/C);
    re_width = floor(width/C);
    C = C*2;
    
    src = imresize(gray,[re_height,re_width],'bilinear');

for i=1: 4
    for j=1:4
        
        Y(1:re_height,1:re_width,(i-1)*4+j) = imclose(imopen(src,SE(i)),SE(j));
        
        
    end
end





for i=1: re_height
    for j=1:re_width
   
        
        Y_1(i,j,z) = max(max(Y(i,j,:)),src(i,j)) - src(i,j);
        
        
        
        
    end
end

      Y_1(1:height,1:width,z) = imresize(Y_1(1:re_height,1:re_width,z),[height,width],'bilinear');
      Y_2(1:height,1:width,z) = imbinarize(Y_1(1:height,1:width,z));
      
     
      [N,Ob] = bwlabel(Y_2(:,:,z));

      stats = regionprops(Y_2(:,:,z), 'all');
      for Circul = 1 : Ob
          
      stats(Circul).circularity = (4*(pi*(stats(Circul).Area)))./((stats(Circul).Perimeter) .^2 );
      
      if(stats(Circul).circularity>0.3)
          
          N(N==Circul)=0; 
      else
            stats(Circul).circularity 
          
          
      
      end
      end
     Y_3(:,:,z) =N;
      Y_4(:,:,z) =N;
        
end








