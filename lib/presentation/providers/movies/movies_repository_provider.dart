


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightfilm/infrastructure/datasources/moviedb_datasource.dart';
import 'package:nightfilm/infrastructure/repositories/movie_repository_impl.dart';


//Este repositorio es inmutable, solo de lectura.
final movieRepositoryProvider = Provider((ref){

  return MovieRepositoryImpl(MoviedbDatasource());
 // return MovieRepositoryImpl(MovieIMBDatasource());
});