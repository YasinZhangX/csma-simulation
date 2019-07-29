clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 16;                                                                    %节点的个数
tryTimes = 50;                                                             %重复试验的次数
AllFrame = zeros(1, n);                                                    %发的帧的总数
SuccessFrame = zeros(1, n);                                                %发送成功的帧的数量
SER_Nodes_try = zeros(4, n, tryTimes);
SER_Nodes = zeros(4, 1, n);                                                  %误码率
BackoffTime_try = zeros(4, n, tryTimes);
BackoffTime = zeros(4, 1, n);                                                %退避时间总和
ConWindow = 1;
BEIndex = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%：计算节点个数对系统性能的影响
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for minBE = 2:5
    for t = 1:50
        for i = 1:n
            [AllFrame(i), SuccessFrame(i), BackoffTime_try(BEIndex,i,t)] = Csmaca(i,ConWindow, minBE, 5);
             SER_Nodes_try(BEIndex,i,t) = (AllFrame(i)-SuccessFrame(i))/AllFrame(i);
        end
    end
    SER_Nodes(BEIndex) = mean(SER_Nodes_try(BEIndex), 2)';
    BackoffTime(BEIndex) = mean(BackoffTime_try(BEIndex), 2)';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%：画图展示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
plot(1:n, SER_Nodes(1,:), '-*');
box on;
grid on;
xlabel('Nodes');
ylabel('SER');
% xlim([1, 15]);                                  % 只设定x轴的绘制范围
set(gca,'XTick',0:1:n);                          % 改变x轴坐标间隔显示 这里间隔为1
title('CSMA\_CA: Nodes-SER');

figure(2);
plot(1:n, BackoffTime(1,:), '-*');
box on;
grid on;
xlabel('Nodes');
ylabel('Backoff');
% xlim([1, 15]);                                  % 只设定x轴的绘制范围
set(gca,'XTick',0:1:n);                          % 改变x轴坐标间隔显示 这里间隔为1
title('CSMA\_CA: BackoffTime');