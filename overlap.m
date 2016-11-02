function [ Kwing,Kwing2,Kwing3 ] = overlap( A_image,B_image,C_image )
%UNTITLED �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ


[re_height re_width] = size(B_image);



            
        
           BW_GT_r = uint8(zeros(re_height,re_width));
           BW_GT_g = uint8(zeros(re_height,re_width));
           BW_GT_b = uint8(zeros(re_height,re_width));
           
           BW_GT_r(A_image(:,:,1)==255)=1;
           BW_GT_g(A_image(:,:,2)==0)=1;
           BW_GT_b(A_image(:,:,3)==0)=1;
           
           
           BW_GT = BW_GT_r&BW_GT_g&BW_GT_b;
           
    
           
             BW_total_GT_count = sum(sum(BW_GT(:)));
           
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GT ���̳ʸ��� �ٲٰ�
           [Ob_l,Ob_ob] = bwlabel(B_image);
           
           [GT_L,GT_ob] = bwlabel(BW_GT);
           
           Kwing = struct('Area','����','Perimeter','�ѷ�','Diameter','����','Per_Area','�ѷ�������','Thickness','�β�','Width','��','Pd','��ŷ����Ƽ','Ds','���Ⱝ��','S','������','Length','����','Average_intensity','��ո�','Circul','������','recall','recall','precision','precision');
           Kwing2 = struct('Area','����','Perimeter','�ѷ�','Diameter','����','Per_Area','�ѷ�������','Thickness','�β�','Width','��','Pd','��ŷ����Ƽ','Ds','���Ⱝ��','S','������','Length','����','Average_intensity','��ո�','Circul','������','recall','recall','precision','precision','labelnumber','labelnumber');
           Kwing3 = struct('Area','����','Perimeter','�ѷ�','Diameter','����','Per_Area','�ѷ�������','Thickness','�β�','Width','��','Pd','��ŷ����Ƽ','Ds','���Ⱝ��','S','������','Length','����','Average_intensity','��ո�','Circul','������','labelnumber','labelnumber');
           
         
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
% %                Kwing1 = Test_value(BW_GT,BW_GT.*C_image);   % ���� ĥ�� �տ��̰�         
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
           
           
           
           
               Y = (GT_L&B_image); % ĥ�� �տ� & �ִ� �տ�
               K = B_image(Y); % ������ �ִ� �͵��� �󺧹�ȣ ã��
         
               A = unique(K); %�󺧹�ȣ ã��
               
               for ZE = 1 : size(A)
               
               Temp_memory(end+1) = A(ZE);
               
               end
               
              
               
               X = [A,histc(K(:),A)];
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           CMA=0;
           
           
            for Ob_label_count = 1: Ob_ob
                
                if(find(Temp_memory==Ob_label_count))  % ���� �̶� �ɷȴ� ������ ���ؼ� ã��
                    
                    
                      BW_GT = uint8(zeros(re_height,re_width)); 
                      BW_GT(B_image == Ob_label_count) = 1;  
                      
                      Kwing2_ = Test_value(BW_GT,BW_GT.*C_image);   % ���� ĥ�� �տ��̰�  
                      
                      Kwing2_.labelnumber = Ob_label_count;
                                     
                      
                      A= GT_L&BW_GT; % ���� ������ ���� ���� ������.
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

