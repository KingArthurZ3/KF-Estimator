s = serialport("/dev/tty.usbmodem11303", 115200);
configureCallback(s, "off");
configureTerminator(s,"CR/LF");

NUM_SAMPLES = 2000;
position_data = zeros(NUM_SAMPLES, 3);
BUFFER_SZ = NUM_SAMPLES*30;
% Get data from serial buffer
buffer = read(s, BUFFER_SZ, "string");
data = split(buffer, " ");

j = 1;
for i = 1:3:uint32(size(position_data, 1)/3)
   x = str2double(data(i+0));
   y = str2double(data(i+1));
   z = str2double(data(i+2));
   position_data(j, 1) = x;
   position_data(j, 2) = y;
   position_data(j, 3) = z;
   j = j + 1;
end
delete(s);
%% plot position_data

t = linspace(0, 10, NUM_SAMPLES);
hold on
title("Estimated position");
plot(position_data(:,1), position_data(:,2));
% plot(t, position(:,2), '-g');
% plot(t, position(:,3), '-b');
legend("x", "y", "z");
hold off

%% Position data from screen output file

position_data = readmatrix("screenlog.txt");
target_pos = [0 0;
              14 0;
              14 -14
              0 -14
              0 0];
hold on
title("Estimated position vs Target Position");
plot(position_data(:,1), position_data(:,2), 'ob');
plot(target_pos(:,1), target_pos(:,2), '-r');
legend("Estimated position (cm)", "Target position (cm)");
xlabel("displacement (cm)");
ylabel("displacement (cm)");
hold off
print("Square-Test", "-dpng");