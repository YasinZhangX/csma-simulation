clear all;
close all;
clc;                           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����һ : ��ʼ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TRUE = 1;                                                                  %��ʾ�¼�Ϊ��                       
FALSE = 0;                                                                 %��ʾ�¼�Ϊ��                                                     
ACK = 2.8;                                                                 %ACK֡�൱��0.5��ʱ϶
SIFS = 10.5;                                                               %SIFS֡�൱��0.5��ʱ϶
DIFS = 12.5;                                                               %DIFS֡�൱��2.5��ʱ϶
SendEndTime = 0;                                                           %���ͽ���ʱ��
NumberNodes =4;                                                            %���뾺���Ľڵ���
SlotTime = 20*10^(-3);                                                     %ʱ϶
AllSlotTime = 15/SlotTime;                                                 %��ʱ϶����
BufferSize = 1500;                                                         %֡��������С
ChannelBusyFlag = 0;                                                       %�ŵ�æ�б�־
CollisionHandleFlag = 0;                                                   %��ͻ��ײ�����ͱ�־
ArrivalTime = zeros(1,NumberNodes);                                        %֡����ʱ��
FrameLength = zeros(1,NumberNodes) ;                                       %֡��
HasFrameFlag = zeros(1,NumberNodes);                                       %֡��������֡��־
CountBackoff = zeros(1,NumberNodes);                                       %�˱ܴ���
BackoffTime = zeros(1,NumberNodes);                                        %�˱�ʱ��
FrameBuffer = zeros(NumberNodes,1501);                                     %֡������
CollisionNodes = zeros(1,NumberNodes+1);                                   %��ͻ�ڵ��¼
CurBufferSize = zeros(1,NumberNodes);                                      %��ǰ֡���������ô�С
sign = 1;
for i = 1:NumberNodes
    ArrivalTime(i) = ceil(20*rand());                                      %��ʼ��֡����ʱ��
    FrameLength(i)=10;                                                     %��ʼ��֡����
    CountBackoff(i) = 0;                                                   %��ʼ���˱ܴ���
    BackoffTime(i) =0;                                                     %��ʼ���˱�ʱ��
