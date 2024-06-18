%%SISTEMAS DIFERENCIALES
clc;
clear;
close all;

% Parámetros del sistema
num = [2 1.5]; % Numerador de la función de transferencia
den = [3 -0.7 1.2]; % Denominador de la función de transferencia
%%
% Crear la función de transferencia
sys = tf(num, den, -1, 'Variable', 'z^-1');
%%
% Mostrar la función de transferencia
disp('Función de transferencia del sistema:');
sys;
%%
% Obtener la respuesta al impulso
[h, t] = impz(num, den);
disp('Respuesta al impulso (h[n]):');
disp(h');
%%
% Graficar la respuesta al impulso
figure;
stem(t, h);
title('Respuesta al Impulso');
xlabel('n');
ylabel('h[n]');
grid on;
%%
% Obtener la respuesta a la entrada cero (y[n] = 0)
n = length(h); % número de muestras
u = zeros(1, n); % entrada cero
y_entrada_cero = filter(num, den, u);
disp('Respuesta a la entrada cero (y_entrada_cero[n]):');
disp(y_entrada_cero);
%%
% Graficar la respuesta a la entrada cero
figure;
stem(t, y_entrada_cero);
title('Respuesta a la Entrada Cero');
xlabel('n');
ylabel('y_{entrada\_cero}[n]');
grid on;
%%
% Obtener la respuesta al estado cero (y[n] con x(0)=0)
x0 = zeros(1, max(length(num), length(den))-1); % condiciones iniciales
y_estado_cero = filter(num, den, u, x0);
disp('Respuesta al estado cero (y_estado_cero[n]):');
disp(y_estado_cero);
%%
% Graficar la respuesta al estado cero
figure;
stem(t, y_estado_cero);
title('Respuesta al Estado Cero');
xlabel('n');
ylabel('y_{estado\_cero}[n]');
grid on;
%%
% Obtener la respuesta total (combinar impulso y entrada cero)
y_total = y_entrada_cero + y_estado_cero;
disp('Respuesta Total (y_total[n]):');
disp(y_total);
%%
% Graficar la respuesta total
figure;
stem(t, y_total);
title('Respuesta Total');
xlabel('n');
ylabel('y_{total}[n]');
grid on;
%%
% Obtener la respuesta total al escalón con condiciones iniciales cero
u_escalon = ones(1, n); % entrada escalón
y_escalon = filter(num, den, u_escalon);
disp('Respuesta al Escalón con Condiciones Iniciales Cero (y_escalon[n]):');
disp(y_escalon);
%%
% Graficar la respuesta total al escalón con condiciones iniciales cero
figure;
stem(t, y_escalon);
title('Respuesta al Escalón con Condiciones Iniciales Cero');
xlabel('n');
ylabel('y_{escalon}[n]');
grid on;
%%
% Mostrar todas las respuestas simbólicas
syms z
Hz = poly2sym(num, z) / poly2sym(den, z);
disp('Función de transferencia simbólica H(z):');
pretty(Hz)
%%
disp('Respuesta simbólica al impulso:');
h_sym = iztrans(Hz);
pretty(h_sym)
%%
disp('Respuesta simbólica al escalón:');
u_sym = 1/(1-z^-1);
y_escalon_sym = iztrans(Hz * u_sym);
pretty(y_escalon_sym)

