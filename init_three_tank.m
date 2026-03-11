% Variables for the three-tank example

% Open system
Atank=pi*0.07^2; Atube=pi*2e-3^2; g=9.8;

tUnit= 60;
href=[0.5; 0.4; 0.3]; H=0.1; dh=href(1)-href(2);
q1ref=Atube*sqrt(2*g*dh);
q2ref=Atube*(-sqrt(2*g*dh)+sqrt(2*g*(href(3)-H)));

f1=Atube/Atank*sqrt(g/(2*dh));
f2=Atube/Atank*sqrt(g/(2*(href(3)-H)));
A=[-f1 f1 0; f1 -2*f1 f1; 0 f1 -(f1+f2)];
B=1/Atank*[1 0; 0 0; 0 1];
q11 = q1ref*1.1; q21 = q2ref*0.9;

% Controlled system
dh = [-0.1; -0.06; -0.03];
dw = [0; 0; 0];
x0=dh;

C=[0 1 0; 0 0 1];

Ts = 0.1; % Sampling period (100ms)
sys_con = ss(A, B, C, 0);
sys_dis = c2d(sys_con, Ts, 'zoh'); % Convert to Discrete

Ad = sys_dis.A;
Bd = sys_dis.B;