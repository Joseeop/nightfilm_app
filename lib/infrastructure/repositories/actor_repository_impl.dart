

import 'package:nightfilm/domain/datasources/actors_datasource.dart';
import 'package:nightfilm/domain/entities/actor.dart';
import 'package:nightfilm/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository{

  final ActorDatasource datasource;

  ActorRepositoryImpl(this.datasource);


  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    return datasource.getActorByMovie(movieId);
  }

}