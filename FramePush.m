%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FramePush�������ܣ���֡���뻺����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ret = FramePush(FrameBuffer,n,FrameLength)
number = FrameBuffer(n,1);                                                 %ȡ����ǰ�������Ѵ�֡�ĸ��������ڻ��������ײ�
if number < 1500                                                           %���û����֡���������ֵ������뻺������������
    FrameBuffer(n,number+2) = FrameLength;                                 %��¼�´�֡�ĳ���
    FrameBuffer(n,1) = FrameBuffer(n,1) + 1;                               %������֡�ĸ�����1
end
ret = FrameBuffer;
