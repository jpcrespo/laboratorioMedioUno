clc 
clear all
close all
%Declaración de constantes
u=4*pi*1e-7;
%bobina
a=0.15; %radio bobinas en [m]
N=130/2;
B=(8*u*N/(5*sqrt(5)*a));
%carga masa
v=195.6; %Voltaje de aceleracion
k=(2*v/(B^2));
%Datos obtenidos
I=[0.121 0.112 0.102 0.093 0.089 0.087 0.085 0.081 0.077 0.075 0.073 0.068 0.066 0.064 0.063 0.062 0.061 0.058 0.057 0.055 0.054 0.052 0.051 0.050 0.049 0.044]; %en Amperios [A]
R=[1.170 1.204 1.239 1.292 1.347 1.414 1.465 1.524 1.588 1.633 1.691 1.748 1.802 1.858 1.918 1.978 2.037 2.107 2.170 2.230 2.315 2.393 2.452 2.505 2.544 2.604]; %en centimetros [cm]
e_m=k./((I.*R).*(I.*R));
e_teorico=1.7588e11;
Error= 100*(abs(e_m-e_teorico)/e_teorico);
x=1:1:length(e_m);
plot(x,e_m,'ro' )
title('Set de datos medidos')
xlabel('(I*R)^2')
ylabel('Carga masa e/m')
grid