end
RecordBackoffTime=zeros(NumberNodes,AllSlotTime);                          %��¼վ����˱�ʱ��
RecordSendTime=zeros(NumberNodes,100,3);                                   %��¼���ݷ��͹���
SendNodeIndex=zeros(1,NumberNodes);                                        %��¼���ݷ��͹����±�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����2��CSMA/CAѭ������ʼ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for t = 1:AllSlotTime
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %����2.1��֡�������������ݲ�ͬ������д���
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:NumberNodes
        if t == ArrivalTime(i)                                             %���µ�֡��Ҫ���ͣ����ȷ��뻺����                                     
            if CurBufferSize(i) < BufferSize - FrameLength(i)              %���֡������������δ��
                fprintf('��%d���ڵ�%dʱ��%d����֡���뻺������\n',i, ArrivalTime(i),FrameLength(i));
                FrameBuffer = FramePush(FrameBuffer,i,FrameLength(i));     %��֡���뻺��������������֡
                CurBufferSize(i) = CurBufferSize(i) + FrameLength(i);      %�޸ĵ�ǰ�������Ѵ�֡���ܳ���
                if HasFrameFlag(i) == FALSE                                %��������û��֡����ʱ��֡����
                     HasFrameFlag(i) = TRUE;                               %����֡��־��Ϊ1
                    if ChannelBusyFlag== FALSE                             %���ŵ�����
                         BackoffTime(i)=0;                                 %�˱�ʱ����Ϊ0
                    else
                        BackoffTime(i)=SetBackoffTime(1);                  %�����˱�ʱ����Ϊһ���ʱ��
                    end
                end        
            end
            sign=sign+1;                                                   %���������µ�֡
            if sign<10
                ArrivalTime(i) =10 + 10 + t;
                FrameLength(i) = 10;
            end
        end
        fprintf('��%dʱ�̵�%d���ڵ���˱�ʱ��Ϊ%d��\n',t,i, BackoffTime(i)); %��ӡ���˱�ʱ��
        if RecordBackoffTime(i,t)==0
           RecordBackoffTime(i,t)=BackoffTime(i);                          %��¼�˱�ʱ��
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %����2-2��ͳ�ƴ˿�׼���������ݵĽڵ�
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:NumberNodes                                                         
        if ChannelBusyFlag == FALSE                                        %�ŵ���
            if HasFrameFlag(i) == TRUE                                     %��֡���������ŵ�����
                if BackoffTime(i) == 0                                     %����˱�ʱ��Ϊ0
                    CollisionNodes = AddNode(CollisionNodes,i);            %��¼�˱�ʱ��Ϊ0�Ľڵ�
                    CollisionHandleFlag= TRUE;                             %��ͻ�����־Ϊ��
                    fprintf('��%d���ڵ�%dʱ�̽��������ڣ�\n',i,t);           
                else
                    BackoffTime(i)= BackoffTime(i)-1;                      %�˱�ʱ�䲻Ϊ0�����˱�ʱ���1
                end                                                        
            end
        end
    end
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %����2-3�����������ͳ�ƵĽڵ�
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if CollisionHandleFlag == TRUE                                         %�нڵ��˱�ʱ��Ϊ0                                                 
        n = CollisionNodes(1);                                             %������ײ�ڵ����
        if n == 1                                                          %���ֻ��һ���ڵ㣬�ɷ�������
            ChannelBusyFlag = TRUE;                                        %�ŵ���æ
            SendEndTime = floor(t + SIFS + DIFS + ACK + FrameBuffer(CollisionNodes(2),2));%���㷢�����ʱ��
            i = CollisionNodes(2);
            fprintf('��%d���ڵ�%dʱ�̿�ʼ���ͣ�֡��%d��,Ԥ�Ʒ��ͽ���ʱ��%d��\n',i,t,FrameBuffer(i,2),SendEndTime); 
            [RecordSendTime SendNodeIndex]= RecordSend(RecordSendTime,SendNodeIndex,i,t,SendEndTime,FrameBuffer(i,2)); 
                                                                           %��¼���͹���
        else                                                               %�������������֡���ȼ���                                            
            for  i = 1:n                                                   %�������ͼͬʱ����
                j = CollisionNodes(i+1);                                   %�ҳ���Щ��
                CountBackoff(j) = Increase(CountBackoff,j);                %��ײ������1
                BackoffTime(j) = SetBackoffTime(CountBackoff(j));          %�����˱�ʱ��
            end 
            CollisionNodes = zeros(1,NumberNodes+1);                       %����ڵ���ײ��¼
        end
            CollisionHandleFlag=FALSE;                                     %��ײ�����ʶ��ΪFALSE
      end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %����2-4����֡����ʱ��������Ӧ�Ĵ���
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if t == SendEndTime                                                    %�ﵽ���ݷ������ʱ��
            n = CollisionNodes(2);                                         %ȷ���Ǹ��ڵ��֡�ڷ���
            fprintf('��%d���ڵ�%dʱ�̷��ͽ�����\n',n,t);
            CurBufferSize(n) = CurBufferSize(n) - FrameBuffer(n,2);        %���»������Ѵ����ݵĳ���
            FrameBuffer = FramePop(FrameBuffer,n);                         %ͬʱ֡��ջ
            CountBackoff(n) = 0;                                           %ͬʱ�˱ܴ�����0
            k = FrameBuffer(n,1);                                          %���ʱ������֡��
            if k == 0                                                      %�����������֡
                HasFrameFlag(n) = FALSE;                                   %����֡��ʶ��FALSE
                BackoffTime(n) = 0;                                        %�˱�ʱ����0
            else                                                           %�������ݷַ���
                BackoffTime(n) =SetBackoffTime(2);                         %���򣬻���֡��������ײʱ��
            end    
            CollisionNodes = zeros(1,NumberNodes+1);                       %����ײ�ڵ��¼��0
            ChannelBusyFlag = FALSE;                                       %���ŵ�æ��ʶ��ΪFALSE��������
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %����2����
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Display(RecordBackoffTime,RecordSendTime, SendNodeIndex,AllSlotTime,NumberNodes,0);
%��CSMA���̼�¼�������ö�̬ͼ����ʾ��ײ����