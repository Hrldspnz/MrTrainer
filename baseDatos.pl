%Reconocimiento de palabras
%Parte 1 de la conversacion, reconocimiento de saludo o ausencia de etse
%inicio(). Comando para iniciar la conversacion.
inicio():- nl, read_string(user_input, '\n', '.', _, Str),atomic_list_concat(Lista, ' ', Str),incioConversacionAux(Lista,[]).
incioConversacionAux(Lista,[]):-incioConversacion(Lista,[]),deporteSolicitado(Deporte),nivelarCliente(Nivel),padecimientoSolicitado(Padecimiento),rutina(Nombre,Deporte,PadecimientoAux,Nivel,Dias, Detalle),Padecimiento\=PadecimientoAux,write('Le recomiendo la siguiente rutina: '),nl,write('Nombre de la rutina: '),write(Nombre),nl,write('Dias a la semana de entrenamiento: '),write(Dias),nl,write(Detalle).
incioConversacionAux(Lista,[]):-write("Saludo no detectado"),inicio().
incioConversacion(Lista,Vacio):-saludo(Lista,Resto),nombre(Resto,Vacio).  
incioConversacion(Lista,Vacio):-saludo(Lista,Resto),horario(Resto,Vacio).
incioConversacion(Lista,Vacio):-saludo(Lista,Vacio). 
 

%saludos aceptados por MrTrainer
saludo(['Hola'|Lista],Lista).
saludo(['Buenos'|Lista],Lista).
horario(['dias'|Lista],Lista).
horario(['tardes'|Lista],Lista).
horario(['noches'|Lista],Lista).
nombre(['Mr.Trainer'|Lista],Lista).

%Parte 2 de la conversacion, reconocimiento del tipo de deporte
%Devuelve el deporte ingresado por el ususario
deporteSolicitado(Deporte):- write("Ha pensado en entrenar algun deporte?"), nl, read_string(user_input, '\n', '.', _, Str),atomic_list_concat(Lista, ' ', Str),seleccion(Lista,[],Deporte).
deporteSolicitado(Deporte):- write("No he reconocido su respuesta, por favor prube con otra como por ejemplo: si/si ciclismo"),nl,deporteSolicitado(Deporte).
seleccion(Lista,Vacio,Deporte):-afirmacion(Lista,Vacio),write('Puede escoger entre correr,ciclismo,natacion'),opcionesDeporte(Deporte).
seleccion(Lista,Vacio,Deporte):-negacion(Lista,Vacio),write('Adios'),nl.
seleccion(Lista,Vacio,Deporte):-afirmacion(Lista,Resto),deporte(Resto,Vacio),atomics_to_string(Resto,Deporte).  

opcionesDeporte(Str):- nl, read_string(user_input, '\n', '.', _, Str),atomic_list_concat(Deporte, ' ', Str),deporte(Deporte,Vacio).

%Deportes reconocidos por MrTrainer
deporte(['correr'|Lista],Lista).
deporte(['ciclismo'|Lista],Lista).
deporte(['natacion'|Lista],Lista).
afirmacion(['si'|Lista],Lista).
negacion(['no'|Lista],Lista).


%Parte 3 de la conversacion, reconocimieno de padecimientos.
%Devuelve el padecimiento que tiene el usuario
padecimientoSolicitado(Padecimiento):- write("Padece usted de alguna enfermedad que le impida hacer deporte"), nl, read_string(user_input, '\n', '.', _, Str),atomic_list_concat(Lista, ' ', Str),padecimientos(Lista,[],Padecimiento).
padecimientos(Lista,Vacio,Padecimiento):- afirmacion(Lista,Resto),padecimiento(Resto,Vacio),atomics_to_string(Resto,Padecimiento).
padecimientos(Lista,Vacio,Padecimiento):- afirmacion(Lista,Vacio),padecimientosAux(Padecimiento).
padecimientos(Lista,Vacio,Padecimiento):- padecimiento(Lista,Vacio),atomics_to_string(Lista,Padecimiento).

