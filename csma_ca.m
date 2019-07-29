clear all;
close all;
clc;                           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 步骤一 : 初始化
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TRUE = 1;                                                                  %表示事件为真                       
FALSE = 0;                                                                 %表示事件为假                                                     
ACK = 2.8;                                                                 %ACK帧相当于0.5个时隙
SIFS = 10.5;                                                               %SIFS帧相当于0.5个时隙
DIFS = 12.5;                                                               %DIFS帧相当于2.5个时隙
SendEndTime = 0;                                                           %发送结束时间
NumberNodes =4;                                                            %参与竞争的节点数
SlotTime = 20*10^(-3);                                                     %时隙
AllSlotTime = 15/SlotTime;                                                 %总时隙个数
BufferSize = 1500;                                                         %帧缓冲区大小
ChannelBusyFlag = 0;                                                       %信道忙闲标志
CollisionHandleFlag = 0;                                                   %冲突碰撞处理发送标志
ArrivalTime = zeros(1,NumberNodes);                                        %帧到达时间
FrameLength = zeros(1,NumberNodes) ;                                       %帧长
HasFrameFlag = zeros(1,NumberNodes);                                       %帧缓存有无帧标志
CountBackoff = zeros(1,NumberNodes);                                       %退避次数
BackoffTime = zeros(1,NumberNodes);                                        %退避时间
FrameBuffer = zeros(NumberNodes,1501);                                     %帧缓冲器
CollisionNodes = zeros(1,NumberNodes+1);                                   %冲突节点记录
CurBufferSize = zeros(1,NumberNodes);                                      %当前帧缓冲区已用大小
sign = 1;
for i = 1:NumberNodes
    ArrivalTime(i) = ceil(20*rand());                                      %初始化帧到达时间
    FrameLength(i)=10;                                                     %初始化帧长度
    CountBackoff(i) = 0;                                                   %初始化退避次数
    BackoffTime(i) =0;                                                     %初始化退避时间
end
RecordBackoffTime=zeros(NumberNodes,AllSlotTime);                          %记录站点的退避时间
RecordSendTime=zeros(NumberNodes,100,3);                                   %记录数据发送过程
SendNodeIndex=zeros(1,NumberNodes);                                        %记录数据发送过程下标
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%步骤2：CSMA/CA循环处理开始
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for t = 1:AllSlotTime
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %步骤2.1：帧进缓冲区，根据不同情况进行处理
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:NumberNodes
        if t == ArrivalTime(i)                                             %有新的帧需要发送，则先放入缓冲区                                     
            if CurBufferSize(i) < BufferSize - FrameLength(i)              %如果帧缓冲区还可以未满
                fprintf('第%d个节点%d时刻%d长的帧进入缓冲区！\n',i, ArrivalTime(i),FrameLength(i));
                FrameBuffer = FramePush(FrameBuffer,i,FrameLength(i));     %则将帧放入缓冲区，否则丢弃次帧
                CurBufferSize(i) = CurBufferSize(i) + FrameLength(i);      %修改当前缓冲区已存帧的总长度
                if HasFrameFlag(i) == FALSE                                %当缓冲区没有帧，此时有帧进入
                     HasFrameFlag(i) = TRUE;                               %把有帧标志设为1
                    if ChannelBusyFlag== FALSE                             %当信道空闲
                         BackoffTime(i)=0;                                 %退避时间置为0
                    else
                        BackoffTime(i)=SetBackoffTime(1);                  %否则退避时间置为一随机时间
                    end
                end        
            end
            sign=sign+1;                                                   %不断生成新的帧
            if sign<10
                ArrivalTime(i) =10 + 10 + t;
                FrameLength(i) = 10;
            end
        end
        fprintf('第%d时刻第%d个节点的退避时间为%d！\n',t,i, BackoffTime(i)); %打印出退避时间
        if RecordBackoffTime(i,t)==0
           RecordBackoffTime(i,t)=BackoffTime(i);                          %记录退避时间
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %步骤2-2：统计此刻准备发送数据的节点
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:NumberNodes                                                         
        if ChannelBusyFlag == FALSE                                        %信道闲
            if HasFrameFlag(i) == TRUE                                     %有帧待发送且信道空闲
                if BackoffTime(i) == 0                                     %如果退避时间为0
                    CollisionNodes = AddNode(CollisionNodes,i);            %记录退避时间为0的节点
                    CollisionHandleFlag= TRUE;                             %冲突处理标志为真
                    fprintf('第%d个节点%d时刻进入争用期！\n',i,t);           
                else
                    BackoffTime(i)= BackoffTime(i)-1;                      %退避时间不为0，则退避时间减1
                end                                                        
            end
        end
    end
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %步骤2-3：分情况处理统计的节点
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if CollisionHandleFlag == TRUE                                         %有节点退避时间为0                                                 
        n = CollisionNodes(1);                                             %参与碰撞节点个数
        if n == 1                                                          %如果只有一个节点，可发送数据
            ChannelBusyFlag = TRUE;                                        %信道置忙
            SendEndTime = floor(t + SIFS + DIFS + ACK + FrameBuffer(CollisionNodes(2),2));%计算发送完成时刻
            i = CollisionNodes(2);
            fprintf('第%d个节点%d时刻开始发送（帧长%d）,预计发送结束时间%d！\n',i,t,FrameBuffer(i,2),SendEndTime); 
            [RecordSendTime SendNodeIndex]= RecordSend(RecordSendTime,SendNodeIndex,i,t,SendEndTime,FrameBuffer(i,2)); 
                                                                           %记录发送过程
        else                                                               %后面以最大数据帧长度计算                                            
            for  i = 1:n                                                   %多个点试图同时发送
                j = CollisionNodes(i+1);                                   %找出这些点
                CountBackoff(j) = Increase(CountBackoff,j);                %碰撞次数加1
                BackoffTime(j) = SetBackoffTime(CountBackoff(j));          %更新退避时间
            end 
            CollisionNodes = zeros(1,NumberNodes+1);                       %清除节点碰撞记录
        end
            CollisionHandleFlag=FALSE;                                     %碰撞处理标识置为FALSE
      end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %步骤2-4：当帧结束时，作出相应的处理
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if t == SendEndTime                                                    %达到数据发送完成时间
            n = CollisionNodes(2);                                         %确定那个节点的帧在发送
            fprintf('第%d个节点%d时刻发送结束！\n',n,t);
            CurBufferSize(n) = CurBufferSize(n) - FrameBuffer(n,2);        %更新缓冲区已存数据的长度
            FrameBuffer = FramePop(FrameBuffer,n);                         %同时帧出栈
            CountBackoff(n) = 0;                                           %同时退避次数置0
            k = FrameBuffer(n,1);                                          %求此时缓冲区帧数
            if k == 0                                                      %如果缓冲区无帧
                HasFrameFlag(n) = FALSE;                                   %有无帧标识置FALSE
                BackoffTime(n) = 0;                                        %退避时间置0
            else                                                           %还有数据分发送
                BackoffTime(n) =SetBackoffTime(2);                         %否则，还有帧，更新碰撞时间
            end    
            CollisionNodes = zeros(1,NumberNodes+1);                       %将碰撞节点记录清0
            ChannelBusyFlag = FALSE;                                       %将信道忙标识置为FALSE，即空闲
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %步骤2结束
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Display(RecordBackoffTime,RecordSendTime, SendNodeIndex,AllSlotTime,NumberNodes,0);
%将CSMA过程记录下来，用动态图形显示碰撞过程