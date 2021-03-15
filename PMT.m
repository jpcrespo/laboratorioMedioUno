%LAB MEDIO I
%Juan Pablo Crespo Vargas
%Programa para simular un PMT (fotomultiplicador)
%en una sola dimensión.

%inicializando
clc 
clear all
close all
%*************************************************************************
%PRIMERA ETAPA
%Se genera un numero 'n' de fotones con su respectiva energia
%*************************************************************************

%inicialmente, tomaremos un numero de 1000 fotones de entrada.
n=input('Ingrese el número de fotones: ');
%Cada foton debe tener una cantidad de energia mínima y máxima en [nm]
e_min=200;
e_max=600;
dinodos=input('Ingrese el número de Dinodos: ');
%la cantidad de energia será asociada a cada foton en un vector "A" de 
%tamaño 'n', mediante la generación aleatoria de números enteros.
tic;
A = round(e_min + (e_max-e_min).*rand(n,1));
x= 0:1:(n-1);
subplot(3,1,1)
plot(x,A,'r.');
grid
title('Distribución de fotones');
xlabel('Fotones');
ylabel('Longitud onda en [nm]')
%En caso de querer números no enteros:
%A = (e_min + (e_max-e_min).*rand(n,1));
%*********************************************************************
%SEGUNDA ETAPA
%Cada foton impactara, generando un efecto fotoeléctrico.
%el material a simular tiene una eficiencia cuantica que responde a 
%una función de distribución gaussiana con un 20% de eficiencia
x1=e_min:1:e_max;
gauss = 0.2*gaussmf(x1,[(e_max/8) 400]);
subplot(3,1,2)
bar(x1, gauss)
axis([e_min e_max 0 0.2])
title('Función de probabilidada Efecto-Fotoeléctrico')
xlabel('longitud de onda [nm]')
ylabel('probabilidad de generar electrón')
grid
%se desea evaluar la probabilidad de cada foton en la distribución dada.

%*******************************************************************
%ordenamos el numero de fotones que corresponden por cada energia

for i=e_min:e_max;
    cnt=0;
    for j=1:n;
        if(A(j)==(i))
            cnt=cnt+1;
        end
        A1((i-e_min)+1)=cnt; %Vector ordenado por energia, contiene el numero de fotones
    end
end
%Calculamos el numero de electrones producidos
subplot(3,1,3)
bar(x1,A1,'g')
title('Distribución de fotones')
xlabel('Longitud de onda [nm]')
ylabel('Número de fotones')
xlim([e_min e_max])
grid
%*******************************************************************
%numero de electrones que se producen
E(1)=sum(fix(A1.*gauss));
%*******************************************************************
%*******************************************************************
%TERCERA ETAPA DINODOS
%un dinodo tiene una función de distribución de Poisson de lamnba=3
LAMBDA=3;
X=0:1:10;
Y = poisspdf(X,LAMBDA);
figure(2)

bar(X,Y)
title('Modelo de cada dinodo')
xlabel('Llegadas de electrones')
ylabel('Emision de electrones')
grid

%El numero de dinodos generara un numero de electrones distintos
%para cada etapa, y se lo calculara de forma recursiva.
%Para el primer dinodo se cuentan el numero de electrones generados
pp=1000; %proceso de poisson
for j=1:pp;
    
for i=1:dinodos;
    D = poissrnd(LAMBDA,1,E(i));
    E(i+1)=sum(D);
end

for i=1:dinodos
E_f(i,j)=E(i+1);
end
end

%Graficamos la distribución que cobra cada dinodo:


for i=1:1:dinodos;
  figure(3)

  Z=min(E_f(i,:)):1:max(E_f(i,:));
   for k1=1:1:length(Z);
       cnt=0;
       for k=1:1:pp;
            if(E_f(i,k)==Z(k1));
             cnt=cnt+1;
          end
     end
   E_f1(k1)=cnt;    
   end
   figure(3)
   subplot(dinodos,1,i);
   bar(E_f1);
   grid
   title('Función de distribución de cada dinodo')
   ylabel('Electrones emitidos')
   xlabel('número de prueba')
end
   %Se procede a mostrar los resultados
fprintf('Los %d fotones de entrada responden a una longitud\n de onda generada de manera aleatoria con una distribución uniforme\n', n)
fprintf('De los %d fotones, %d se transforman en electrones\n por el efecto fotoeléctrico \n',n,E(1))
for i=1:length(E)-1;
fprintf('En el dinodo número %d, ingresan %d electrones \n se producen %d electrones\n',i,E(i),E(i+1))
end
time=toc;
fprintf('Tiempo de ejecución del programa %d segundos \n',time)

