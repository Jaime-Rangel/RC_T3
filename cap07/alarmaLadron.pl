%%% Red bayesiana alarma-ladron

% Estructura de la Red

padre( ladron, sensor).    % el ladrón tiende a disparar el sensor
padre( relampago, sensor). % un relámpago fuerte también
padre( sensor, alarma).
padre( sensor, llamada).

% Probabilidades

p( ladron, 0.001). % Probabilidad a priori
p( relampago, 0.02).
p( sensor, [ ladron, relampago], 0.9). % Probabilidad condicionada
p( sensor, [ ladron, not relampago], 0.9).
p( sensor, [ not ladron, relampago], 0.1).
p( sensor, [ not ladron, not relampago], 0.001).
p( alarma, [ sensor], 0.95).
p( alarma, [ not sensor], 0.001).
p( llamada, [ sensor], 0.9).
p( llamada, [ not sensor], 0.0).
