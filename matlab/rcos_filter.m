function y = rcos_filter(x)
%RCOS_FILTER 返回离散时间滤波器对象。

% MATLAB Code
% Generated by MATLAB(R) 9.13 and DSP System Toolbox 9.15.
% Generated on: 03-Apr-2023 19:51:57

% FIR Window Raised-cosine filter designed using the FIRRCOS function.

% All frequency values are in MHz.
Fs = 200;  % Sampling Frequency

N     = 160;        % Order
Fc    = 2.5;        % Cutoff Frequency
TM    = 'Rolloff';  % Transition Mode
R     = 0.5;        % Rolloff
DT    = 'sqrt';     % Design Type
Alpha = 2.5;        % Window Parameter

% Create the window vector for the design algorithm.
win = gausswin(N+1, Alpha);

% Calculate the coefficients using the FIR1 function.
b  = firrcos(N, Fc/(Fs/2), R, 2, TM, DT, [], win);
Hd = dsp.FIRFilter( ...
    'Numerator', b);
y = step(Hd,double(x));

% [EOF]
