using { cuid, managed } from '@sap/cds/common';
namespace miSuperLiga;

entity Partidos : cuid, managed
{
  cantidadEspectadores : Integer;
  arbitro : String(100);
  relator : String(100);
  fechaPartido : Date;
  clasico : Boolean;
  equipoLocal : Association to Equipos;
  equipoVisitante : Association to Equipos;
  puntaje : Association to many Puntajes on puntaje.partido =$self;
  estadio : Association to Estadios;
  resultado : Composition of many Resultados on resultado.partido =$self;
};

entity Resultados : cuid
{
  resultadoLocal : Integer;
  resultadoVisitante : Integer;
  partido : Association to Partidos;
};

entity Equipos : cuid
{
  nombre : String(100);
  division : String(100);
  puntos : Integer;
  cantidadJugadores : Integer;
  presupuesto : Integer;

  jugador : Composition of many Jugadores on jugador.equipo =$self;
  partido : Association to many Partidos on partido.equipoLocal =$self or partido.equipoVisitante =$self;
  estadio : Association to Estadios;
};

entity Jugadores : cuid
{
  nombre : String(100);
  valorMercado : Integer;
  apodo : String(100);
  posicion : String(100);
  pais : String(3);
  numeroRemera : Integer;
  equipo : Association to Equipos;
  puntaje : Association to many Puntajes on puntaje.jugador =$self;
}

entity Estadios : cuid
{
  nombre : String(100);
  direccion : String(100);
  capacidad : Integer;
  equipo : Association to many Equipos on equipo.estadio =$self;
  partido : Association to many Partidos on partido.estadio =$self;
};

entity Puntajes : cuid
{
  gol : Integer;
  asistencia : Integer;
  salvada : Integer;
  partido : Association to Partidos;
  jugador : Association to Jugadores;
}