t1 = 0:0.1:2*pi;
y1 = sin(t1);
t2 = 0:0.6:2*pi;
y2 = cos(t2);
plot(t1, y1, '-o', t2, y2, '-s');
grid on;
