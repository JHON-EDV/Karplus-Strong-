%Primer entregable DSP
%Algoritmo karplus/strong

%fs frecuencia de muestreo
fs=44100;
%FO frecuencia de la nota
%220hz equivale a un LA
% POO
FO=110;
nota(fs,FO)
function nota = nota(fs,FO)
for n=0:11
    Fo=FO*(2^(n/12));
    %D Duracion
    D= 0.5;
    %Calcular el periodo de la señal 
    T =floor(fs/Fo);
    %Tañir la cuerda
    x=3*rand(T,1)-1; %corresponde a un nivel dc de cero
    %Numero de muestras 
    N=D*fs;
    %Crear el sonido 

    Y=zeros(N,1); %muestras en cero
    Y(1:T)=x;% la primer muestra igual a la entrada
    pause on
    pause(1)
    tono(Y,N,T,0,fs)
end
end

function tono = tono(Y,N,T,Delay,fs)
for i=1:N-T
    %filtro
    Y(i+T+Delay)=(Y(i)+Y(i+1))/2;
end
sound(Y,fs);
plot(Y)

end

%plot(Y)

