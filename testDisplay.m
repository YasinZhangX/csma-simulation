%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%：画图展示
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
SER_Nodes = SER_Nodes .* 100;
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