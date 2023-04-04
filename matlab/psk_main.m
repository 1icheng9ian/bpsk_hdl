%%%%%%%%%%%%%%%%%
% psk_main.m
% Author: Li Chengqian
% Date  : 2023/03/29
% Func  : psk modulation
%%%%%%%%%%%%%%%%%
clear
close all
%% Parameters
seed = 1234;        % 随机种子
code_len = 20;      % 码长
samp_rate = 200e6;  % 采样速率
code_rate = 1e6;    % 码元速率
bb_rate = 11e6;     % 基带速率
wave_rate = 44e6;   % 载波速率
n_sps = samp_rate/code_rate;
dds_len = n_sps*code_len;
m_psk = 2;          % psk调制类型

%% generate baseband code
rng(seed)
code0 = randi(2,code_len,1)-1;  % 基带单极性码元
code1 = 2*code0 - 1;            % 双极性码元

%% upsampling
code_up = rectpulse(code1,n_sps);

%% filter
code_flt = rcos_filter(code_up);
if 1
    figure
    plot(code_up)
    hold on
    plot(code_flt)
    hold off
    legend('滤波前','滤波后')
end

%% dds
% t = (0:1:(wave_rate/code_rate*code_len-1))'/samp_rate;
% dds = exp(1i*2*pi*wave_rate*t);
[sine,cosine,phase] = dds0(16,16,samp_rate,bb_rate,dds_len);
bb_dds = cosine + 1i*sine;

%% m-psk modulation
psk_phase = pi/m_psk * code_flt;
% psk_bs = exp(1i*psk_phase);
% psk_out = bb_dds.*psk_bs;
[x_out,y_out] = cordic_rotate(imag(bb_dds),real(bb_dds),psk_phase);
psk_out = y_out + 1i*x_out;

%% figure
if 1
    figure
    plot(code_flt)
    hold on
    plot(real(psk_out))
    hold off
    legend('原码','bpsk调制信号')
end

