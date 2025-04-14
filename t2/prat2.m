% Función de transferencia G(s) = 3 / (s^2 + 2s + 3)
num = [3];
den = [1 2 3];
Gs = tf(num, den); % sistema continuo

% Respuesta al impulso
figure;
impulse(Gs);
title('Respuesta al impulso');
grid on;

% Respuesta al escalón
figure;
step(Gs);
title('Respuesta al escalón');
grid on;

% Respuesta al escalón almacenada
[y_step, t_step] = step(Gs);

% Graficar
figure;
plot(t_step, y_step, 'b', 'LineWidth', 1.5);
xlabel('Tiempo (s)');
ylabel('Salida');
title('Respuesta al escalón - almacenada');
grid on;


delay = 2; % segundos
Gs_delay = tf(num, den, 'InputDelay', delay);


% Impulso con retardo
figure;
impulse(Gs_delay);
title('Respuesta al impulso con retardo');
grid on;

% Escalón con retardo
figure;
step(Gs_delay);
title('Respuesta al escalón con retardo');
grid on;


% Respuesta escalón con delay en vectores
[y_d, t_d] = step(Gs_delay);
[max_val, idx_max] = max(y_d);
t_max = t_d(idx_max);

figure;
plot(t_d, y_d, 'b', 'LineWidth', 1.5);
hold on;
plot(t_max, max_val, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
title('Respuesta al escalón con retardo - Valor máximo');
xlabel('Tiempo (s)');
ylabel('Salida');
legend('Respuesta', 'Máximo');
grid on;


% Buscar el primer índice donde la respuesta supera un umbral
umbral = 0.01; % puedes ajustar este valor
idx_inicio = find(y_d > umbral, 1);
tiempo_inicio = t_d(idx_inicio);

fprintf('El sistema comienza a responder a partir de t = %.2f s\n', tiempo_inicio);


t = 0:0.1:30; % tiempo de 0 a 20 segundos
u = zeros(size(t));

% Construcción de una señal arbitraria
u(t >= 10 & t < 20) = 5;
u(t >= 20) = 10;


% Graficar señal
figure;
plot(t, u, 'k', 'LineWidth', 1.5);
xlabel('Tiempo (s)');
ylabel('Entrada u(t)');
title('Señal arbitraria');
grid on;

% Usamos la misma Gs del primer literal
y = lsim(Gs, u, t);

% Graficar la respuesta
figure;
plot(t, y, 'b', 'LineWidth', 1.5);
xlabel('Tiempo (s)');
ylabel('Salida y(t)');
title('Respuesta del sistema a señal arbitraria');
grid on;





t = 0:0.1:40; % tiempo de 0 a 20 segundos
e = zeros(size(t));

% Construcción de una señal arbitraria
e(t >= 10 & t < 20) = 5;


idx = t >= 20 & t < 30;
e(idx) = linspace(15, 25, sum(idx));

e(t >= 30) = 25;

% Graficar señal
figure;
plot(t, e, 'k', 'LineWidth', 1.5);
xlabel('Tiempo (s)');
ylabel('Entrada u(t)');
title('Señal arbitraria');
grid on;

% Usamos la misma Gs del primer literal
y_2 = lsim(Gs, e, t);

% Graficar la respuesta
figure;
plot(t, y_2, 'b', 'LineWidth', 1.5);
xlabel('Tiempo (s)');
ylabel('Salida y(t)');
title('Respuesta del sistema a señal arbitraria');
grid on;





%/////////////////Reto//////////////
t = 0:0.1:50; % tiempo de 0 a 20 segundos
e_2 = zeros(size(t));

% Construcción de una señal arbitraria

e_2(t >= 2 & t < 10) = 10;
e_2(t >= 10 & t < 15) = -5;
e_2(t >= 15 & t < 20) = 15;

idx = t >= 20 & t < 30;
e_2(idx) = linspace(15, 25, sum(idx));
e_2(t >= 30 & t < 40) = linspace(25, 15, sum(idx));
e_2(t >= 40) = 15;

% Graficar señal
figure;
plot(t, e_2, 'k', 'LineWidth', 1.5);
xlabel('Tiempo (s)');
ylabel('Entrada u(t)');
title('Señal arbitraria');
grid on;

% Usamos la misma Gs del primer literal
y_3 = lsim(Gs, e_2, t);

% Graficar la respuesta
figure;
plot(t, y_3, 'b', 'LineWidth', 1.5);
xlabel('Tiempo (s)');
ylabel('Salida y(t)');
title('Respuesta del sistema a señal arbitraria');
grid on;


