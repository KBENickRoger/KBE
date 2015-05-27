%Q3D input file 
AC.Wing.Geom = [ 0 0 0 11.00000 0 ; 
16.96827 4.70702 1.53105 6.29298 0 ; 
48.48078 13.44864 4.37443 4.40000 0 ]; 
 
% Wing incidence angle (degree) 
AC.Wing.inc  = 0;  
 
% Airfoil CST coefficients 
AC.Wing.Airfoils = [ 0.23370 0.08000 0.26740 0.08990 0.27790 0.38160 -0.22530 -0.16370 -0.04640 -0.47780 0.07410 0.32520  ; 
 0.23370 0.08000 0.26740 0.08990 0.27790 0.38160 -0.22530 -0.16370 -0.04640 -0.47780 0.07410 0.32520  ; 
 0.23370 0.08000 0.26740 0.08990 0.27790 0.38160 -0.22530 -0.16370 -0.04640 -0.47780 0.07410 0.32520  ]; 
 
% Spanwise location of the airfoil sections 
AC.Wing.eta = [0 ; 0.35 ; 1]; 
% flight conditions 
AC.Visc = 1; 
AC.Aero.V = 100; 
AC.Aero.rho = 1.225; 
AC.Aero.alt = 10000; 
AC.Aero.M = 0.8; 
AC.Aero.Re = 4.802603733782918e+7; 
 
% Required CL 
AC.Aero.CL = 0.00250; 
 
% Run Q3D 
results = Q3D_solver(AC);