% Lab. darbas Nr. 2 Justinas Kuklis
clc;
clear all;
x = 0.1:1/22:1;
d = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2; % Norime gauti tokį atsakymą

eta = 0.3; %Mokymosi greitis
klaidos_suma = 1; % Užduodama tik tam, kad veiktų while ciklas
neuronai = 4;

%% Užduodame rand vertes svoriams ir bias
w1 = randn(neuronai, 1); % Svoriai tarp įėjimo ir paslėptojo sluoksnio
w2 = randn(neuronai, 1); % Svoriai tarp paslėptojo ir išėjimo sluoksnio
b1 = randn(neuronai, 1); % Bias paslėptame sluoksnyje
b2 = randn(1);           % Bias išėjimo sluoksnyje

for i = 1:neuronai
fprintf('Sugeneruotos vertės aplink %d-ąjį neuroną:\n w%d1_1 = %f; w1%d_2 = %f; b%d_1 = %f\n', i, i, w1(i), i, w2(i), i, b1(i));
end
fprintf('Sugeneruotas išėjimo bias %f\n\n', b2);

%% Pasvertos sumos ir tinklo atsakai
while klaidos_suma > 0.005
    for i = 1:length(x)
        % Paslėpto sluoksnio pasverta suma
        v1 = w1 * x(i) + b1; 
        
        % Paslėpto sluoksnio atsakas
        y1 = 1 ./ (1 + exp(-v1));

        % Išėjimo sluoksnio pasverta suma
        v2 = w2' * y1 + b2;

        % Išėjimo atsakas
        y2 = v2;
    
        %Skaičiuojama klaida
        klaida = d(i) - y2;
        % fprintf('Suskaičiuota klaida e= %f\n', klaida);
    
        %Skaičiuojame delta
        delta2 = klaida; % Išėjimo delta
        for k = 1:neuronai
            delta1(k) = y1(k) * (1-y1(k)) * delta2 * w2(k);
        end
      
        %Atnaujiname svorius ir kitus koef.
        w2 = w2 + eta * delta2 * y1;
        b2 = b2 + eta * delta2;

        w1 = w1 + eta * delta1' * x(i);
        b1 = b1 + eta * delta1';
      
    end

klaidos_suma = sum(abs(klaida));
%fprintf('Bendra susumuota klaida: %f\n', klaidos_suma);
end
fprintf('Bendra susumuota klaida: %f\n', klaidos_suma);
%disp(w1');
fprintf('Atnaujinti koeficientai\n w1: %f w2: %f b1: %f b2: %f\n', w1', w2', b1', b2);

%% Braižome grafiką
v1_gal = w1 * x + b1;
y1_gal = 1 ./ (1 + exp(-v1_gal));
v2_gal = w2' * y1_gal + b2;
y_galutinis = v2_gal;

figure(1)
plot(x, d);
hold on;
plot(x, y_galutinis, 'r--', 'LineWidth', 2);
hold off;
grid on;
legend('Norima funkcija', 'Nuspėtas atsakas');

%% Testuojame ir braižome grafiką
x1 = linspace(0.1, 1, 200);
d1 = (1 + 0.6*sin(2*pi*x1/0.7) + 0.3*sin(2*pi*x1))/2; % Norime gauti tokį atsakymą

% Paslėpto sluoksnio pasverta suma
v1_gal1 = w1 * x1 + b1; 

% Paslėpto sluoksnio atsakas
y1_gal1 = 1 ./ (1 + exp(-v1_gal1));

% Išėjimo sluoksnio pasverta suma
v2_gal1 = w2' * y1_gal1 + b2;

% Išėjimo atsakas
y2_gal1 = v2_gal1;

figure(2)
plot(x1, d1);
hold on;
plot(x1, y2_gal1, 'r--', 'LineWidth', 2);
hold off;
grid on;
legend('Norima funkcija', 'Nuspėtas atsakas');