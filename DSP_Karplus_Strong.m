%Primer entregable DSP
%Algoritmo karplus/strong

%fs frecuencia de muestreo
fs=24000;
%FO frecuencia de la nota
%220hz equivale a un LA
FO=110; %clave de la 
%tempo
loop(fs,FO)



% Delay=1;
% pause on % activo las pausas
% nota(fs,FO,3)%Do
% pause(Delay) %la pausa en segundos
% nota(fs,FO,5)%RE



function loop = loop(fs,FO)
Notas_n = {'0LA','0LA#','0SI','0DO','0DO#','0RE',...
    '0RE#','0MI','0FA','0FA#','0SOL','0SOL#'...,
    'LA','LA#','SI','DO','DO#','RE',...
    'RE#','MI','FA','FA#','SOL','SOL#'};

Equivalente_n = [-12 -11 -10 -9 -8 -7 -6 -5 -4 -3 ...
    -2 -1 0 1 2 3 4 5 6 7 8 9 10 11];

Pentagrama = containers.Map(Notas_n,Equivalente_n);


notas={'DO','RE','MI','FA','SOL','LA','SI','DO'};
Delay=[0,1,1,1,1,1,1,1];
pause on
for i=1:length(notas)
    pause(Delay(i));
    nota_entero=cell2mat((values(Pentagrama,notas(i))));
    nota(fs,FO,nota_entero)
end

%notas=[3,5,7,8,10,12,13,15,-2,4,10];
%Delay=[1,1,1,1,1,1,1,1,1,0,0.01,0.01,0];
end


function nota = nota(fs,FO,n)
%D Duracion
D= 3;

Fo=FO*(2^(n/12));   
%Calcular el periodo de la señal 
T =floor(fs/Fo);
%Tañir la cuerda
x=(pi)*rand(T,1)-1; %corresponde a un nivel dc de cero
%Numero de muestras 
N=D*fs;
%Crear el sonido 
Y=zeros(N,1); %muestras en cero
Y(1:T)=x;% la primer muestra igual a la entrada

tono(Y,N,T,0,fs)

end


function tono = tono(Y,N,T,Delay,fs) 
for i=1:N-T
    %filtro
    Y(i+T+Delay)=(Y(i)+Y(i+1))/2;
end
sound(Y,fs);
%t=(0:length(Y)-1)*0.0001;
plot(Y)
end 

