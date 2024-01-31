% Loop over each Drehzahl plateau
for plateauIndex = 1:length(plateauStartTimes)
    % Extract data within the current plateau time window
    startTime = plateauStartTimes(plateauIndex);
    endTime = plateauEndTimes(plateauIndex);
    
    externalDrehzahl = n_mech_extern(n_mech_extern(:, 2) >= startTime & n_mech_extern(:, 2) <= endTime, 1);
    internalDrehzahl = interp1(frq_el_intern(:, 2), frq_el_intern(:, 1), ...
                               n_mech_extern(:, 2), 'linear', 'extrap');
    internalDrehzahl = internalDrehzahl(n_mech_extern(:, 2) >= startTime & n_mech_extern(:, 2) <= endTime);

    % Calculate absolute deviation
    absoluteDeviation(plateauIndex) = mean(abs(externalDrehzahl - internalDrehzahl));

    % Calculate percentage deviation
    percentageDeviation(plateauIndex) = mean(abs((externalDrehzahl - internalDrehzahl) ./ externalDrehzahl)) * 100;
end

% Display or use the calculated deviations as needed
disp('Absolute Deviation for each plateau:');
disp(absoluteDeviation);

disp('Percentage Deviation for each plateau:');
disp(percentageDeviation);
