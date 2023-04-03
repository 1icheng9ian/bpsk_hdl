%%%%%%%%%%%%%%%%%
% dds.m
% Author: Li Chengqian
% Date  : 2023/03/29
% Func  : generate cosine and sine signal
%%%%%%%%%%%%%%%%%
function [sine,cosine,phase] = dds0(phase_width,data_width,f_clk,f_out,len)
% phase_width : 相位位宽
% data_width  : 信号位宽
% f_clk       : 时钟频率
% f_out       : 输出信号频率
% len         : 信号长度
phase_inc = f_out*2^phase_width/f_clk;  % 频率控制字
phase = zeros(len,1);
sine = zeros(len,1);
cosine = ones(len,1);
for i = 2:len
    phase(i) = mod((phase(i-1) + phase_inc), 2^phase_width);
    sine(i) = sin(2*pi*phase(i)/2^phase_width);
    cosine(i) = cos(2*pi*phase(i)/2^phase_width);
end
sine = round(sine*2^data_width)/2^data_width;
cosine = round(cosine*2^data_width)/2^data_width;

if 0
    figure
    plot(sine)
    hold on
    plot(cosine)
    hold on
    plot(phase)
    hold off
    legend('sine','cosine','phase')
end
end