function [ Dc ] = Neighborhood_DC_for_3( Dp,height,width,gray )
%NEIGHBORHOOD_DC 이 함수의 요약 설명 위치
% Dp = 현재 픽셀들의 위치
% N  = 지역 윈도우 사이즈 
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




    N = height-26;
    M =width-26;
    K=27;
DC_A = Dp;
Dp = padarray(Dp,[1 1],'both');
Dc = padarray(DC_A,[1 1],'both');



for i= K: N
    for j=K:M
       
        if(Dp(i,j) == 1)
            C = zeros(3,3);
            C(2,2) = 1;
            for z= 1:6
            
            A = gray(i-1:i+1,j-1:j+1);
            B = sort(A(:));
            C(A ==B(z))=1;
                    
          
            
            end
            
            Dc(i-1:i+1,j-1:j+1) = C;
            
        end
            
            
            
        end
        
        
    end

    Dc = Dc(2:height+1,2:width+1);


end

