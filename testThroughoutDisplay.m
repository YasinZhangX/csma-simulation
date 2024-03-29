figure(3);
plot(1:n, Throughout(:,:,1), '-*', 'LineWidth',1);
hold on;
plot(1:n, Throughout(:,:,2), '-o', 'LineWidth',1);
hold on;
plot(1:n, Throughout(:,:,3), '-+', 'LineWidth',1);
hold on;
plot(1:n, Throughout(:,:,4), '-d', 'LineWidth',1);
legend('maxBE=4','maxBE=5','maxBE=6','maxBE=7');
box on;
grid on;
xlabel('Nodes');
ylabel('Throughout/Number of packets');
% xlim([1, 15]);                                  % 只设定x轴的绘制范围
set(gca,'XTick',0:1:n);                          % 改变x轴坐标间隔显示 这里间隔为1
title('CSMA/CA: Throughout vs Nodes');