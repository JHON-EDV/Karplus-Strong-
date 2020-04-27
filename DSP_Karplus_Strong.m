%Primer entregable DSP
%Algoritmo karplus/strong

%fs frecuencia de muestreo
fs=44100;
%FO frecuencia de la nota
%220hz equivale a un LA
FO=220;
%D Duracion
D= 1;
%Calcular el periodo de la señal 
T =floor(fs/FO);
%Tañir la cuerda
x=3*rand(T,1)-1; %corresponde a un nivel dc de cero
%Numero de muestras 
N=D*fs;
%Crear el sonido 

Y=zeros(N,1); %muestras en cero
Y(1:T)=x;% la primer muestra igual a la entrada


for i=1:N-T
    %filtro
    Y(i+T)=(Y(i)+Y(i+1))/2;
end

sound(Y,fs);
plot(Y)


