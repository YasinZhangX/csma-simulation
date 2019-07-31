clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 16;                                                                    %节点的个数
tryTimes = 50;                                                             %重复试验的次数
AllFrame = zeros(n, tryTimes, 4);                                                    %发的帧的总数
SuccessFrame = zeros(n, tryTimes, 4);                                                %发送成功的帧的数量
SER_Nodes_try = zeros(n, tryTimes, 4);
SER_Nodes = zeros(1, n, 4);                                                %误码率
BackoffTime_try = zeros(n, tryTimes, 4);
BackoffTime = zeros(1, n, 4);                                              %退避时间总和
Throughout = zeros(1, n, 4);                                               %吞吐量
ConWindow = 1;
BEIndex = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%：计算节点个数对系统性能的影响
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for maxBE = 4:7
    for t = 1:tryTimes
        for i = 1:n
            [AllFrame(i,t,BEIndex), SuccessFrame(i,t,BEIndex), BackoffTime_try(i,t,BEIndex)] = Csmaca(i,ConWindow, 3, maxBE);
             SER_Nodes_try(i,t,BEIndex) = (AllFrame(i,t,BEIndex)-SuccessFrame(i,t,BEIndex))/AllFrame(i,t,BEIndex);
        end
    end
    Throughout(:,:,BEIndex) = mean(SuccessFrame(:,:,BEIndex), 2)';
    SER_Nodes(:,:,BEIndex) = mean(SER_Nodes_try(:,:,BEIndex), 2)';
    BackoffTime(:,:,BEIndex) = mean(BackoffTime_try(:,:,BEIndex), 2)';
    BEIndex = BEIndex + 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%：画图展示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
plot(1:n, SER_Nodes(:,:,1), '-*');
hold on;
plot(1:n, SER_Nodes(:,:,2), '-o');
hold on;
plot(1:n, SER_Nodes(:,:,3), '-+');
hold on;
plot(1:n, SER_Nodes(:,:,4), '-d');
legend('minBE=2','minBE=3','minBE=4','minBE=5');
box on;
grid on;
xlabel('Nodes');
ylabel('SER');
% xlim([1, 15]);                                  % 只设定x轴的绘制范围
set(gca,'XTick',0:1:n);                          % 改变x轴坐标间隔显示 这里间隔为1
title('CSMA/CA: SER vs Nodes');

figure(2);
plot(1:n, BackoffTime(:,:,1), '-*');
hold on;
plot(1:n, BackoffTime(:,:,2), '-o');
hold on;
plot(1:n, BackoffTime(:,:,3), '-+');
hold on;
plot(1:n, BackoffTime(:,:,4), '-d');
legend('minBE=2','minBE=3','minBE=4','minBE=5');
box on;
grid on;
xlabel('Nodes');
ylabel('Backoff Time');
% xlim([1, 15]);                                  % 只设定x轴的绘制范围
set(gca,'XTick',0:1:n);                          % 改变x轴坐标间隔显示 这里间隔为1
title('CSMA/CA: BackoffTime vs Nodes');

figure(3);
plot(1:n, Throughout(:,:,1), '-*');
hold on;
plot(1:n, Throughout(:,:,2), '-o');
hold on;
plot(1:n, Throughout(:,:,3), '-+');
hold on;
plot(1:n, Throughout(:,:,4), '-d');
legend('maxBE=4','maxBE=5','maxBE=6','maxBE=7');
box on;
grid on;
xlabel('Nodes');
ylabel('Throughout');
% xlim([1, 15]);                                  % 只设定x轴的绘制范围
set(gca,'XTick',0:1:n);                          % 改变x轴坐标间隔显示 这里间隔为1
title('CSMA/CA: Throughout vs Nodes');