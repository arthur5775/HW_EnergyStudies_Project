% Read the CSV file
data = readtable('monkey-data/demand.csv', 'VariableNamingRule', 'preserve');
% Extract data using actual column names
hours = data{2:end, 1};  % First column is hours
demand_2022 = data{2:end, 2};
demand_2023 = data{2:end, 3};
demand_2024 = data{2:end, 4};
% Compute average demand across the three years
mean_demand = (demand_2022 + demand_2023 + demand_2024) / 3;
% Sample every 24th point to reduce clutter
step = 24;
sampled_hours = hours(1:step:end);
sampled_mean_demand = mean_demand(1:step:end);
% Convert hours to days (assuming hourly data)
days = hours / 24;
% Sample every 4th point
sampled_days = days(1:step:end);
% Plot with days instead of hours
figure('Color', 'w');
plot(sampled_days, sampled_mean_demand, 'Color', [0.3010 0.7450 0.9330], 'LineWidth', 2, 'DisplayName', 'Average 2022–2024');
% Customize the plot
xlabel('Day of the Year', 'FontSize', 12, 'FontWeight', 'bold'); % <-- modifié ici
ylabel('Average Energy Used [kWh]', 'FontSize', 12, 'FontWeight', 'bold');
title('Average Daily Energy Demand (2022–2024)', 'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'best');
grid on;
box on;
set(gca, 'FontSize', 11);
xlim([0 365]);
% Display average stats
fprintf('\n===================================\n');
fprintf('Average of Energy Demand (2022–2024)\n');
fprintf('===================================\n');
fprintf('Total = %.2f kWh, Mean = %.2f kWh, Max = %.2f kWh, Min = %.2f kWh\n', ...
    sum(mean_demand), mean(mean_demand), max(mean_demand), min(mean_demand));
fprintf('===================================\n');
% Display stats per year
fprintf('Total, Mean, Max and Min Energy Demand Per Year\n');
fprintf('===================================\n');
fprintf('2022: Total = %.2f kWh, Mean = %.2f kWh, Max = %.2f kWh, Min = %.2f kWh\n', ...
    sum(demand_2022), mean(demand_2022), max(demand_2022), min(demand_2022));
fprintf('2023: Total = %.2f kWh, Mean = %.2f kWh, Max = %.2f kWh, Min = %.2f kWh\n', ...
    sum(demand_2023), mean(demand_2023), max(demand_2023), min(demand_2023));
fprintf('2024: Total = %.2f kWh, Mean = %.2f kWh, Max = %.2f kWh, Min = %.2f kWh\n', ...
    sum(demand_2024), mean(demand_2024), max(demand_2024), min(demand_2024));
fprintf('===================================\n');
% Find and print the day of max and min for each year
[~, idx_max_2022] = max(demand_2022);
[~, idx_min_2022] = min(demand_2022);
[~, idx_max_2023] = max(demand_2023);
[~, idx_min_2023] = min(demand_2023);
[~, idx_max_2024] = max(demand_2024);
[~, idx_min_2024] = min(demand_2024);
day_max_2022 = hours(idx_max_2022) / 24;
day_min_2022 = hours(idx_min_2022) / 24;
day_max_2023 = hours(idx_max_2023) / 24;
day_min_2023 = hours(idx_min_2023) / 24;
day_max_2024 = hours(idx_max_2024) / 24;
day_min_2024 = hours(idx_min_2024) / 24;
fprintf('\nDay of Peak (Max) and Lowest (Min) Energy Demand\n');
fprintf('===================================\n');
fprintf('2022: Max on day %.1f, Min on day %.1f\n', day_max_2022, day_min_2022);
fprintf('2023: Max on day %.1f, Min on day %.1f\n', day_max_2023, day_min_2023);
fprintf('2024: Max on day %.1f, Min on day %.1f\n', day_max_2024, day_min_2024);
fprintf('===================================\n');





% Compute average demand across the three years
mean_demand = (demand_2022 + demand_2023 + demand_2024) / 3;
% Sample every 24th point to reduce clutter
step = 24;
sampled_hours = hours(1:step:end);
sampled_mean_demand = mean_demand(1:step:end);
% Convert hours to days (assuming hourly data)
days = hours / 24;
% Sample every 4th point
sampled_days = days(1:step:end);
% Identify summer and winter days
summer_days = (sampled_days >= 152 & sampled_days <= 243); % June to August
winter_days = (sampled_days <= 59 | sampled_days >= 335); % December, January, February
% Calculate the average demand for summer and winter days
mean_demand_summer = mean(sampled_mean_demand(summer_days));
mean_demand_winter = mean(sampled_mean_demand(winter_days));
% Plot the comparison
figure('Color', 'w');
hold on;
bar(1, mean_demand_summer, 'FaceColor', [0.3010 0.7450 0.9330], 'EdgeColor', 'black', 'LineWidth', 1.5, 'DisplayName', 'Summer (Jun-Aug)');
bar(2, mean_demand_winter, 'FaceColor', [0.8500 0.3250 0.0980], 'EdgeColor', 'black', 'LineWidth', 1.5, 'DisplayName', 'Winter (Dec-Feb)');
% Customize the plot
set(gca, 'XTick', [1 2], 'XTickLabel', {'Summer', 'Winter'});
xlabel('Season', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Average Energy Used [kWh]', 'FontSize', 12, 'FontWeight', 'bold');
title('Average Daily Energy Demand Comparison: Summer vs Winter (2022–2024)', 'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'best');
grid on;
box on;
set(gca, 'FontSize', 11);
% Display comparison statistics
fprintf('\n===================================\n');
fprintf('Average Energy Demand Comparison\n');
fprintf('===================================\n');
fprintf('Summer Average = %.2f kWh, Winter Average = %.2f kWh\n', mean_demand_summer, mean_demand_winter);
fprintf('===================================\n');





% Identify summer and winter days
summer_days = (days >= 152 & days <= 243); % June to August
winter_days = (days <= 59 | days >= 335); % December, January, February
% Initialize arrays to hold the mean demand for each hour (1 to 24) for summer and winter
mean_demand_summer_hourly = zeros(1, 24);
mean_demand_winter_hourly = zeros(1, 24);
% Loop through each hour of the day (1 to 24)
for hour = 1:24
    % Get the indices for the current hour in summer and winter
    summer_hour_indices = summer_days & (mod(hours, 24) == (hour - 1)); % Hour indices for summer
    winter_hour_indices = winter_days & (mod(hours, 24) == (hour - 1)); % Hour indices for winter
    % Calculate the mean demand for this hour for summer and winter
    mean_demand_summer_hourly(hour) = mean(mean_demand(summer_hour_indices));
    mean_demand_winter_hourly(hour) = mean(mean_demand(winter_hour_indices));
end
% Plot the hourly comparison for summer vs winter
figure('Color', 'w');
hold on;
plot(1:24, mean_demand_summer_hourly, 'o-', 'Color', [0.3010 0.7450 0.9330], 'LineWidth', 2, 'DisplayName', 'Summer (Jun-Aug)');
plot(1:24, mean_demand_winter_hourly, 'o-', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 2, 'DisplayName', 'Winter (Dec-Feb)');
% Customize the plot
xlabel('Hour of the Day', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Average Energy Used [kWh]', 'FontSize', 12, 'FontWeight', 'bold');
title('Hourly Average Energy Demand Comparison: Summer vs Winter (2022–2024)', 'FontSize', 14, 'FontWeight', 'bold');
legend('Location', 'best');
grid on;
box on;
set(gca, 'FontSize', 11);
xlim([1 24]);
% Display comparison statistics for each hour
fprintf('\n===================================\n');
fprintf('Hourly Average Energy Demand Comparison\n');
fprintf('===================================\n');
for hour = 1:24
    fprintf('Hour %d: Summer = %.2f kWh, Winter = %.2f kWh\n', ...
        hour, mean_demand_summer_hourly(hour), mean_demand_winter_hourly(hour));
end
fprintf('===================================\n');
