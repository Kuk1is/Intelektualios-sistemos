% Lab. darbas Nr3 Justinas Kuklis
clc;
clear all;

x = 0.1:1/22:1;
d = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2;

eta = 0.1; % Mokymo žingsnis
e_total = 1; % Pradinė klaida, kad ciklas prasidėtų
e = zeros(1, length(x)); % Klaidos talpinimui

%% Užduodame vertes
c1 = 0.19; % Pirmos Gauso funkcijos centras
c2 = 0.91; % Antros Gauso funkcijos centras
r1 = 0.2; % Pirmos Gauso funkcijos spindulys
r2 = 0.2; % Antros Gauso funkcijos spindulys

w1 = randn(1);
w2 = randn(1);
w0 = randn(1);

for epochos = 1:10000
    for i = 1:length(x)

        % Suskaičiuojame Gausines funkcijas
        F1 = exp(-(x(i) - c1)^2 / (2 * r1^2));
        F2 = exp(-(x(i) - c2)^2 / (2 * r2^2));

        % Skaičiuojame išėjimą
        v = w1 * F1 + w2 * F2 + w0;
        y = v;

        % Skaičiuojame klaidą
        e(i) = d(i) - y;
        % Atnaujiname svorius
        w1 = w1 + eta * e(i) * F1;
        w2 = w2 + eta * e(i) * F2;
        w0 = w0 + eta * e(i);
    end

    e_total = sum(e.^2);
    % fprintf(' Bendras klaida = %f\n', e_total);
end
% fprintf('Galutinės atnaujintos vertės:\n e = %f, w1 = %f, w2 = %f, w0 = %f\n', e, w1, w2, w0);
% fprintf(' Bendras klaida = %f\n', e_total);


%% Testuojame
F1_final = exp(-(x - c1).^2 / (2 * r1^2));
F2_final = exp(-(x - c2).^2 / (2 * r2^2));
y_final = F1_final*w1 + F2_final*w2 + w0;

% Visualizuojame rezultatus
figure(3);
plot(x, d);
hold on;
plot(x, y_final, 'r--', 'LineWidth', 2);
hold off;
legend('Tikroji reikšmė', 'Modelio prognozė');
grid on;