padecimientosAux(Str):- write('Que tipo de padecimientos posee?\n'),nl, read_string(user_input, '\n', '.', _, Str),atomic_list_concat(Padecimiento, ' ', Str),padecimiento(Padecimiento,Vacio). 

%Padecimientos reconocidos por MrTrainer
padecimiento(['escoliosis'|Lista],Lista).
padecimiento(['hipertension'|Lista],Lista).
padecimiento(['cardiopata'|Lista],Lista).
padecimiento(['no'|Lista],Lista).



%respuesta():-elegirParametrosRutina(_,_,_,_,_, Detalle), write(Detalle).
%elegirParametrosRutina(Nombre,Deporte,Padecimientos,Nivel,Dias, Detalle):- elegirDeporte(Deporte), elegirCantidadDias(Dias), nivelarCliente(Nivel), buscarRutina(Nombre,Deporte,Padecimientos,Nivel,Dias, Detalle).

%elegirDeporte(Deporte):- write('Digite deporte que desea realizar: '), nl, read(Deporte).
%elegirCantidadDias(Dias):- write('Digite la cantidad de dias que desea entrenar: '),nl, read(Dias).
nivelarCliente(Nivel):- write('Cuantos dias a la semana hace ejercicio'),nl ,read_string(user_input, '\n', '.', _, Cantidad), buscarNivel(Nivel,Cantidad).




%Base de Datos
%Clasificacion del nivel del usuario segun la cantidad de deporte que se hace a la semana
nivel('principiante',["0","1"]).
nivel('principiante intenso',["2"]).
nivel('intermedio',["3","4"]).
nivel('intermedio intenso',["5"]).
nivel('avanzado',["6","7"]).

%rutina(nombreRutina,deporte, padecimientos,nivel,dias,detalle).

