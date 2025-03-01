% Read the CSV file
data = readtable('monkey-data/demand.csv', 'VariableNamingRule', 'preserve');

% Display the first few rows to check column names
disp(data(1:5, :));

% Extract data using actual column names
hours = data{:, 1};  % First column is hours
demand_2022 = data{:, 2}; % Second column is 2022
demand_2023 = data{:, 3}; % Third column is 2023
demand_2024 = data{:, 4}; % Fourth column is 2024

% Plot the demand
figure;
plot(hours, demand_2022, '-o', 'LineWidth', 1.5, 'DisplayName', '2022');
hold on;
plot(hours, demand_2023, '-s', 'LineWidth', 1.5, 'DisplayName', '2023');
plot(hours, demand_2024, '-d', 'LineWidth', 1.5, 'DisplayName', '2024');
hold off;

% Customize the plot
xlabel('Hour of the Day');
ylabel('Energy Used [kWh]');
title('Hourly Energy Demand (Last Three Years)');
legend;
grid on;

% Compute total demand per year
total_demand_2022 = sum(demand_2022);
total_demand_2023 = sum(demand_2023);
total_demand_2024 = sum(demand_2024);

% Display results
disp('===================================');
disp('Total Energy Demand Per Year');
disp('===================================');
fprintf('2022: %.2f kWh\n', total_demand_2022);
fprintf('2023: %.2f kWh\n', total_demand_2023);
fprintf('2024: %.2f kWh\n', total_demand_2024);
disp('===================================');
