clc;
clear;
close all;

randomBinaryNumbers = randi([0, 1], 1, 10);
bp=1;
fprintf('Original message:');
fprintf('%d', randomBinaryNumbers);

fc=10;
fs=100;
t1=bp/100:bp/100:bp;
sin_wave =[];

for i=1:1:length(randomBinaryNumbers)

    if (randomBinaryNumbers(i)==1)
        y =10*sin(2*pi*4*t1);
    else
        y = 5*sin(2*pi*4*t1);
    end

    sin_wave = [sin_wave y];
end
%%
t2 = bp/100:bp/100:bp*length(randomBinaryNumbers);

ka = 1;

ct = 2*cos(2*pi*5*t2);
AM = ct.*(1+ka*sin_wave);

subplot(2, 1, 1);
plot(t2, sin_wave);
xlabel('Time(sec)');
ylabel('Amplitude');
title('amplitude Modulation');

subplot(2, 1, 2);
plot(t2, AM);
xlabel('Time(sec)');
ylabel('Amplitude');
title('amplitude Modulation');
