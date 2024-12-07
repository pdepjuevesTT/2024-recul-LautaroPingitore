% Solución en Prolog
% LAUTARO PINGITORE

% ===== PUNTO 1: HABLAR CON PROPIEDAD =====
viveEn(juan, casaDe(120)).
viveEn(fer, casaDe(110)).

viveEn(nico, departamento(3,2)).
viveEn(nico, departamento(3,1)).
viveEn(valen, departamento(4,1)).

viveEn(julian, loft(2000)).

lugarDeCasa(alf, almagro).
lugarDeCasa(juan, almagro).
lugarDeCasa(nico, almagro).
lugarDeCasa(julian, almagro).

lugarDeCasa(valen, flores).
lugarDeCasa(fer, flores).

% ===== PUNTO 2: BARRIO COPADO, INFIERNO CHICO =====
esUnBarrioCopado(Barrio) :-
    lugarDeCasa(_, Barrio),
    forall(lugarDeCasa(Persona, Barrio), viveEnCasaCopada(Persona)).

viveEnCasaCopada(Persona) :-
    viveEn(Persona, Casa),
    esCopada(Casa).

esCopada(casaDe(MetrosCuadrados)) :-
    MetrosCuadrados > 100.

esCopada(departamento(Ambientes, _)) :-
    Ambientes > 3.
esCopada(departamento(_, Banios)) :-
    Banios > 1.

esCopada(loft(Anio)) :-
    Anio > 2015.

% ===== PUNTO 3: BARRIO (CARO) TAL VEZ =====
esUnBarrioCaro(Barrio) :-
    lugarDeCasa(_, Barrio),
    forall(lugarDeCasa(Persona, Barrio), viveEnCasaCara(Persona)).

viveEnCasaCara(Persona) :-
    viveEn(Persona, Casa),
    esCara(Casa).

esCara(casaDe(MetrosCuadrados)) :-
        MetrosCuadrados >= 90.

esCara(departamento(Ambientes, _)) :-
    Ambientes > 2.

esCara(loft(Anio)) :-
    Anio > 2005.

% ===== PUNTO 4: TASA, TASA, TASACION DE LA CASA =====
cualesPuedeComprar(Plata, PropiedadesCompradas, PlataFinal) :-
    findall(Casa, (precioCasaDe(Casa, Precio), Precio =< Plata), PosiblesCasas),
    seleccionarPropiedades(PosiblesCasas, Plata, PropiedadesCompradas, PlataFinal).

seleccionarPropiedades(Casas, PlataInicial, PropiedadesCompradas, PlataFinal) :-
    comprarPropiedades(Casas, PlataInicial, PropiedadesCompradas, PlataFinal),
    PropiedadesCompradas \= []. 

comprarPropiedades([], Plata, [], Plata).

comprarPropiedades([_|Cola], PlataInicial, Propiedades, PlataFinal) :-
    comprarPropiedades(Cola, PlataInicial, Propiedades, PlataFinal).

comprarPropiedades([Casa|Cola], PlataInicial, [Casa|Propiedades], PlataFinal) :-
    precioCasaDe(Casa, Precio),
    PlataInicial >= Precio, 
    PlataRestante is PlataInicial - Precio,
    comprarPropiedades(Cola, PlataRestante, Propiedades, PlataFinal).

precioCasaDe(juan, 150000).
precioCasaDe(nico, 80000).
precioCasaDe(alf, 75000).
precioCasaDe(julian, 140000).
precioCasaDe(valen, 95000).
precioCasaDe(fer, 60000).