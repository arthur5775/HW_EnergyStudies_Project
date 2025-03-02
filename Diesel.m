% Read the CSV file
data = readtable('monkey-data/demand.csv', 'VariableNamingRule', 'preserve');

% Extract data
hours = data{2:end, 1};  % First column is hours
demand_2022 = data{2:end, 2}; % Energy demand for 2022
demand_2023 = data{2:end, 3}; % Energy demand for 2023
demand_2024 = data{2:end, 4}; % Energy demand for 2024

% Calculate total yearly demand
total_demand_2022 = sum(demand_2022);
total_demand_2023 = sum(demand_2023);
total_demand_2024 = sum(demand_2024);

% Diesel generator max output (10% of yearly demand)
diesel_max_2022 = 0.1 * total_demand_2022;
diesel_max_2023 = 0.1 * total_demand_2023;
diesel_max_2024 = 0.1 * total_demand_2024;

% Distribute diesel output evenly across all hours
diesel_output_2022 = (diesel_max_2022 / length(hours)) * ones(size(hours));
diesel_output_2023 = (diesel_max_2023 / length(hours)) * ones(size(hours));
diesel_output_2024 = (diesel_max_2024 / length(hours)) * ones(size(hours));

% Plot energy demand
figure;
subplot(2,1,1) % First subplot for energy demand
plot(hours, demand_2022, '-o', 'LineWidth', 1.5, 'DisplayName', '2022');
hold on;
plot(hours, demand_2023, '-s', 'LineWidth', 1.5, 'DisplayName', '2023');
plot(hours, demand_2024, '-d', 'LineWidth', 1.5, 'DisplayName', '2024');
hold off;
xlabel('Hour of the Day');
ylabel('Energy Used [kWh]');
title('Hourly Energy Demand (Last Three Years)');
legend;
grid on;

% Plot diesel generator output
subplot(2,1,2) % Second subplot for diesel output
plot(hours, diesel_output_2022, '--r', 'LineWidth', 1.5, 'DisplayName', 'Diesel 2022');
hold on;
plot(hours, diesel_output_2023, '--g', 'LineWidth', 1.5, 'DisplayName', 'Diesel 2023');
plot(hours, diesel_output_2024, '--b', 'LineWidth', 1.5, 'DisplayName', 'Diesel 2024');
hold off;
xlabel('Hour of the Day');
ylabel('Diesel Output [kWh]');
title('Diesel Generator Output (10% of Yearly Demand)');
legend;
grid on;

% Display results
disp('===================================');
disp('Diesel Generator Allowed Energy Output Per Year');
disp('===================================');
fprintf('2022: %.2f kWh\n', diesel_max_2022);
fprintf('2023: %.2f kWh\n', diesel_max_2023);
fprintf('2024: %.2f kWh\n', diesel_max_2024);
disp('===================================');
