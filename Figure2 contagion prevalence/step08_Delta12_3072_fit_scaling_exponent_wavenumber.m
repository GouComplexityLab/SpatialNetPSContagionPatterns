clear all
close all
clc 

load data_calc_Sim_sk_Delta12_3072p=0.300.mat datSk2 

data = datSk2;
meanqmax = zeros(length(data), 1); % 存储平均值
stdqmax = zeros(length(data), 1); % 存储方差

for i=1:length(data)
    qmaxValues = data(i, 2:end);
    meanqmax(i) = mean(qmaxValues, 'omitnan'); % 计算平均值，忽略NaN值
    stdqmax(i) = std(qmaxValues, 'omitnan'); 
end

timeseries = data(:,1);

meanqmax = meanqmax';
timeseries = timeseries';

% Extract the data segment for fitting
x_data = timeseries(398:500);
y_data = meanqmax(398:500);

% x_data = timeseries(360:500);
% y_data = meanqmax(360:500);



% Remove any zeros or negative values (log scale requires positive values)
valid_indices = (x_data > 0) & (y_data > 0);
x_fit = x_data(valid_indices);
y_fit = y_data(valid_indices);

% Linear transformation: take logarithm on both sides
log_x = log(x_fit);
log_y = log(y_fit);

% Perform linear regression on transformed data
% Fit log(y) = log(a) + b*log(x)
[p, S] = polyfit(log_x, log_y, 1);
b = p(1);          % Power exponent
a = exp(p(2));     % Coefficient

% Calculate confidence intervals for parameters
alpha = 0.05; % 95% confidence level
[Y_fit, delta] = polyval(p, log_x, S);

% Calculate standard errors and confidence intervals
n = length(log_x); % Number of data points
residuals = log_y - Y_fit;
RSS = sum(residuals.^2); % Residual sum of squares
MSE = RSS/(n-2); % Mean squared error

% Standard errors for parameters
X_design = [ones(n,1), log_x']; % Design matrix
cov_matrix = MSE * inv(X_design' * X_design);
se_b = sqrt(cov_matrix(2,2)); % Standard error of b
se_loga = sqrt(cov_matrix(1,1)); % Standard error of log(a)

% t-value for 95% confidence interval
t_val = tinv(1-alpha/2, n-2);

% Confidence intervals
b_CI = [b - t_val * se_b, b + t_val * se_b];
loga_CI = [p(2) - t_val * se_loga, p(2) + t_val * se_loga];
a_CI = exp(loga_CI); % Transform back to original scale

% Calculate R-squared value
SS_res = sum((log_y - Y_fit).^2);
SS_tot = sum((log_y - mean(log_y)).^2);
R_squared = 1 - (SS_res / SS_tot);

% Generate fitted curve
x_fit_range = linspace(min(x_fit), max(x_fit), 100);
y_fit_range = a * x_fit_range.^b;

% Plot original data and fitted curve
figure;
set(gcf, 'position', [100 100 600 500], 'color', 'w');
hold on

% Plot original data
loglog(x_fit, y_fit, 'D', 'markersize', 6, 'color', 'magenta', 'DisplayName', 'Original data');
% Plot fitted curve
loglog(x_fit_range, y_fit_range, 'b-', 'linewidth', 2, 'DisplayName', sprintf('Fit: y = %.4f x^{%.4f}', a, b));

% Add legend and labels
legend('Location', 'best', 'FontSize', 12, 'FontName', 'Times');
xlabel('Time Series', 'FontSize', 14, 'FontName', 'Times');
ylabel('Mean Wavelength', 'FontSize', 14, 'FontName', 'Times');
title(sprintf('Power Law Fit (R² = %.4f)', R_squared), 'FontSize', 16, 'FontName', 'Times');

% Set axis properties
set(gca, 'XScale', 'log', 'YScale', 'log');
set(gca, 'FontSize', 12, 'LineWidth', 2, 'XMinorTick', 'off', 'YMinorTick', 'off', ...
    'TickLength', [0.025 0.01]);
set(gca, 'FontName', 'Times');
% grid on;

% Display fitting results with confidence intervals
fprintf('Power Law Fitting Results:\n');
fprintf('y = a * x^b\n');
fprintf('Coefficient a = %.6f\n', a);
fprintf('95%% Confidence Interval for a: [%.6f, %.6f]\n', a_CI(1), a_CI(2));
fprintf('Power exponent b = %.6f\n', b);
fprintf('95%% Confidence Interval for b: [%.6f, %.6f]\n', b_CI(1), b_CI(2));

fprintf('95%% Confidence Interval for b: [%.6f, %.6f]\n', b_CI(1)-b, b_CI(2)-b);

fprintf('Goodness of fit R² = %.6f\n', R_squared);
fprintf('Number of data points: %d\n', n);

hold off