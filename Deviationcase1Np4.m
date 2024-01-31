% Load data from Messdaten.mat
load('Messdaten.mat');

% Extract data within the specified time window for each Drehzahl plateau
% Replace these values with the actual start and end times of the plateaus
plateau1StartTime = 100;  % Replace with actual start time
plateau1EndTime = 150;    % Replace with actual end time

plateau2StartTime = 200;  % Replace with actual start time
plateau2EndTime = 250;    % Replace with actual end time

% Extract data for each plateau
plateau1Data = n_mech_extern(n_mech_extern(:, 2) >= plateau1StartTime & n_mech_extern(:, 2) <= plateau1EndTime, :);
plateau2Data = n_mech_extern(n_mech_extern(:, 2) >= plateau2StartTime & n_mech_extern(:, 2) <= plateau2EndTime, :);

% Calculate the external Drehzahl for each plateau
externalDrehzahlPlateau1 = mean(plateau1Data(:, 1));
externalDrehzahlPlateau2 = mean(plateau2Data(:, 1));

% Extract Elektrische Rotorfrequenz data
time_frq_el_intern = frq_el_intern(:, 2);
frq_el_intern_data = frq_el_intern(:, 1);

% Set Np to 4
Np = 4;

% Calculate internal Drehzahl based on Np
n_mech_internal = 60 * frq_el_intern_data / Np;

% Interpolate the calculated internal Drehzahl to match the time points of n_mech_extern
internalDrehzahlInterpolated = interp1(time_frq_el_intern, n_mech_internal, n_mech_extern(:, 2), 'linear', 'extrap');

% Calculate the internal Drehzahl for each plateau
internalDrehzahlPlateau1 = mean(internalDrehzahlInterpolated(n_mech_extern(:, 2) >= plateau1StartTime & n_mech_extern(:, 2) <= plateau1EndTime));
internalDrehzahlPlateau2 = mean(internalDrehzahlInterpolated(n_mech_extern(:, 2) >= plateau2StartTime & n_mech_extern(:, 2) <= plateau2EndTime));

% Calculate deviation for each plateau
deviationPlateau1 = mean(abs(externalDrehzahlPlateau1 - internalDrehzahlPlateau1));
deviationPlateau2 = mean(abs(externalDrehzahlPlateau2 - internalDrehzahlPlateau2));

% Display the results or use them as needed
disp('Plateau 1 - Deviation for Np = 4:');
disp(deviationPlateau1);

disp('Plateau 2 - Deviation for Np = 4:');
disp(deviationPlateau2);

% Plot the graph
figure;

subplot(2,1,1);
plot(n_mech_extern(:, 2), n_mech_extern(:, 1), 'DisplayName', 'External Drehzahl');
hold on;
plot(n_mech_extern(:, 2), internalDrehzahlInterpolated, 'DisplayName', 'Internal Drehzahl (Np = 4)');
xlabel('Zeit in s');
ylabel('Drehzahl in rpm');
title('Plateau 1 - External and Internal Drehzahl');
legend;
grid on;

subplot(2,1,2);
bar([1, 2], [externalDrehzahlPlateau2, internalDrehzahlPlateau2], 0.5, 'DisplayName', 'External and Internal Drehzahl');
xticks([1, 2]);
xticklabels({'External', 'Internal (Np = 4)'});
xlabel('Drehzahl Type');
ylabel('Mean Drehzahl in rpm');
title('Plateau 2 - External and Internal Drehzahl');
legend;
grid on;
