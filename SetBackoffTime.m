%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SetBackoffTime函数功能：根据退避次数生成退避时间
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ret = SetBackoffTime(pBackoffExponent)
    ret = randi([0 2^pBackoffExponent-1]);                                 %产生随机数
end