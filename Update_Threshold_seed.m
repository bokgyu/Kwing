function [ New_Threshold ] = Update_Threshold( N,Dp_gray,Threshold_T,Weight )
%UPDATE_THRESHOLD �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ

New_Threshold = min(min(min(Dp_gray(:))),Threshold_T)+Weight;


end

