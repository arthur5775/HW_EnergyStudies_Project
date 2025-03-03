% Read the CSV file
data = readtable('monkey-data/demand.csv', 'VariableNamingRule', 'preserve');

% Display the first few rows to check column names
disp(data(1:5, :));

% Extract data using actual column names
hours = data{2:end, 1};  % First column is hours
demand_2022 = data{2:end, 2}; % Second column is 2022 demand
demand_2023 = data{2:end, 3}; % Third column is 2023 demand
demand_2024 = data{2:end, 4}; % Fourth column is 2024 demand

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

% Compute total, mean, and max demand per year
total_demand_2022 = sum(demand_2022);
total_demand_2023 = sum(demand_2023);
total_demand_2024 = sum(demand_2024);

mean_demand_2022 = mean(demand_2022);
mean_demand_2023 = mean(demand_2023);
mean_demand_2024 = mean(demand_2024);

max_demand_2022 = max(demand_2022(:));  % Ensure it's applied to numerical data
max_demand_2023 = max(demand_2023(:));
max_demand_2024 = max(demand_2024(:));

min_demand_2022 = min(demand_2022);
min_demand_2023 = min(demand_2023);
min_demand_2024 = min(demand_2024);

% Display results
disp('===================================');
disp('Total, Mean, Max and Min Energy Demand Per Year');
disp('===================================');
fprintf('2022: Total = %.2f kWh, Mean = %.2f kWh, Max = %.2f kWh, Min = %.2f kWh\n', total_demand_2022, mean_demand_2022, max_demand_2022, min_demand_2022);
fprintf('2023: Total = %.2f kWh, Mean = %.2f kWh, Max = %.2f kWh, Min = %.2f kWh\n', total_demand_2023, mean_demand_2023, max_demand_2023, min_demand_2023);
fprintf('2024: Total = %.2f kWh, Mean = %.2f kWh, Max = %.2f kWh, Min = %.2f kWh\n', total_demand_2024, mean_demand_2024, max_demand_2024, min_demand_2024);
disp('===================================');
