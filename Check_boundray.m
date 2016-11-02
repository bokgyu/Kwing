function [ Flag ] = Check_boundray( N,Dp_Thresh )
%CHECK_BOUNDRAY 이 함수의 요약 설명 위치
%   자세한 설명 위치


Flag = 0;


    
    for j=1:N
        
        if( Dp_Thresh(j,1) == 1 || Dp_Thresh(1,j) == 1 || Dp_Thresh(j,N) == 1 || Dp_Thresh(N,j)==1)
            
            Flag = 1;
        end
        
        

    end



end

