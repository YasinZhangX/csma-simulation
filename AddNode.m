%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AddNode���ܣ���¼�ڵ���Ϣ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ret = AddNode(CollisionNodes,index)
CollisionNodes(1) = CollisionNodes(1) + 1;                                 %��ͳ�ƶ��ٸ��ڵ�
i = CollisionNodes(1);                                                     %ȡ����ǰ����վ����Ŀ
CollisionNodes(i+1) = index;                                               %��¼�����ĸ�վ��
ret = CollisionNodes;                                                      %����
