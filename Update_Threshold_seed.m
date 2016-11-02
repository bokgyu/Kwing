function [ New_Threshold ] = Update_Threshold( N,Dp_gray,Threshold_T,Weight )
%UPDATE_THRESHOLD 이 함수의 요약 설명 위치
%   자세한 설명 위치

New_Threshold = min(min(min(Dp_gray(:))),Threshold_T)+Weight;


end

