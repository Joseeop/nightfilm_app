

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightfilm/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:nightfilm/infrastructure/repositories/actor_repository_impl.dart';

final actorRepositoryProvider = Provider((ref){

  return ActorRepositoryImpl(ActorMovieDbDatasource());
 // return MovieRepositoryImpl(MovieIMBDatasource());
});