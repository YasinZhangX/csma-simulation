clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllFrame = zeros(1,15);                                                    %发的帧的总数
SuccessFrame = zeros(1,15);                                                %发送成功的帧的数量
SER_Nodes = zeros(1,15);                                                   %误码率
ConWindow = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%：计算节点个数对系统性能的影响
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 3;
[AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
temp1=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
[AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
temp2=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
[AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
temp3=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
SER_Nodes(i)=(temp1+temp2+temp3)/3;