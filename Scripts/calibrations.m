%% Part 1 sample points static
s = serialport("/dev/tty.usbmodem11303", 115200);
configureCallback(s, "off");
configureTerminator(s,"CR/LF");

NUM_SAMPLES = 10000;
acc = zeros(NUM_SAMPLES, 3);
BUFFER_SZ = NUM_SAMPLES*30;
% Get data from serial buffer
buffer = read(s, BUFFER_SZ, "string");
data = split(buffer, " ");

j = 1;
for i = 1:3:uint32(size(data, 1)/3)
   x = str2double(data(i+0))/10000.0;
   y = str2double(data(i+1))/10000.0;
   z = str2double(data(i+2))/10000.0;
   acc(j, 1) = x;
   acc(j, 2) = y;
   acc(j, 3) = z;
   j = j + 1;
end
save acc_samples.dat acc -ascii

%% Part 2 fit points
acc=load('acc_samples.dat');
acc_x = acc(1:8574,1);
acc_y = acc(1:8574,2);
acc_z = acc(1:8574,3);

figure(1);
hold on
histfit(acc_x);
pdx = fitdist(acc_x, 'Normal')
title("acceleration in x");
xlabel("acceleration in gs");
hold off

hold on
figure(2);
histfit(acc_y);
pdy = fitdist(acc_y, 'Normal')
title("acceleration in y");
xlabel("acceleration in gs");
hold off

figure(3);
hold on
histfit(acc_z);
pdz = fitdist(acc_z, 'Normal')
title("acceleration in z");
xlabel("acceleration in gs");
hold off

%% Part 2 sample points stationary acceleration
s = serialport("/dev/tty.usbmodem11303", 115200);
configureCallback(s, "off");
configureTerminator(s,"CR/LF");

NUM_SAMPLES = 3000;
acc = zeros(NUM_SAMPLES, 3);
BUFFER_SZ = NUM_SAMPLES*30;
% Get data from serial buffer
buffer = read(s, BUFFER_SZ, "string");
data = split(buffer, " ");

j = 1;
for i = 1:3:uint32(size(data, 1)/3)
   x = str2double(data(i+0))/10000.0;
   y = str2double(data(i+1))/10000.0;
   z = str2double(data(i+2))/10000.0;
   acc(j, 1) = x;
   acc(j, 2) = y;
   acc(j, 3) = z;
   j = j + 1;
end

%% Part 2 stationary acceleration variation
t = linspace(0,1000, size(acc, 1));
hold on
plot(t, acc(:,1), '-r');
plot(t, acc(:,2), '-b');
plot(t, acc(:,3), '-g');
hold off

%% Part 2 sample points dynamic acceleration
s = serialport("/dev/tty.usbmodem11303", 115200);
configureCallback(s, "off");
configureTerminator(s,"CR/LF");

NUM_SAMPLES = 3000;
acc = zeros(NUM_SAMPLES, 3);
BUFFER_SZ = NUM_SAMPLES*30;
% Get data from serial buffer
buffer = read(s, BUFFER_SZ, "string");
data = split(buffer, " ");

j = 1;
for i = 1:3:uint32(size(data, 1)/3)
   x = str2double(data(i+0))/10000.0;
   y = str2double(data(i+1))/10000.0;
   z = str2double(data(i+2))/10000.0;
   acc(j, 1) = x;
   acc(j, 2) = y;
   acc(j, 3) = z;
   j = j + 1;
end

%% Part 2 stationary dynamic acceleration variation
t = linspace(0,1000, size(acc, 1));
hold on
plot(t, acc(:,1), '-r');
plot(t, acc(:,2), '-b');
plot(t, acc(:,3), '-g');
hold off

