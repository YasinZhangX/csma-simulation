%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%RecordSend�������ܣ������ݷ��͹��̼�¼����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [RecordSendProcess SendNodeIndex] = RecordSend(RecordSendProcess,SendNodeIndex,i,SendStart,SendEnd,FrameLength )
SendNodeIndex(i)= SendNodeIndex(i)+1;                                      %�����±�
RecordSendProcess(i, SendNodeIndex(i),1)=SendStart;                        %��¼������ʼʱ��
RecordSendProcess(i, SendNodeIndex(i),2)=SendEnd;                          %��¼���ͽ���ʱ��
RecordSendProcess(i, SendNodeIndex(i),3)=FrameLength;                      %��¼֡��
end