%Natacion
rutina('Rutina 1',"natacion", '','principiante',4,'
  Domingo: Descanso\n
  Lunes: Distancias: 2700m, enfoque resistencia, calentamiento: 3 intervalos de 200 metros nadando a crol con un pull boy aumentando esfuerzo de 1 a 4 cada 50 metros descansado 30 s por cada intervalo, últimos 100 metros nada a crol con un solo brazo. Etapa principal de 1600 metros 2 intervalos de 200 metros nadando a crol con un pull buoy descanso de 45 s, 7 intervalos de 100 metros con estilo de nado de su preferencia, descansa 30 segundos por ejercicio, 5 intervalos de 100 m descansando 30 segundos. Etapa de enfriamiento de 400 m, 4 intervalos de 100 m descansa 15 s por cada intervalo.\n
  Martes: Distancia 3200m, enfoque técnica, resistencia y fuerza. Etapa de Calentamiento de 700 m 3 intervalos de 200m y 1 de 100m, estilo de nado fingertip drag descansando 30 segundos por intervalo. Etapa principal de 1200 m 2 intervalos de 200 m, 11 intervalos de 100 m y 3 intervalos de 200 m, mezclando tipos de nados pull buoy y towfloat descansado 30s por intervalo. Etapa de enfriamiento de 400m, alternando 50m de crol y 50 de tu elección, descansa 30s por intervalo.\n
  Miércoles: Descanso\n
  Jueves: Distancia 4100m, enfoque técnica, resistencia, respiración y fuerza. Etapa de calentamiento de 300 m 3 intervalos de 100m, estilo de nado crol con un tubo descansando 20 segundos por intervalo. Etapa principal de 3500 m 3 intervalos de 200 m, 4 intervalos de 100 m, 3 intervalos de 200 m, 7 intervalos de 200 m, 5 intervalos de 100 m, mezclando tipos de nados, descansado 30s por intervalo. Etapa de enfriamiento de 300m, con 3 intervalos de 100 metros descansando 30s.\n
  Viernes: Descanso\n
  Sábado: Distancia de 500m, enfoque resistencia, técnica y fuerza, etapa de calentamiento de 400 m, nadando 25 m con puños cerrados, después de 25 m fuertes a crol, descansando 20 segundos. Etapa principal con 18 intervalos de 50 m practicando patada de crol, 12 intervalos de 50 m nadando a crol con un solo brazo, 3 intervalos de 100 m nadando a crol, 3 intervalos de 100 m nadando a crol con tubo, 7 intervalos de 200 m nadando a crol con un pull buoy y 3 intervalos de 100 m con el estilo de nado de preferencia, descansando 30 s por intervalo. Etapa de enfriamiento 300 m con 30 s de descanso.\n
  ').
rutina('Rutina 2',"natacion", '','principiante intenso',5,'
  Domingo: Descanso.\n
  Lunes: Distancia 4500 m, enfoque de entrenamiento fuerza técnica y resistencia, etapa de calentamiento de 200 m, nada a crol con tubo, descansa 20 segundos por intervalo, etapa principal de 3500 m, 4 intervalos de 200 m, 4 intervalos de 50 m, 10 intervalos de 100 metros, 11 intervalos de 100 metros, dos intervalos de 200 m, mezclar nados entre crol, fingertip, superman, canta 20 segundos después de cada intervalo. Etapa de enfriamiento de 300 m, descansa 20 segundos por intervalo.\n
  Martes: Distancia 3600m, enfoque de entrenamiento resistencia técnica y velocidad, etapa de calentamiento de 200 m, nada a catch up, descansando 15 segundos por intervalo. Etapa principal de 3200 m, 8 intervalos de 100 metros, 5 intervalos de 200 m, 2 intervalos de 200 metros, 12 intervalos de 50 m, 8 intervalos de 50 m, descansa 30 segundos después de cada intervalo, mezcla tipos de nado, nada a crol, nada relajado, elige tu ejercicio de preferencia. Etapa de enfriamiento de 200 m, intervalos de 100 metros, nada relajado a crol, descansa 30 segundos por intervalo.\n
  Miércoles: Distancia 3200 m, enfoque de entrenamiento resistencia y velocidad. Etapa de calentamiento de 700 m, nada a crol con un pull buoy, aumenta tu nivel de esfuerzo de 1 a 4 con cada 50 metros, descansa 30s. Etapa principal de 12 intervalos de 50 m, 6 intervalos de 200 m, 6 intervalos de 50 m, nadando de espalda facil, nada a crol con un pull buoy, descansa 30s por intervalo. Etapa de calentamiento de 400 m, 2 intervalos de 200 m, nada relajado a crol.\n
  Jueves: Descanso.\n
  Viernes: Distancia de 2800 m, enfoque de entrenamiento técnica y resistencia. Etapa de calentamiento de 200 m, 4 intervalos de 50 m, nada a crol con un solo brazo descansa 30 s. Etapa principal de 2200m, 4 intervalos de 100 m, 10 intervalos de 50 m, 16 intervalos de 50 m, 5 intervalos de 1oo metros, nada a catch-up y a crol con un pull buoy, descansa 30 segundos por intervalos. Etapa de calentamiento de 400 m, 2 intervalos de 200m.\n
  Sábado: Distancia de 2400 m, enfoque de entrenamiento resistencia y fuerza. Etapa de calentamiento de 400 m, 2 intervalos de 200 m, nada a crol con un patrón de respiración constante. Etapa principal de 1800 m, 4 intervalos de 200 m, 16 intervalos de 50 m, 2 intervalos de 100 m, elige tus nados de preferencia descansando 45 s por intervalo. Etapa de enfriamiento de 200 m, descansando 30 s.
').
rutina('Rutina 3',"natacion", '','intermedio',4,'
  Domingo: Distancia 3000 m, enfoque de entrenamiento resistencia. Etapa de calentamiento de 600 m, 8 intervalos de 50 m, nadar de espalda con patada de mariposa manteniendo tus brazos extendidos. Etapa principal de 2000 m, 4 intervalos de 100 m, 10 intervalos de 100 m, 3 intervalos de 200 m, nadando a crol con un pull buoy, descansando 30 s por intervalo. Etapa de enfriamiento de 400 m, 8 intervalos de 50 m.\n
  Lunes: Distancia 3700 m, enfoque respiración, técnica, resistencia, fuerza. Etapa de calentamiento de 700 m, 10 intervalos de 50 m, 2 intervalos de 100 m,nadando a crol con un pull buoy, concentrando el nado en un agarre lento seguido de una fase de tirón potente y rápida. Etapa principal de 2600 m, 5 intervalos de 200 m, 7 intervalos de 100 m, 14 intervalos de 50 m, 2 intervalos de 100 m, alternar el brazo cada dos brazadas, Descansa 30s por intervalo. Etapa de enfriamiento de 400 m, 1 intervalo de 400 m, nada a crol relajado.\n
  Martes: Descanso.\n
  Miércoles: Distancia de 4400 m, enfoque respiración, resistencia y fuerza. Etapa de calentamiento de 600 m, 10 intervalos de 50 m, 2 intervalos de 50 m, primer intervalo nada a crol con un solo brazo y el siguiente nada a crol con aletas, descansa a 20 s por intervalo. Etapa principal de 3400 m, 1 intervalo de 200 m, 3 intervalos de 200 m, 1 intervalo de 300 m, 15 intervalos de 100 m, 4 intervalos de 200 m, puedes varias el nado a crol, brza, espalda y mariposa, descansa 30s por intervalo. Etapa de enfriamiento de 400 m, 8 intervalos de 50 m, nadando fingertip drag o towfloat.\n
  Jueves: Distancia 5100m, enfoque de entrenamiento respiración, técnica y resistencia. Etapa de calentamiento de 700 m, 14 intervalos de 50 m nadando a crol con un solo brazo descansando 30 s por intervalo. Etapa principal de 4200 m, 20 intervalos de 50 m, 6 intervalos de 50 m, 3 intervalos de 200 m, 14 intervalos de 50 m, 12 intervalos de 100m y una final de 4 intervalos de 100 m, en cada etapa alternar los tipos de nados a crol, crol con un pull buoy, a puños cerrados, descansa 30s por intervalo. Etapa de enfriamiento de 200 m nada relajado a crol con un patrón de respiración constante.\n
  Viernes: Descanso.\n
  Sábado: Descanso.
').
rutina('Rutina 4',"natacion", 'cardiopata','intermedio intenso',5,'
  Domingo: Distancia de 3100 m, enfoque de entrenamiento velocidad, fuerza, resistencia y técnica. Etapa de calentamiento de 400 m, nada de espalda con patada de mariposa y con aletas, mantenga tus brazos extendidos. Etapa principal de 2400 m, 6 intervalos de 50 m, nada a braza, 6 intervalos de 50 m, nada de espalda fácil, 5 intervalos de 300 m, nada a crol con palas de natación, 6 intervalos de 50 m, nada a mariposa con aletas. Etapa de calentamiento de 300 m, 3 intervalos de 100 m, nada este ejercicio con su estilo de preferencia, descansa 30 s después de cada intervalo.\n
  Lunes: Distancia de 3700m, enfoque respiración, técnica, resistencia, fuerza y velocidad. Etapa de calentamiento de 300m, 3 intervalos de 100m, nada 75 m a crol seguido de 25 m de espalda. Etapa principal de 3200m, 16 intervalos de 50m, nada a crol con un patrón de respiración alternante, 1 intervalo de 200 m, nada a braza, 11 intervalos de 100 m, nada este ejercicio con su estilo de preferencia, 9 intervalos de 100m, nada a crol, 2 intervalos de 100 m, nada a crol, patea fuerte en los últimos 25 m de cada intervalo. Etapa de enfriamiento de 200 m, 2 intervalos de 100 m, nada a braza, descansa 30s por cada intervalo.\n
  Martes: distancia de 4200 m, enfoque de entrenamiento respiración, técnica, resistencia y fuerza. Etapa de calentamiento de 200 m, en un solo intervalo nada 50 m a crol, braza, espalda y mariposa. Etapa principal de 3600 m, 1 intervalo de 200 m, nada a crol con un pull buoy, 12 intervalos de 50 m, nada a crol con un solo brazo, 2 intervalos de 100 m, nada con tu estilo de preferencia, 8 intervalos de 50 m, nada a crol, 16 intervalos de 100 m, y 3 intervalos de 200 m, nada a crol, aumenta intensidad de 1 a 4 por cada 50 m. Etapa de enfriamiento de 400 m, 4 intervalos de 100 m, nada este ejercicio con tu estilo de preferencia, descansa 30s después de cada intervalo\n
  Miércoles: Descanso.\n
  Jueves: Distancia de 480 m, enfoque de entrenamiento respiración, técnica, resistencia y fuerza. Etapa de calentamiento de 200 m, en un solo intervalo. Etapa principal de 4200 m, 1 intervalo de 100 m, nada a crol, 26 intervalos de 50 m, práctica tu patada de crol con aletas y un tubo, 5 intervalos de 200 m, nada relajado a crol, 18 intervalos de 50 m, nada a crol con un solo brazo, 3 intervalos de 200m, nada a crol con un pull buoy, 3 intervalos de 100 m, nada a crol con un patrón de respiración de 3-5-5-7. Etapa de enfriamiento de 400m, 2 intervalos de 200 m, descansa 25s por cada intervalo.\n
  Viernes: Distancia 5300m, enfoque de entrenamiento resistencia, fuerza y velocidad. Etapa de calentamiento de 200m, 4 intervalos de 50 m, nada de espalda con patada de mariposa. Etapa principal de 4800 m, 5 intervalos de 100 m, nada con tu estilo de preferencia, 6 intervalos de 50 m, nada a mariposa con velocidad de esprint, 4 intervalos de 200 m, nada a crol con palas de natación y aletas, 11 intervalos de 100 m, nada a crol con un pull buoy, 1 intervalo de 400 m, nada a crol, 11 intervalos de 100 m, nada con tu estilo de preferencia, 3 intervalos de 200 m, nadando en fingertip o superman. Etapa de calentamiento de 300 m, nada a crol con un solo brazo, descansa 25s por intervalo.\n
  Sábado: Descanso.\n
  ').
rutina('Rutina 5',"natacion", 'cardiopata','avanzado',4,'
  Este ejercicio repetirlo 6 veces a la semana con un día de descanso.\n\n
  Etapa de calentamiento:\n
  \t1 x 400 m estilo libre – 30 segundos de descanso.\n
  \t4 x 100 m estilo libre – 30 segundos de descanso.\n
  \t1 tirón de 300 m de estilo libre (coloque la palanca entre las piernas y use solo los brazos) – 20 segundos de descanso.\n
  \t1 x 300 m de estilo libre (sostenga el kickboard con los brazos y use solo las piernas) – 20 segundos de descanso\n
  Descanse 1 minuto\n
  Etapa principal:\n
  \t1 patada estilo libre x 75 m – 20 segundos de descanso.\n
  \t1 x 25m de tiro libre rápido – 20 segundos de descanso.\n
  \t (Repite el conjunto 3 veces)\n
  \t1 x 75 m de golpe de espalda – 20 segundos de descanso.\n
  \tUna patada de espalda rápida de 1 x 25 m – 20 segundos de descanso.\n
  \t(Repite el conjunto 3 veces)\n
  Descansa 1 minuto\n
  \t1 x 200 m gratis (cualquier golpe) – rápido – 20 segundos de descanso.\n
  \t1 x 150 m gratis (cualquier golpe) – rápido – 20 segundos de descanso.\n
  \t1 x 100 m gratis (cualquier golpe) – rápido – 20 segundos de descanso.\n
  \t1 x 50 m gratis (cualquier golpe) – rápido – 20 segundos de descanso.\n
  \t1 x 100 m (cualquier golpe) – rápido – 20 segundos de descanso.\n
  \t1 x 150 m (cualquier golpe) – rápido – 20 segundos de descanso.\n
  \t1 x 200 m (cualquier golpe) – rápido – 20 segundos de descanso.\n
  (Repita el ajuste 2 veces) Descanse 1 minuto\n
  \t5 x 100 m estilo libre – respira cada 3,5,7 golpes – 30 segundos de descanso.\n
  \t1 x 50 m estilo libre – respiración normal – 30 segundos de descanso.\n
  \tPatada subacuática de 4 x 25 m – 1 minuto de descanso.\n
  Enfriamiento:\n
  \t1 x 100 de enfriamiento: natación lenta.\n
  ').

%Correr
rutina('Preparación para 5 Kilómetros',"correr", ' ', 'principiante', 4,
       '\nDía 1: Día de descanso. \n
       Día 2: 25 minutos de carrera a ritmo fácil. 5 a 10 minutos de enfriamiento. Estiramientos. \n
       Día 3: 10 minutos de calentamiento. 5 minutos de carrera a ritmo de serie. 2 minutos de trote de recuperación. Repetir 4 veces. 5 a 10 minutos de enfriamiento. Estiramientos.  \n
       Día 4: 30 minutos de carrera a ritmo fácil. 5 a 10 minutos de enfriamiento. Estiramientos.  \n
       Día 5: Día de descanso.  \n
       Día 6: 60 minutos de carrera a ritmo fácil. 5 a 10 minutos de enfriamiento. Estiramientos.  \n
       Día 7:  30 minutos de entrenamiento cruzado.  \n
       '). 
rutina('Inicial',"correr", ' ', 'principiante intenso', 3,
       'Día 1: 30 minutos de entrenamiento cruzado. Opcional: clase de yoga o pilates\n
       Día 2: 5 minutos de paseo. 2 minutos de carrera a ritmo fácil. Repetir 3 veces. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 3:     Día de descanso.\n
       Día 4: 5 minutos de paseo. 3 minutos de carrera a ritmo fácil. Repetir 2 veces. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 5: Día de descanso.\n
       Día 6: 60 minutos de paseo a ritmo ligero. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 7:  Día de descanso.\n
       '). 
rutina('Mejora tu forma',"correr", ' ', 'intermedio', 4,
       'Día 1: Día de descanso.\n
       Día 2: 25 minutos de carrera a ritmo fácil. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 3: 10 minutos de calentamiento. 5 minutos de carrera a ritmo de serie. 2 minutos de trote de recuperación. Repetir 4 veces. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 4: 30 minutos de carrera a ritmo fácil. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 5: Día de descanso.\n
       Día 6: 45 minutos de carrera, varía la intensidad durante la sesión de entrenamiento. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 7: 30 minutos de entrenamiento cruzado.\n
       ') . 
rutina('Preparación Medio maratón',"correr", 'hipertension', 'avanzado', 4,
       'Día 1: Día de descanso.\n
       Día 2: 35 minutos de carrera a ritmo fácil. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 3: 40 minutos de carrera a ritmo constante. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 4: Día de descanso.\n
       Día 5: 40 minutos de entrenamiento cruzado.\n
       Día 6: 25 minutos de carrera. Variar la intensidad durante la sesión de entrenamiento. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 7: 60 minutos de carrera a ritmo fácil. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       ') . 
rutina('Preparación 10k',"correr", 'hipertension', 'intermedio intenso', 4,
       'Día 1: Día de descanso.\n
       Día 2: 25 minutos de carrera a ritmo fácil. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 3: 10 minutos de calentamiento. 5 minutos de carrera a ritmo de serie. 2 minutos de trote de recuperación. Repetir 4 veces. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 4: 30 minutos de carrera a ritmo fácil. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 5: Día de descanso.\n
       Día 6: 60 minutos de carrera a ritmo fácil. 5 a 10 minutos de enfriamiento. Estiramientos.\n
       Día 7: 30 minutos de entrenamiento cruzado.\n 
       ') . 

%Ciclismo
rutina('Preparación 100k',"ciclismo", ' ', 'principiante', 3,
       'Zonas = Zona 1 (93 – 110)ppm , Zona 2 (111 – 130)ppm, Zona 3 (131 – 148)ppm, Zona 4 (149 – 167)ppm, Zona 5 (167-185)ppm\n
       Lunes: - Haz un calentamiento rápido.- Monta 90 minutos a un ritmo constante (en la zona 2 la mayor parte del tiempo).Si quieres, puedes montar a ritmo siempre que mantengas el promedio total del entrenamiento en la zona 2.\n
       Martes: - Descanso\n
       Miércoles: - Descanso\n
       Jueves: - Descanso\n
       Viernes: - Sesión de entrenamiento de 60 minutos- Haz un calentamiento rápido.- Monta 5 minutos a ritmo. Descansa todo lo que necesites Repite 3 veces. Intenta montar en la parte alta de la zona 3 en los intervalos. Puedes repartir los intervalos o realizarlos juntos, dependiendo de por dónde estés montando y de cómo te sientas.\n
       Sábado: - Sesión de entrenamiento de 60 minutos- Haz un calentamiento rápido. Monta 5 minutos en tu umbral. Descansa todo lo que necesites Repite 3 veces.- Hacia el final de la hora, monta por la zona 2.- Vuelve a un ritmo bajo.  Puedes repartir los intervalos o realizarlos juntos, dependiendo de por dónde estés montando y de cómo te sientas.\n
       Domingo:- Descanso\n
       '). 
rutina('Recorrido 100k',"ciclismo", ' ', 'principiante intenso', 3,
       'Lunes: - Sesión de entrenamiento de 2 horas- Haz un calentamiento sencillo.- Monta en la zona 2.- Pedalea durante 5 minutos. Este entrenamiento se puede hacer en bicicleta o en un entrenamiento cruzado, como senderismo.\n
       Martes: - Descanso\n
       Miércoles: - Haz el calentamiento.- Monta 30 segundos al máximo esfuerzo. Repite de 3 a 5 veces. Descansa 8 minutos en la zona 1.- Vuelve a la calma. Debes realizar cada repetición al máximo esfuerzo. Empieza con 3 repeticiones y comprueba qué tal te sientes antes de intentar hacer 5 repeticiones.\n
       Jueves: - Descanso\n
       Viernes: - Sesión de entrenamiento de 60 minutos- Haz el calentamiento.- Monta 20 segundos a una GRAN intensidad y luego 40 segundos de forma relajada. Repite 4 veces.- Descansa 5 minutos en la zona 1.Repite este proceso 2 veces más.- Monta durante 15 minutos para completar la hora. Intenta mantener un esfuerzo que te permita completar las 4 repeticiones de cada grupo sin parar.\n
       Sábado: - Sesión de entrenamiento de 60 minutos- Haz un calentamiento sencillo.- Monta en la zona 2.- Pedalea durante 5 minutos para volver a la calma. Se puede hacer en interiores y exteriores. Este entrenamiento se puede hacer en bicicleta o en un entrenamiento cruzado, como senderismo.\n
       Domingo: - Descanso\n
       ').
rutina('Mantener desarrollo para 100k',"ciclismo", ' ', 'intermedio', 4,
       'Lunes: - Sesión de entrenamiento de 2 horas- Haz un calentamiento sencillo.- Monta en la zona 2.- Pedalea durante 5 minutos. Este entrenamiento se puede hacer en bicicleta o en un entrenamiento cruzado, como senderismo.\n
       Martes: - Descanso\n
       Miércoles: - Sesión de entrenamiento de 60 minutos- Haz el calentamiento.- Monta 15 minutos en tu umbral. Descansa 3 minutos en la zona 2. Repite 2 veces. Se puede hacer en interiores o en una cuesta.\n
       Jueves: - Descanso\n
       Viernes: - Sesión de entrenamiento de 60 minutos- Haz un calentamiento rápido.- 3 pirámides de esfuerzo: - 3 minutos en la zona 3.- 2 minutos en la zona 4.- 1 minuto en la zona 5.- 2 minutos en la zona 4.- 3 minutos en la zona 3.- 5 minutos a ritmo de recuperación en zona 1 entre pirámides.\n
       Sábado: - Sesión de entrenamiento de 60 minutos- Haz un calentamiento sencillo.- Monta en la zona 2.- Pedalea durante 5 minutos para volver a la calma.\n
       Domingo: - Descanso\n
       '). 
rutina('Preparación para 120k o más',"ciclismo", 'escoliosis', 'intermedio intenso', 4,
       'Lunes: - Sesión de entrenamiento de 120 minutos- Haz un calentamiento sencillo.- Monta en la zona 2.- Pedalea durante 5 minutos.\n
       Martes: - Descanso\n
       Miércoles: - Haz el calentamiento.- Monta 30 segundos al máximo esfuerzo. Repite de 3 a 5 veces. Descansa 8 minutos en la zona 1.- Vuelve a la calma. Debes realizar cada repetición al máximo esfuerzo. Empieza con 3 repeticiones y comprueba qué tal te sientes antes de intentar hacer 5 repeticiones.\n
       Jueves: - Descanso\n
       Viernes: - Sesión de entrenamiento de 90 minutos- Haz el calentamiento.- Monta a gran intensidad durante 30 segundos y en tu umbral durante 10 minutos. Repite 2 veces.- Monta 35 minutos en la zona 2.\n
       Sábado: - Sesión de entrenamiento de 180 minutos- Haz un calentamiento sencillo.- Monta en la zona 2.- Pedalea durante 5 minutos para volver a la calma.\n
       Domingo: - Descanso
       '). 
rutina('Mantener desarrollo para 120km o más',"ciclismo", 'cardiopata', 'avanzado', 4,
       'Lunes: - Descanso\n
       Martes: - Sesión de entrenamiento de 180 minutos- Haz un calentamiento sencillo.- Monta en la zona 2.- Pedalea durante 5 minutos para volver a la calma.\n
       Miércoles: - Sesión de entrenamiento de 90 minutos- Haz un calentamiento rápido.- Monta 10 minutos a ritmo en la parte alta de la zona 3. Descansa todo lo que necesites Repite 3 veces. Intenta mantenerte en la parte alta de la zona 3 en los intervalos. Puedes repartir los intervalos o realizarlos juntos, dependiendo de por dónde estés montando y de cómo te sientas.\n
       Jueves: - Descanso\n
       Viernes: - Sesión de entrenamiento de 60 minutos- Haz el calentamiento.- Monta 2 minutos en la zona 5 con una cadencia superior a 90 RPM. Monta 4 minutos a ritmo de recuperación. Repite 4 veces.- Vuelve a la calma.\n
       Sábado: - Haz un calentamiento rápido.- Monta 90 minutos a un ritmo constante (en la zona 2 la mayor parte del tiempo).Si quieres, puedes montar a ritmo siempre que mantengas el promedio total del entrenamiento en la zona 2.\n
       Domingo: - Sesión de entrenamiento de 180 minutos- Haz un calentamiento sencillo.- Monta en la zona 2.- Pedalea durante 5 minutos para volver a la calma.\n
       '). 
       

       
% Union
 
%buscarRutina(Nombre,Deporte,Padecimientos,Nivel,Dias, Detalle):- rutina(Nombre,Deporte,Padecimientos,Nivel,Dias, Detalle).

%Busca en el nivel en el que se encuentra el usuario
buscarNivel(Nivel,Cantidad):- nivel(Nivel,Cantidades), miembro(Cantidad, Cantidades).
miembro(X,[X|_]).
miembro(X,[_|Y]):- miembro(X,Y).
