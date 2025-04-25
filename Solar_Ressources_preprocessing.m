% All values for 0° tilt
% Table with all data: solarwind
all0 = sum(solarwind(:,2:4),2);
% All the irradiance on the photovoltaic panel

mean0 = mean(all0); % Mean value for the 0° tilt panel
mean0 = double(mean0.sum(1)); % Energy produced per hour on average in W/m²

dayHour = sum(solarwind(:,17) ~= 0); % Number of hours when the sun is present
dayHour = double(dayHour.H_sun(1));

allSum0 = sum(all0);
allSum0 = double(allSum0.sum(1)); % Total energy produced in W/m²

meanDay0 = allSum0 / dayHour; % Average energy produced per hour during sunny hours in W/m²

% All values for 35° tilt
all35 = sum(solarwind(:,5:7),2);

mean35 = mean(all35); % Mean value for the 35° tilt panel
mean35 = double(mean35.sum(1)); % Energy produced per hour on average in W/m²

allSum35 = sum(all35);
allSum35 = double(allSum35.sum(1)); % Total energy produced in W/m²

meanDay35 = allSum35 / dayHour; % Average energy produced per hour during sunny hours in W/m²

% All values for 40° tilt
all40 = sum(solarwind(:,8:10),2);

mean40 = mean(all40); % Mean value for the 40° tilt panel
mean40 = double(mean40.sum(1)); % Energy produced per hour on average in W/m²

allSum40 = sum(all40);
allSum40 = double(allSum40.sum(1)); % Total energy produced in W/m²

meanDay40 = allSum40 / dayHour; % Average energy produced per hour during sunny hours in W/m²

% All values for 45° tilt
all45 = sum(solarwind(:,11:13),2);

mean45 = mean(all45); % Mean value for the 45° tilt panel
mean45 = double(mean45.sum(1)); % Energy produced per hour on average in W/m²

allSum45 = sum(all45);
allSum45 = double(allSum45.sum(1)); % Total energy produced in W/m²

meanDay45 = allSum45 / dayHour; % Average energy produced per hour during sunny hours in W/m²

% All values for 90° tilt
all90 = sum(solarwind(:,14:16),2);

mean90 = mean(all90); % Mean value for the 90° tilt panel
mean90 = double(mean90.sum(1)); % Energy produced per hour on average in W/m²

allSum90 = sum(all90);
allSum90 = double(allSum90.sum(1)); % Total energy produced in W/m²

meanDay90 = allSum90 / dayHour; % Average energy produced per hour during sunny hours in W/m²

% Best tilt = 35°
% Test with crystalline silicon technology, around 20% efficiency, at 35° tilt
% The mean demand was 60 kWh in 2024
aTMD = (kWhFour * 1000) / (meanDay35 * 0.2); % Area to match average demand
% If the panel produces 411 W/m² during all sunny hours, we need 733 m² of solar panels

prod35 = meanDay35 * 0.2;
newProd3517 = meanDay35 * 0.2 * (0.95^17); % After 17 years
newProd35 = meanDay35 * 0.2 * (0.95^25); % After 25 years
newATMD = (kWhFour * 1000) / newProd35; % Solar panel area after 25 years, accounting for 0.5% annual efficiency loss

% Graph representing the loss of solar panel efficiency

% Base data
meanDay35 = 411.47; % W/m²/day
initial_efficiency = 0.20;
degradation_5years = 0.95;

% Year vector
years = 0:25;

% Efficiency calculation
efficiency = initial_efficiency * (degradation_5years) .^ years;

% Daily production in W/m²
production_per_day = meanDay35 * efficiency;

% Specific year calculations
prod_year_0 = meanDay35 * 0.2 * (0.95^0);
prod_year_25 = meanDay35 * 0.2 * (0.95^25);

% Plot
figure;
plot(years, production_per_day, '-o', 'LineWidth', 2, 'Color', [0.2 0.6 1]);
hold on;

% Highlight points for year 0 and 25
plot(0, prod_year_0, 'r*', 'MarkerSize', 10, 'DisplayName', 'Year 0');
plot(25, prod_year_25, 'ms', 'MarkerSize', 10, 'DisplayName', 'Year 25');

% Annotations
text(0, prod_year_0 + 5, sprintf('%.2f W/m²/hour', prod_year_0), 'Color', 'red');
text(25, prod_year_25 + 5, sprintf('%.2f W/m²/hour', prod_year_25), 'Color', 'magenta');

% Formatting
title("Hourly production of a solar panel over 25 years");
xlabel("Years");
ylabel("Production (W/m²/hour)");
grid on;
legend("Production", "Year 0", "Year 25", 'Location', 'northeast');

% The peak demand was 110 kWh
aTMPD = (kWhFourMax * 1000) / (meanDay35 * 0.2); % Area to match peak demand
% If the panel produces 411 W/m² during all sunny hours, we need 1346 m² of solar panels

% Half of 35° values
n = floor(height(all35) / 2); % Find the lower half
half35 = all35(1:n, :); % Select the first n rows
Thalf35 = all35(n:height(all35), :);

figure;
plot(1:length(half35.sum), half35.sum, '-o', 'LineWidth', 2);
xlabel('Row index');
ylabel('half35');
title('Solar panel production at 35° tilt in 2022');
grid on;

figure;
plot(1:length(Thalf35.sum), Thalf35.sum, '-o', 'LineWidth', 2);
xlabel('Hour');
ylabel('W/m²');
title('Irradiance on 1m² with a 35° tilt solar panel in 2023');
grid on;

% Power output after 25 years
temp = newProd35 * 300;
temp = prod35 * 300;

% Solar panel output year 0
% Plot aggregated power for each configuration
figure;
hold on;

plot(1:length(Thalf35.sum), Thalf35.sum * 100 * 0.2, '-o', 'LineWidth', 2, 'Color', 'm');
legend({'solar panel'}, 'Location', 'best');
title('Electricity production with 100m² of solar panels after installation');

xlabel('Hour');
ylabel('Electricity production in Watts');
grid on;
hold off;
