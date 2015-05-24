%Q3D input file 
AC.Wing.Geom = [ 0 0 0 10.00000 0 ; 
14.82854 2.65501 1.31233 7.34499 0 ; 
49.42848 8.85003 4.37443 5.00000 0 ]; 
 
% Wing incidence angle (degree) 
AC.Wing.inc  = 0;  
 
% Airfoil CST coefficients 
AC.Wing.Airfoils = [ 0.23370 0.08000 0.26740 0.08990 0.27790 0.38160 -0.22530 -0.16370 -0.04640 -0.47780 0.07410 0.32520  ; 
 0.23370 0.08000 0.26740 0.08990 0.27790 0.38160 -0.22530 -0.16370 -0.04640 -0.47780 0.07410 0.32520  ; 
 0.23370 0.08000 0.26740 0.08990 0.27790 0.38160 -0.22530 -0.16370 -0.04640 -0.47780 0.07410 0.32520  ]; 
 
% Spanwise location of the airfoil sections 
AC.Wing.eta = [0 ; 0.3 ; 1]; 
% flight conditions 
AC.Visc = 1; 
AC.Aero.V = 100; 
AC.Aero.rho = 1.225; 
AC.Aero.alt = 10000; 
AC.Aero.M = 0.8; 
AC.Aero.Re = 4.920472867186477e+7; 
 
% Required CL 
AC.Aero.CL = 0.00235; 
 
% Run Q3D 
results = Q3D_solver(AC);