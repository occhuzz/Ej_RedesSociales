using { miSuperLiga as my } from '../db/schema';

service ApiService @(_requires:'authenticated-user')
{
  entity Equipos as projection on my.Equipos;
  entity Estadios as projection on my.Estadios;
  entity Jugadores as projection on my.Jugadores;
  entity Partidos as projection on my.Partidos;
  entity Puntajes as projection on my.Puntajes;
  entity Resultados as projection on my.Resultados;

  entity VistaJugador as select from Jugadores
  {
    *,
    puntaje.gol as goles
  } where puntaje.gol > 3;

  entity VistaPartido as select from Partidos
  {
    *,
    equipoLocal.nombre as local,
    resultado.resultadoLocal as goles_local,
    equipoVisitante.nombre as visitante,
    resultado.resultadoVisitante as goles_visitante,
  } where (resultado.resultadoLocal - resultado.resultadoVisitante >= 3) or (resultado.resultadoVisitante - resultado.resultadoLocal >= 3);

  entity VistaArquero as select from Jugadores
  {
    *,
    puntaje.salvada as salvadas
  } where posicion = 'Arquero' order by salvadas desc limit 1;

  entity VistaPromedio as select from Jugadores
  {
    *,
    avg(puntaje.gol) as promedio_goles : Decimal(6,3)
  }group by ID,nombre order by promedio_goles desc;

  entity VistaGolesLocal as select from Partidos
  {
    sum(resultado.resultadoLocal) as suma_Local : Integer,
  } where equipoLocal.nombre = 'River Plate';

  entity VistaGolesVisitante as select from Partidos
  {
    sum(resultado.resultadoVisitante) as suma_Visitante : Integer,
  } where equipoVisitante.nombre = 'River Plate';
}