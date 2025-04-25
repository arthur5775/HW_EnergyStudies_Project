% Define list of river CSV files and corresponding names 
river_files = ["monkey-data/river-1.csv", "monkey-data/river-2.csv", "monkey-data/river-3.csv"];
river_names = ["River 1", "River 2", "River 3"];

% Define system configurations in a structure array
configs(1).name = "archimedes screw";
configs(1).percent_constraint = 0.5;
configs(1).eta = 0.75;

configs(2).name = "duct";
configs(2).percent_constraint = 0.1;
configs(2).eta = 0.84;

H = 8;
rho = 1000;
g = 9.81;
years = 2020:2024;

total_power = cell(1, length(configs));
days_aggregated = [];

total_power_generated = zeros(length(configs), length(years));

for r = 1:length(river_files)
    data = readmatrix(river_files(r));
    
    days = data(:, 1);          % Days from 0 to 365
    flow_data = data(:, 2:end); % Daily flow data

    if r == 1
        days_aggregated = days;
    end
    
    for c = 1:length(configs)
        eta = configs(c).eta;
        power_generated = eta * rho * g * H * flow_data * configs(c).percent_constraint;
        total_power_generated(c, :) = total_power_generated(c, :) + sum(power_generated, 1);
        
        fprintf('\nStatistics for %s on %s:\n', configs(c).name, river_names(r));
        for y = 1:length(years)
            max_power = max(power_generated(:, y))/1000;
            min_power = min(power_generated(:, y))/1000;
            mean_power = mean(power_generated(:, y))/1000;
            fprintf('Year %d - Max: %.2f W, Min: %.2f W, Mean: %.2f W\n', years(y), max_power, min_power, mean_power);
        end

        figure;
        hold on;
        colors = lines(size(flow_data, 2));
        for i = 1:size(flow_data, 2)
            plot(days, power_generated(:, i), '-o', 'LineWidth', 1.5, 'MarkerSize', 4, 'Color', colors(i, :));
        end
        title(['Power Generated per Day for Each Year on ' char(river_names(r)) ' with a ' char(configs(c).name)]);
        xlabel('Day of Year');
        ylabel('Power Generated (Watts)');
        xlim([0 365]);
        legend(arrayfun(@num2str, years, 'UniformOutput', false), 'Location', 'best');
        grid on;
        hold off;

        if r == 1
            total_power{c} = power_generated;
        else
            total_power{c} = total_power{c} + power_generated;
        end
    end
end

for c = 1:length(configs)
    figure;
    hold on;
    colors = lines(size(total_power{c}, 2));
    for i = 1:size(total_power{c}, 2)
        plot(days_aggregated, total_power{c}(:, i), '-o', 'LineWidth', 1.5, 'MarkerSize', 4, 'Color', colors(i, :));
    end
    title(['Aggregated Daily Power for Each Year with a ' char(configs(c).name)]);
    xlabel('Day of Year');
    ylabel('Aggregated Power Generated (Watts)');
    xlim([0 365]);
    legend(arrayfun(@num2str, years, 'UniformOutput', false), 'Location', 'best');
    grid on;
    hold off;
end

% === ADDED SECTION ===
% Display total power generated summary
disp('===================================');
disp('Total Energy Generated Per Year (Summed Across Rivers)');
disp('===================================');
for c = 1:length(configs)
    fprintf('\nConfiguration: %s\n', configs(c).name);
    for y = 1:length(years)
        fprintf('%d: %.2f kWh\n', years(y), total_power_generated(c, y) / 1000); % Convert watts to kWh
    end
end

% Calculate and display total max, min, and mean power per year
disp('===================================');
disp('Total Aggregated Power Statistics Across Rivers');
disp('===================================');
for c = 1:length(configs)
    fprintf('\nConfiguration: %s\n', configs(c).name);
    for y = 1:length(years)
        max_total = max(total_power{c}(:, y)) / 1000;
        min_total = min(total_power{c}(:, y)) / 1000;
        mean_total = mean(total_power{c}(:, y)) / 1000;
        fprintf('Year %d - Max: %.2f kW, Min: %.2f kW, Mean: %.2f kW\n', years(y), max_total, min_total, mean_total);
    end
end
disp('===================================');
tu 