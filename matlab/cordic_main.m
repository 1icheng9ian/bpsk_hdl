clear
clc
phase = (0:0.1:pi)';
for i = 1:length(phase)
    [cos_out(i),sin_out(i)] = cordic(phase(i));
end
plot(phase,cos_out)
hold on
plot(phase,sin_out)