
%% Set up for the aerodynamic solver
%                x      y     z   chord(m)    twist angle (deg) 
AC.Wing.Geom = [ x(1)   y(1)  0     c(1)         0;
                 x(2)   y(2)  0     c(2)         twistInner;
                 x(3)   y(3)  0     c(3)         twistOuter];

% Wing incidence angle (degree)
AC.Wing.inc  = 0;   
            
% Airfoil coefficients input matrix
% x(7) - x(18) = airfoil at root
% x(19) - x(30) = airfoil at kink
% x(31) - x(42) = airfoil at tip
%                    | ->     upper curve coeff.                <-|   | ->       lower curve coeff.       <-| 
AC.Wing.Airfoils   = [X(7:18);
                      X(19:30);
                      X(31:42)];
                  
AC.Wing.eta = [0;0.4;1];  % Spanwise location of the airfoil sections

%% Aerodynamic analysis at cruise conditions -> L/D check plus 
AC.Visc  = 1;             % 1 for viscous analysis and 0 for inviscid
AC.Aero.V     = Vcruise;            % flight speed (m/s)
AC.Aero.rho   = rho;                % air density  (kg/m3)
AC.Aero.alt   = alt;                % flight altitude (m)
AC.Aero.M     = Mcruise;            % flight Mach number 

% Calculate Reynolds number (based on mean aerodynamic chord)
AC.Aero.Re    = AC.Aero.V * MAC / (1.460*10^(-5));        % reynolds number 

% Calculate the required lift coefficient
Wdes = (MTOW * ZFW)^0.5;

% Calculate required CL during cruise conditions
AC.Aero.CL = (2*Wdes)/(AC.Aero.rho * (AC.Aero.V^2) * S); 

% Run Q3D for cruise conditions and save results
aeroCruiseResults = Q3D_solver(AC);
