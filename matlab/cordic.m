%%%%%%%%%%%%%%
% cordic.m
% Author: Li Chengqian
% Date  : 2023/04/03
% Func  : basic cordic float algorithm
%%%%%%%%%%%%%%
function [cos_out,sin_out] = cordic(phase_in)
% phase_in  : phase input
% cos_out   : cosine output
% sin_out   : sine output

%% parameter
iteration = 16; % 迭代次数

%% phase pre-rotating
if (0<phase_in) && (phase_in<pi/2)
    
elseif ()

end

%% calculation
x = zeros(iteration+1,1);
y = zeros(iteration+1,1);
z = zeros(iteration+1,1);

x(1) = 0.607253; % 初始值赋为cos累乘值
z(1) = phase_in;

for i = 1:iteration
    if z(i) >= 0
        d = 1;
    else
        d = -1;
    end
    x(i+1) = x(i) - d*y(i)*(2^(-(i-1)));
    y(i+1) = y(i) + d*x(i)*(2^(-(i-1)));
    z(i+1) = z(i) - d*atan(2^(-(i-1)));
end

cos_out = x(iteration+1);
sin_out = y(iteration+1);

end
