%   cstFinder.m
%
%   MATLAB script to determine CST coefficients from xyz airfoil data

%% Clear workspace
clear;
close all;
clc;

%% Define function and constraints

% 
Au = [1 1 1 1 1 1];    %upper-surface Bernstein coefficients
Al = [1 1 1 1 1 1];    %lower surface Bernstein coefficients
A0 = [Au Al];

% Set the options for the optimisation
options = optimset('LargeScale','off');
options = optimset(options,'Display','iter');
options = optimset(options,'TolFun', 1e-10);

% Optimise fit
[Aop, fval, exitflag, output] = fminunc(@objectiveFunction,A0,options);

%% Plotting

% load airfoilChoice
airfoilChoice;

% load airfoil
load(airfoilDataFile);

% points for evaluation along x-axis
X = airfoil(:,1);      

% Take apart A
Au = Aop(1:6);
Al = Aop(7:12);

% Evaluate CST thingamajig
[Xtu,Xtl,C,Thu,Thl,Cm] = D_airfoil2(Au,Al,X);

hold on
plot(airfoil(:,1),airfoil(:,2),'g'); %plot airfoil
plot(Xtu(:,1),Xtu(:,2),'bx');    %plot upper surface coords
plot(Xtl(:,1),Xtl(:,2),'bx');    %plot lower surface coords
%plot(X,C,'r');                  %plot class function
axis([0,1,-1.5,1.5]);
