datos = readmatrix('data_motor.csv');
T = readtable('data_motor.csv');
datos = table2array(T);

t = datos(:,2);
u = datos(:,3);
y = datos(:,4);

figure;

% Primer gráfico: X vs Y
subplot(2,1,1); % Divide la ventana en 2 filas, 1 columna, primera posición
plot(t, u, '-', 'LineWidth', 1.5);
xlabel('X');
ylabel('Y');
title('Gráfico tiempo vs entrada');
grid on;

% Segundo gráfico: X vs Z
subplot(2,1,2); % Segunda posición
plot(t, y, '-', 'LineWidth', 1.5);
xlabel('X');
ylabel('Z');
title('Gráfico tiempo vs salida');
grid on;

y_est = datos(35:end,4);

promedio_y_est = mean(y_est); % Calcular el promedio
disp(['El promedio de la columna Y es: ', num2str(promedio_y_est)]);






inicio = 7;  % Definir un rango de interés
fin = 35;

% Ajuste por mínimos cuadrados
p = polyfit(t(inicio:fin), y(inicio:fin), 1); % Ajuste lineal
y_ajustada = polyval(p, t(inicio:fin));

% Encontrar los extremos de la mejor recta ajustada
x1 = t(inicio);
y1 = polyval(p, x1);

x2 = t(fin);
y2 = polyval(p, x2);

disp(['mejores puntos: ', num2str(x1), num2str(y1), num2str(x2) , num2str(y2)]);

m = (y2 - y1) / (x2 - x1);  % Pendiente
b = y1 - m * x1;            % Intercepto



% Calcular y usando la ecuación de la recta
y_tan = m * t + b;


tau = 1.384;
K = 0.6609;
theta = 0.207;
G = tf(K,[tau 1], 'InputDelay', theta);
y_z_n = lsim(G, u, t);


tau2 = 0.873;
G1 = tf(K,[tau2 1], 'InputDelay', theta);
y_m = lsim(G1, u, t);

tau3 = 0.72;
theta2 = 0.36;
G2 = tf(K,[tau3 1], 'InputDelay', theta2);
y_an = lsim(G2, u, t);


% Figura con gráficos sobrepuestos
figure;
clf;
plot(t, u, '-', 'LineWidth', 1.5, 'DisplayName', 'T vs U');
hold on;
plot(t, y, '-', 'LineWidth', 1.5, 'DisplayName', 'T vs Y');
plot(t, y_tan, '-', 'LineWidth', 1.5);  % Línea azul continua
plot(t, y_z_n, '-', 'LineWidth', 1.5, 'DisplayName', 'Ziegler y Nichols');
plot(t, y_m, '-', 'LineWidth', 1.5, 'DisplayName', 'Miller');
plot(t, y_an, '-', 'LineWidth', 1.5, 'DisplayName', 'analitico');
yline(promedio_y_est, '-', 'LineWidth', 1.5, 'Label', 'Promedio Y');
yline(0, '-', 'LineWidth', 1.5, 'Label', 'linea base Y');


xlabel('X');
ylabel('Valores');
title('Gráfico X vs Y y X vs Z Superpuestos');
legend;
grid on;
hold off;





