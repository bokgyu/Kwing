function [Rc_Mat,Rb_Mat,R_Mat] = MAking_GT(Seed_Mat,M,Weight,Rc_Mat,Rb_Mat,y,x,gray,R_Mat)
%MAKING_GT 이 함수의 요약 설명 위치
%   자세한 설명 위치

[height,width,channel] = size(gray);

[Rc_Mat Rb_Mat R_Mat] =Test_Per(M,Weight,Rc_Mat,Rb_Mat,y,x,gray,Seed_Mat,R_Mat);

while(1)
    
    
    
    Rc_Mat_boundary1 = logical(zeros(height,width));
    Rc_Mat_boundary = logical(zeros(height,width));
    Rc_Mat_boundary1 = Neighborhood_DC(0,Rc_Mat,height,width);
%     Rc_Mat_boundary1 = Neighborhood_DC_for_3(Rc_Mat,height,width,gray);
    
    
    [B,L] =bwboundaries(Rc_Mat_boundary1,'noholes');
    
    
    
    for k=1:length(B);
        
        boundary1 = B{k};
        for k1 = 1: length(boundary1(:,1));
            
            Rc_Mat_boundary(boundary1(k1,1), boundary1(k1,2)) = 1;
            
        end
    end
    
    if((Rc_Mat_boundary & Rb_Mat) == Rc_Mat_boundary)
        return
        
        
    else
        
        Rc_Mat_boundary = Rc_Mat_boundary - Rc_Mat;
        Rc_Mat_boundary = Rc_Mat_boundary - Rb_Mat;
        
        
        
        
        
        [r,c] = find(Rc_Mat_boundary == 1);
        
        if(size(r,1)==0)
            return
        end
        
        
        %                 for Z = 1: size(r,1)
        
        idx = randi([1,size(r,1)],1);
        %
        %
        y = r(idx);
        x = c(idx);
        
     
        
        
%         imshow(Rc_Mat);
        %                 end
        
        
        
        
    end
    
    
    
    
    [Rc_Mat Rb_Mat R_Mat] =Test_Per(M,Weight,Rc_Mat,Rb_Mat,y,x,gray,Seed_Mat,R_Mat);
end




end










