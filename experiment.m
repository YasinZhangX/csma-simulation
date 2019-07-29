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
for i=1:16
    [AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
     temp1=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
    [AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
     temp2=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
    [AllFrame(i), SuccessFrame(i)] = Csmaca(i,ConWindow);
     temp3=(AllFrame(i)-SuccessFrame(i))/AllFrame(i);
     SER_Nodes(i)=(temp1+temp2+temp3)/3;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%：画图展示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
plot(1:16,SER_Nodes(:), '-*');
box on;
grid on;
xlabel('Nodes');
ylabel('SER');
% xlim([1, 15]);                                  % 只设定x轴的绘制范围
set(gca,'XTick',0:2:16);                          % 改变x轴坐标间隔显示 这里间隔为2
title('CSMA\_CA: Nodes-SER');