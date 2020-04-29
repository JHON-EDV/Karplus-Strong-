%Primer entregable DSP
%Algoritmo karplus/strong

%fs frecuencia de muestreo
fs=48100;
%FO frecuencia de la nota
%110hz equivale a un LA
FO=110; %clave de LA 

%llamado de funcion loop
loop(fs,FO)


function loop = loop(fs,FO)
%Tabla Presentada en pdf 'Primera práctica de laboratorio de DSP'
%'Conceptos Básicos de Señales y Procesamiento de Señales ' 

Notas_n = {'0LA','0LA#','0SI','0DO','0DO#','0RE',...
    '0RE#','0MI','0FA','0FA#','0SOL','0SOL#'...,
    'LA','LA#','SI','DO','DO#','RE',...
    'RE#','MI','FA','FA#','SOL','SOL#'...
    ,'1LA','1LA#','1SI','1DO','1DO#','1RE',...
    '1RE#','1MI','1FA','1FA#','1SOL','1SOL#'};


Equivalente_n = [-12 -11 -10 -9 -8 -7 -6 -5 -4 -3 ...
    -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ...
    17 18 19 20 21 22 23];

Pentagrama = containers.Map(Notas_n,Equivalente_n);


%notas={'DO','RE','MI','FA','SOL','1LA','1SI','1DO'};
%Delay=[0,1,1,1,1,1,1,1];
notas={'1LA','1DO','MI','SOL','1SI', ...
    'SOL','MI','1DO','1LA',...
    '1LA','1DO','MI','SOL','1SI', ...
    'SOL','MI','1DO','1LA'};
%Delay=[pi/46,pi/46,pi/46,pi/46,pi/24,...
%    pi/46,pi/46,pi/46,pi/24,...
%    pi/46,pi/46,pi/46,pi/46,pi/24,...
%    pi/46,pi/46,pi/46,pi/24];

Delay=pi/46;
pause on

for i=1:length(notas)
    pause(Delay);
    nota_entero=cell2mat((values(Pentagrama,notas(i))));
    nota(fs,FO,nota_entero)
end

end


function nota = nota(fs,FO,n)
%D Duracion
D= 1;

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
plot(Y)
%t=(0:length(Y)-1)*0.0001;

end 

