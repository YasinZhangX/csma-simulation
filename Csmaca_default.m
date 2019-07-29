% 采用默认值进行CSMA/CA
function [AllFrame, SuccessFrame, BackoffTime] = Csmaca_default(NumberNodes,ConWindow)
    [AllFrame, SuccessFrame, BackoffTime] = Csmaca(NumberNodes,ConWindow, 3, 5);
end