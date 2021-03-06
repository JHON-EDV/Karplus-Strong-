%Primer entregable DSP
%Algoritmo karplus/strong

clc;clear; close all;

%fs frecuencia de muestreo

%FO frecuencia (Centra)
%110hz equivale a un LA
FO=220; %clave de LA 

%llamado de funcion loop
loop(FO)


function loop(FO)
%Tabla Presentada en pdf 'Primera pr�ctica de laboratorio de DSP'
%'Conceptos B�sicos de Se�ales y Procesamiento de Se�ales ' 

Notas_n = {'0LA','0LA#','0SI','0DO','0DO#','0RE',...
    '0RE#','0MI','0FA','0FA#','0SOL','0SOL#'...,
    'LA','LA#','SI','DO','DO#','RE',...
    'RE#','MI','FA','FA#','SOL','SOL#'...
    ,'1LA','1LA#','1SI','1DO','1DO#','1RE',...
    '1RE#','1MI','1FA','1FA#','1SOL','1SOL#', 'SILENCIO'};


Equivalente_n = [-12 -11 -10 -9 -8 -7 -6 -5 -4 -3 ...
    -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ...
    17 18 19 20 21 22 23 91];

Pentagrama = containers.Map(Notas_n,Equivalente_n);
% -------------- --------------- ----------------

%Para la creacion de la cancion es necesario variar
% 3 Datos 
%         -1 el arreglo de 'notas'
%         -2 el string fs (que define la duracion)
%         -3 el string Tono_nota (que define el timbre) 


%Eqivalencias -redonda  44800
%             -blanca   22400
%             -negra    5600
 notas={'DO','DO','LA'...
        'SILENCIO','SI','SOL',...
        'DO','DO','LA',...
        'SILENCIO','SI','SOL',...
        'DO','DO','LA',...
        'SILENCIO','SI','SOL'...
        'FA','SILENCIO','RE'...
        'SI','SI','SI'...
        'SI','LA','SOL'...
        'FA','RE','RE'...
        'RE','MI','FA'...
        'SOL','SOL','SOL',...
        'SOL','FA','MI'...
        'RE','SILENCIO','DO'...
        'SILENCIO','SILENCIO','MI'...
        'RE','DO','SILENCIO'...
        'DO','DO','LA'...
        'SILENCIO','SI','SOL',...
        'DO','DO','LA',...
        'SILENCIO','SI','SOL',...
        'DO','DO','LA',...
        'SILENCIO','SI','SOL'...
        'FA','SILENCIO','RE'...
        'SI','SI','SI'...
        'SI','LA','SOL'...
        'FA','RE','RE'...
        'RE','MI','FA'...
        'SOL','SOL','SOL',...
        'SOL','FA','MI'...
        'RE','SILENCIO','DO'...
        'SILENCIO','SILENCIO','MI'...
        'SILENCIO','1RE','1DO',...
        };

fs=44100;

tono_nota=[0, 0,...
           0, 0,0,...
           0, 0,0, 0,...
           0, 0,0,...
           0, 0, 0];



%Pausa
pause on

%D Duracion de la nota
D= 1.5;

for i=1:length(notas)
  
    %cell2mat utilizado para obtener el valor de notas
    %De esa forma se da la nota y no su equivalente (numero)
    nota_entero=cell2mat((values(Pentagrama,notas(i))));
    
    %llamado a la funcion nota
    nota(D,fs,FO,nota_entero)
end

end


function nota(D,fs,FO,nota_entero)

%Se crea la nota dependiendo de el parametro nota_entero
Fo=FO*(2^(nota_entero/12));

%Calcular el periodo de la se�al 
T =floor(fs/Fo);
%Ta�ir la cuerda
x=(pi/2)*rand(T,1)-1; %corresponde a un nivel dc de cero
%Numero de muestras 
N=D*fs;
%Crear el sonido 
Y=zeros(N,1); %muestras en cero
Y(1:T)=x;% la primer muestra igual a la entrada


tono(Y,N,T,fs)
end


function tono(Y,N,T,fs) 
for i=1:N-T
    
    %filtro
    Y(i+T)=(Y(i)+Y(i+1))/2.01;
    
end
%Creacion del sonido.

sound(Y,fs);
pause(0.3);

%Otro metodo de creacion del sonido 
%soundsc(Y,fs);

t=(0:length(Y)-1)/fs;
plot(t,Y)

%plot(Y)
%x=length(Y)
%z=length(t)
end 