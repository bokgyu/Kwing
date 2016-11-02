function [ Kwing,Kwing2,Kwing3 ] = overlap( A_image,B_image,C_image )
%UNTITLED 이 함수의 요약 설명 위치
%   자세한 설명 위치


[re_height re_width] = size(B_image);



            
        
           BW_GT_r = uint8(zeros(re_height,re_width));
           BW_GT_g = uint8(zeros(re_height,re_width));
           BW_GT_b = uint8(zeros(re_height,re_width));
           
           BW_GT_r(A_image(:,:,1)==255)=1;
           BW_GT_g(A_image(:,:,2)==0)=1;
           BW_GT_b(A_image(:,:,3)==0)=1;
           
           
           BW_GT = BW_GT_r&BW_GT_g&BW_GT_b;
           
    
           
             BW_total_GT_count = sum(sum(BW_GT(:)));
           
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GT 바이너리로 바꾸고
           [Ob_l,Ob_ob] = bwlabel(B_image);
           
           [GT_L,GT_ob] = bwlabel(BW_GT);
           
           Kwing = struct('Area','면적','Perimeter','둘레','Diameter','직경','Per_Area','둘레면적비','Thickness','두께','Width','폭','Pd','패킹덴시티','Ds','방향강도','S','직진성','Length','길이','Average_intensity','평균명도','Circul','원형도','recall','recall','precision','precision');
           Kwing2 = struct('Area','면적','Perimeter','둘레','Diameter','직경','Per_Area','둘레면적비','Thickness','두께','Width','폭','Pd','패킹덴시티','Ds','방향강도','S','직진성','Length','길이','Average_intensity','평균명도','Circul','원형도','recall','recall','precision','precision','labelnumber','labelnumber');
           Kwing3 = struct('Area','면적','Perimeter','둘레','Diameter','직경','Per_Area','둘레면적비','Thickness','두께','Width','폭','Pd','패킹덴시티','Ds','방향강도','S','직진성','Length','길이','Average_intensity','평균명도','Circul','원형도','labelnumber','labelnumber');
           
         
           Temp_memory = [];
     
           
%            for GT_label_count = 1: GT_ob
%                
%                
%                
%                BW_GT = uint8(zeros(re_height,re_width));
%                BW_GT(GT_L == GT_label_count) = 1;
%             
%              
%                
%                
% %                Kwing1 = Test_value(BW_GT,BW_GT.*C_image);   % 내가 칠한 균열이고         
%                             
%            
% %                if(size(X,1)~=1)
% %                    
% %                SortX = sortrows(X,2);
% %                SortX = flipud(SortX);
% %                else
% % 
% %                SortX = X;
% %                end
% %                
% %                re_pre_max = 10;
% %                if( size(SortX,1)<10)
% %                    re_pre_max = size(SortX,1);
% %                end
%                
%                
% %                Kwing1.recall=[];
% %                Kwing1.precision=[];
%                        
%                
%                
% %                for re_pre = 1: re_pre_max
% %                    
% %                    recall = SortX(re_pre,2)/BW_GT_label_count;       
% %                   
% %                    precision = SortX(re_pre,2)/sum(sum(Ob_l==re_pre));
% %                    
% %                    Kwing1.recall(end+1)=recall;
% %                    Kwing1.precision(end+1)=precision;
% %                    
% %                end
%                
%               
%                
%                
%                
%                
%          
%                    
% %            Kwing = [Kwing Kwing1];
%            
%            end
           
           
           
           
               Y = (GT_L&B_image); % 칠한 균열 & 있는 균열
               K = B_image(Y); % 위에서 있던 것들의 라벨번호 찾기
         
               A = unique(K); %라벨번호 찾기
               
               for ZE = 1 : size(A)
               
               Temp_memory(end+1) = A(ZE);
               
               end
               
              
               
               X = [A,histc(K(:),A)];
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           CMA=0;
           
           
            for Ob_label_count = 1: Ob_ob
                
                if(find(Temp_memory==Ob_label_count))  % 조금 이라도 걸렸던 영역에 대해서 찾음
                    
                    
                      BW_GT = uint8(zeros(re_height,re_width)); 
                      BW_GT(B_image == Ob_label_count) = 1;  
                      
                      Kwing2_ = Test_value(BW_GT,BW_GT.*C_image);   % 내가 칠한 균열이고  
                      
                      Kwing2_.labelnumber = Ob_label_count;
                                     
                      
                      A= GT_L&BW_GT; % 정답 영역과 현재 라벨의 교집합.
                      A=sum(sum(A(:)));
                      
                      Kwing2_.precision = A/Kwing2_.Area;
                      
                      Kwing2_.recall = A/BW_total_GT_count;
                      
                        
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                    
                      
                      
                      
                      
                      Kwing2 = [Kwing2 Kwing2_];
                    
                elseif(CMA<50)
                    
                    
                     BW_GT = uint8(zeros(re_height,re_width));
                     BW_GT(B_image == Ob_label_count) = 1; 
                     
                      
                     Kwing3_ = Test_value(BW_GT,BW_GT.*C_image);  
                     if(Kwing3_.Area>20)
                    
                     Kwing3_.labelnumber = Ob_label_count;
                     Kwing3 = [Kwing3 Kwing3_];
                     CMA = CMA+1;
                     end
                end
                
                
                
                
                
                
            end
            
           
           
           
           
           
           
           
           
           
           
           
           
           
           
               






end

