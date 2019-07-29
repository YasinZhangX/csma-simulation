%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Display�������ܣ�ͬ��̬ͼ��չʾCSMA/CA����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [] =Display(RecordBackoffTime,RecordSendTime, SendNodeIndex,TotalTime,NumberNodes,ConWindow);
figure(1);
[Freeze index]=GetFreeze(RecordBackoffTime);                               %��ȡÿ������˱ܼ������Ĺ���
x = 1:TotalTime;
for i=1:NumberNodes
    subplot(4,1,i);                                                        %����4����ͼ
     plot(x(:),RecordBackoffTime(i,:),'r');                                %�����˱ܹ��̵�����
    if i==1
        title('��̬�˱ܹ���');                                              
        ylabel('�ڵ�1');
    end
      if i==2
        ylabel('�ڵ�2');
      end
      if i==3
        ylabel('�ڵ�3');
      end
      if i==4
        ylabel('�ڵ�4');    
    end
    for k=1:SendNodeIndex(i)                                               %ѭ���������ݷ��͹���
        SendStart = RecordSendTime(i,k,1);                             
        SendEnd = RecordSendTime(i,k,2); 
        FrameLength = RecordSendTime(i,k,3);
        Time = SendEnd - SendStart; 
        if Time < (ConWindow+1)                                            %����������ڷ�����ײ����������ͼ��
            patch([SendStart SendEnd SendEnd SendStart],[0 0 (FrameLength-Time) FrameLength],[.9 .0 .1]);
        else
        patch([SendStart SendEnd SendStart],[0 0 FrameLength],[.5 .8 .3]); %����û����ײ�����ݷ��͹���
        end
    end
     for k=1:2:index(i)                                                    %ѭ�������ڵ㶳�����
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
while t<(TotalTime-200)                                                    %�ƶ����꣬��ʾ��
   t=t+1;
    for i=1:NumberNodes
        hold on;
        subplot(4,1,i);
        xStart=t;
        xEnd=t+200;
        hold on;
        axis([xStart,xEnd,0,12]);
    end
    pause(0.1);                                                            %�����ƶ��ٶ�
end

end

