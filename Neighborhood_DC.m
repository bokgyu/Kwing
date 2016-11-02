function [ Dc ] = Neighborhood_DC( N,Dp,height,width )
%NEIGHBORHOOD_DC �� �Լ��� ��� ���� ��ġ
% Dp = ���� �ȼ����� ��ġ
% N  = ���� ������ ������ 
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if(N==0)
    N = height-25;
    M =width-25;
    K=26;
else
    M = N;
    K=2;
end


Dp = padarray(Dp,[1 1],'both');
Dc = padarray(Dp,[1 1],'both');



for i= K: N+(K-1)
    for j=K:M+(K-1)
        
        if(Dp(i,j) == 1)
            Dc(i-1:i+1,j-1:j+1) = 1;
        end
            
            
            
        end
        
        
    end


if(K==26)
    
    Dc = Dc(2:height+1,2:width+1);
else
Dc = Dc(2:N+1,2:M+1);
end







end

