clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllFrame = zeros(1,15);                                                    %����֡������
SuccessFrame = zeros(1,15);                                                %���ͳɹ���֡������
SER_Nodes = zeros(1,15);                                                   %������
ConWindow = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������ڵ������ϵͳ���ܵ�Ӱ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 3;
[AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
temp1=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
[AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
temp2=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
[AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
temp3=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
SER_Nodes(i)=(temp1+temp2+temp3)/3;