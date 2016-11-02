    function [ stats ] = Test_value( gray,gray_value )
    %TEST_VALUE 이 함수의 요약 설명 위치
    %   자세한 설명 위치









    
    bw = imbinarize(gray,0);
    bw = imfill(bw,'holes');

    

    [height,width,channel] = size(bw);
    
    stats = regionprops('table',bw,'Area');
    Area_ = stats.Area;




     Average_intensity = (sum(sum(gray_value(:)))) / Area_;




    boundary  = zeros(height,width);





    [Blob,L] = bwboundaries(bw,'noholes');
    %% boundary 생성
    for k = 1:length(Blob)
       boundary1 = Blob{k};
       for k1 = 1: length(boundary1(:,1));

       boundary(boundary1(k1,1), boundary1(k1,2)) = 1;

       end
    end

    A  = zeros(7,7);
    B  = zeros(7,7);
    C  = zeros(7,7);
    D  = zeros(7,7);



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ABCD생성


    for i = 1: 7

        A(i,7) = 7-i;
        A(7,i) = 7-i;

    end

    for i = 1 : 7
        for j = 1 : 7


            A(i,j) = sqrt((A(7,j)^2) + (A(i,7)^2));

        end
    end


    B = fliplr(A);
    C = flipud(A);
    D = flipud(B);
    
    se = strel('disk',1);
   



    bw_thin = bwmorph(bw,'skel',Inf);
    Pad_bw = padarray(bw_thin,[3 3]);
    Pad_boundary  = padarray(boundary,[3 3]);


    stats = regionprops('table',bw_thin,'Area','Perimeter','EquivDiameter','centroid');
    
    




    % figure,imshow(bw);















    [height,width] =size(bw_thin);




     numwhite2 = regionprops(bw_thin,'BoundingBox');
     numsize = size(numwhite2);

     X1 = 999999;
     Y1= 999999;
     X2 = 0;
     Y2 = 0;
     if(numsize(1)>1)

         for numwhite_size = 1:numsize(1)





     X3 = ceil(numwhite2(numwhite_size).BoundingBox(1));
     X4 = X3+numwhite2(numwhite_size).BoundingBox(3)-1;
     Y3 = ceil(numwhite2(numwhite_size).BoundingBox(2));
     Y4 = Y3+numwhite2(numwhite_size).BoundingBox(4)-1;

     if(X1 > X3)
         X1 = X3;
     end

     if(X4 > X2)
         X2 = X4;
     end


     if(Y3 < Y1)
         Y1 = Y3;
     end

     if(Y4 > Y2)
         Y2 = Y4;
     end





         end


     else 

     X1 = ceil(numwhite2.BoundingBox(1));
     X2 = X1+numwhite2.BoundingBox(3)-1;
     Y1 = ceil(numwhite2.BoundingBox(2));
     Y2 = Y1+numwhite2.BoundingBox(4)-1;
      end
    

     Rac = logical(zeros(height,width));
     Rac2 = logical(zeros(height,width));
     
     Rac2(Y1:Y2,X1:X2) =1;




    [Blob,L] = bwboundaries(Rac2,'noholes');
    %% boundary 생성
    for k = 1:length(Blob)
       Rac1 = Blob{k};
       for k1 = 1: length(Rac1(:,1));

       Rac(Rac1(k1,1), Rac1(k1,2)) = 1;

       end
    end

    Rac = Rac&bw_thin;



    [r,c] = find(Rac==1);
    rc = [r c];


    max_distance = -1;

    for i =1 : size(r,1)
        for j=i:size(r,1)

            pos1 = rc(i,:);
            pos2 = rc(j,:);
            X = [pos1;pos2];
            d = pdist(X,'euclidean');

            if(d > max_distance)

                x = rc(i,:);
                y = rc(j,:);
                max_distance = d;


            end


        end
    end





    [r,c] = find(boundary==1);
    rc = [r c];

    % if(x(1,2) > y(1,2))
    %     
    %     tmp = x;
    %     x = y;
    %     y = tmp;
    %     
    %     
    % end
    % 


    angle = atan2(y(1,1) - x(1,1) , y(1,2) - x(1,2))*180/pi;

    % angle1= atan2(y(1,1) - x(1,1) , y(1,2) - x(1,2))*180/pi; 방향성
    % angle1 = 180-angle1;


     if(angle< 0) 
            angle = 360 + angle;
      end

    if(angle > 180)
        angle_line = [angle-180, angle];
    else
        angle_line = [angle,angle+180];
    end




    x1 = x(1,2);
    y1 = x(1,1);

    x2 = y(1,2);
    y2 = y(1,1);

    a = (y2-y1)/(x2-x1);



    b = (a*-x1)+y1;




    max_distance_p = 0;
    max_distance_m = 0;




    for i =1 : size(r,1)

        z = rc(i,:);
        angle2 = atan2(y(1,1) - z(1,1) , y(1,2) - z(1,2))*180/pi;

        if(angle2< 0) 
            angle2 = 360 + angle2;
        end



        x_ = z(1,2);
        y_ = z(1,1);


       ans_2 = (abs((a*x_) + -y_ +b)) / sqrt(a^2 + 1^2);



       if((angle2>(angle_line(1,1)) && max_distance_p < ans_2) && (angle2<angle_line(1,2) && max_distance_p < ans_2))
           max_distance_p = ans_2;
       end

       if((angle2 < angle_line(1,1) && max_distance_m < ans_2) || (angle2 > angle_line(1,2) && max_distance_m < ans_2))
           max_distance_m = ans_2;
       end





    end


    W = max_distance_p + max_distance_m +1;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Thining 후 내부 폭 찾기







    AC=0;
    AD=0;
    max_of_min=0;
    mmax = 0;


    for i = 7: height
        for j = 7 : width





            if(Pad_bw(i,j) == 1 )  %% 바운더리랑 중앙선이 겹치는 부분은 제외, 혹시 짧은 가지가 튀어나올 경우 엄청 큰 수가 됨.


                A_bound = Pad_boundary(i-6:i,j-6:j);
                B_bound = Pad_boundary(i-6:i,j:j+6);
                C_bound = Pad_boundary(i:i+6,j-6:j);
                D_bound = Pad_boundary(i:i+6,j:j+6);

                A_ = A_bound.*A;
                B_ = B_bound.*B;
                C_ = C_bound.*C;
                D_ = D_bound.*D;






                A_min =  min(min(A_(A_bound==1)));
                B_min =  min(min(B_(B_bound==1)));
                C_min =  min(min(C_(C_bound==1)));
                D_min =  min(min(D_(D_bound==1)));




                AC =A_min + C_min;
                BD =B_min + D_min;

                if(AC < BD)
                    max_of_min = AC;
                else
                    max_of_min = BD;
                end

                if(max_of_min > mmax)
                    mmax = max_of_min;
                end




            end



        end
    end

    mmax = mmax + 1 ;% 내부 폭 +1








    D1 = bwdistgeodesic(bw_thin, x1, y1, 'quasi-euclidean');
    D2 = bwdistgeodesic(bw_thin, x2, y2, 'quasi-euclidean');

    D = D1 + D2;
    D = round(D * 8) / 8;

    D(isnan(D)) = inf;
    skeleton_path = imregionalmin(D);
    P = imoverlay(bw_thin, imdilate(skeleton_path, ones(1,1)), [1 0 0]);
    Pos0 = [x1 y1;x2 y2];
    color = {'green','green'};
    P = insertMarker(P,Pos0,'x','color',color,'size',2);



    path_length = D(skeleton_path);
    Length_ = path_length(1);





    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    size_stats = size(stats);
    if(size_stats(1) ~=1)
        absedef=1;
    end
    
  
    

    stats = struct('Area',Area_,'Perimeter',stats.Perimeter,'Diameter',max_distance,'Per_Area',(stats.Perimeter./Area_),'Thickness',mmax,'Width',num2str(W),'Pd',(Area_/(pi*(max_distance/2)^2)),'Ds',(W/Area_),'S',(Length_/W),'Length',Length_,'Average_intensity',Average_intensity,'Circul',(4*pi*Area_)/(stats.Perimeter^2));








    %%%%%%%%%%%%%%%%%%%%%%%%%% 면적, 둘레, 직경, 면적비, 두께, 폭, 패킹 덴시티, 방향성 강도, 직진성 ,길이 ,평균명도



    end

























