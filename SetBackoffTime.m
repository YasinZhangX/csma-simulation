%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SetBackoffTime�������ܣ������˱ܴ��������˱�ʱ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ret = SetBackoffTime(CountBackoff)
MaxCountBackoff = 3 ;                                                      %�˱ܴ�������ֵ
if CountBackoff>  MaxCountBackoff                                          %�˱ܴ�����������ֵ                                                      
   CountBackoff  = 0;                                                      %�˱ܴ�����0
end
n = 2^(2+CountBackoff);                                                    %�����˱�ʱ�������ֵ
t = randperm(n)-1;                                                         %���˱�ʱ�������ֵ��Χ�������˱�ʱ������
BackoffTime = t(1);                                                        %�����һ����Ϊ�˱�ʱ��
ret = BackoffTime;                                                         %��������˱�ʱ��
ret = randi([0 2^pBackoffExponent-1]);
end
 