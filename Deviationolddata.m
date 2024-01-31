Ex_D = xlsread('Data.xlsx');
x1 = Ex_D(:,1); %Zeit in s
y1 = Ex_D(:,2); %externes Drehzahlsignal in rpm

x2 = Ex_D(:,3); %Zeit in s
y2 = Ex_D(:,4); %Elektrische Rotorfrequenz in Hz

Np = 4
y3 = 60*y2/Np; %Umwandlung

Dev_Ab = abs(y1-y3)
Dev_Pe = abs(y1-y3)./y1*100

figure(1)
plot(x1, Dev_Ab,'-','MarkerSize',20);
xlim([0 400])
ylim([0 200])
title("Absolute Abweichung")
xlabel("Zeit in s")
ylabel("Absolute Drehzahlsabweichung in rpm")
grid

figure(2)
plot(x1, Dev_Pe,'-','MarkerSize',20);
xlim([0 400])
ylim([0 10])
title("Prozentuale Abweichung")
xlabel("Zeit in s")
ylabel("Prozentuale Drehzahlsabweichung [%]")
grid
