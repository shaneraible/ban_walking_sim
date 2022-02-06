rx = rx_from_bf(4.5e8, -40, 450, -15, 39);

time_samples = 0:1:1000;
bmi = 15:8:50;

transmitPower = -10;
totalDistance = 450;
wavelength = 4.1e8;

% plotting various received BMI over time
figure(1)
lineNames = strings(length(bmi));
angles = zeros(1,length(time_samples));
for i=1:length(bmi)
    rx = zeros(1,length(time_samples));
    for j=1:length(rx)
        angles(j) = 30*cos(time_samples(j)/(10*pi));
        rx(j) = rx_from_bf(wavelength, transmitPower, totalDistance, angles(j), bmi(i));
    end
    
    lineNames(i) = "BMI = " + bmi(i);
    plot(angles, rx, 'DisplayName', lineName);    
    hold all
end
title({'BMI vs Rx Power for typical walking motion', 'Receiver in hand, implanted device in abdomen'});
ylabel('Received Power dBm');
xlabel('Angle from body (degrees)');
legend(lineNames)
hold off


% plotting various received BMI over time
figure(2)
heights = 1.5:.1:2;
lineNames = strings(length(heights));
angles = zeros(1,length(time_samples));
for i=1:length(heights)
    deviceToHandLength = .35*heights(i)*.8*1000
    rx = zeros(1,length(time_samples));
    for j=1:length(rx)
        angles(j) = 30*cos(time_samples(j)/(10*pi));
        rx(j) = rx_from_bf(wavelength, transmitPower, deviceToHandLength, angles(j), 20);
    end
    
    lineNames(i) = "Height = " + heights(i) + "m";
    plot(angles, rx, 'DisplayName', lineName);    
    hold all
end
title({'Height vs Rx Power for typical walking motion, BMI=20', 'Receiver in hand, implanted device in abdomen, arm = 35% of height'});
ylabel('Received Power dBm');
xlabel('Angle from body (degrees)');
legend(lineNames)
hold off

