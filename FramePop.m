%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FramePop�������ܣ�֡��ջ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ret = FramePop(FrameBuffer,n)
FrameBuffer(n,:) = [FrameBuffer(n,1),FrameBuffer(n,3:1501),0];             %���������ͷͷ����֡��¼
FrameBuffer(n,1) = FrameBuffer(n,1) - 1;                                   %��֡��������Ŀ��1
ret = FrameBuffer;
