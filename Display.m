%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Display函数功能：同动态图形展示CSMA/CA过程
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [] =Display(RecordBackoffTime,RecordSendTime, SendNodeIndex,TotalTime,NumberNodes,ConWindow);
figure(1);
[Freeze index]=GetFreeze(RecordBackoffTime);                               %获取每个点的退避计数器的过程
x = 1:TotalTime;
for i=1:NumberNodes
    subplot(4,1,i);                                                        %画出4个子图
     plot(x(:),RecordBackoffTime(i,:),'r');                                %画出退避过程的轮廓
    if i==1
        title('动态退避过程');                                              
        ylabel('节点1');
    end
      if i==2
        ylabel('节点2');
      end
      if i==3
        ylabel('节点3');
      end
      if i==4
        ylabel('节点4');    
    end
    for k=1:SendNodeIndex(i)                                               %循环画出数据发送过程
        SendStart = RecordSendTime(i,k,1);                             
        SendEnd = RecordSendTime(i,k,2); 
        FrameLength = RecordSendTime(i,k,3);
        Time = SendEnd - SendStart; 
        if Time < (ConWindow+1)                                            %如果在争用期发生碰撞，画出数据图形
            patch([SendStart SendEnd SendEnd SendStart],[0 0 (FrameLength-Time) FrameLength],[.9 .0 .1]);
        else
        patch([SendStart SendEnd SendStart],[0 0 FrameLength],[.5 .8 .3]); %画出没有碰撞的数据发送过程
        end
    end
     for k=1:2:index(i)                                                    %循环画出节点冻结过程
        FreezeStart = Freeze(i,k,1); 
        FreezeWidth= Freeze(i,k,2); 
        FreezeEnd = Freeze(i,k+1,1); 
        FreezeHigh= Freeze(i,k+1,2); 
        patch([FreezeStart-1  FreezeEnd FreezeEnd FreezeStart-1],[0 0 FreezeHigh FreezeWidth],[.8 .5 .1]);
    end
    box on;
    grid on;
    axis([1 200 0 12]);
end
t=1;
while t<(TotalTime-200)                                                    %移动坐标，显示动
   t=t+1;
    for i=1:NumberNodes
        hold on;
        subplot(4,1,i);
        xStart=t;
        xEnd=t+200;
        hold on;
        axis([xStart,xEnd,0,12]);
    end
    pause(0.1);                                                            %控制移动速度
end

end

