%%%%%%%%%%
% cordic_rotate.m
% Author: Li Chengqian
% Date  : 2023/03/29
% Func  : Coordinate rotation
%%%%%%%%%%
function [x_out,y_out] = cordic_rotate(x_in,y_in,phase_in)
% x_in      : in-phase
% y_in      : quadrature
% phase_in  : rotate phase
x_out = cos(phase_in).*x_in-sin(phase_in).*y_in;
y_out = sin(phase_in).*x_in+cos(phase_in).*y_in;
end