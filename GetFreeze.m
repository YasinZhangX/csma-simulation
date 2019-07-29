%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GetFreeze�������ܣ����������ʱ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ ret index] =GetFreeze( RecordBackoffTime )
[i j] =size(RecordBackoffTime);                                            %i��ʾ�ڵ�����j��ʾ��ʱ϶��
ret = zeros(i,500,2);                                                       %ret��¼�˱�ʱ���
index =zeros(1,i);                                                         %index��ret��Ӧ�±�ļ�¼ֵ
NewRecord  = RecordBackoffTime;    
for ii=1:i
    for jj = 2:(j-1)
        if RecordBackoffTime(ii,jj-1)==RecordBackoffTime(ii,jj)&& RecordBackoffTime(ii,jj)==RecordBackoffTime(ii,jj+1)
           NewRecord(ii,jj) = RecordBackoffTime(ii,jj-1);                  %�ҳ��˱�ʱ�䲻���ʱ��Σ�������ʱ���
        else
          NewRecord(ii,jj) = 0;                                            %����������Ϊ0
        end
    end
end
RecordBackoffTime = NewRecord;
for ii=1:i
    for jj = 2:(j-1)
        if RecordBackoffTime(ii,jj-1)>RecordBackoffTime(ii,jj)             %�ҳ�����ʱ�����ʼ��
            index(ii)=index(ii)+1;
            ret(ii,index(ii),1)=jj;                                        %����¼�˿�ʱ��
            ret(ii,index(ii),2)=RecordBackoffTime(ii,jj-1);                %����¼�˿̵��˱�ʱ��
        end
         if RecordBackoffTime(ii,jj-1)<RecordBackoffTime(ii,jj)            %�ҳ�����ʱ��εĽ�����
            index(ii)=index(ii)+1;
            ret(ii,index(ii),1)=jj;                                        %��¼�˿̵�ʱ��
            ret(ii,index(ii),2)=RecordBackoffTime(ii,jj);                  %�����ʴ˿̵��˱�ʱ��
        end
    end
end
end