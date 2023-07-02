

import 'package:nightfilm/domain/entities/actor.dart';

abstract class ActorDatasource{
  Future <List<Actor>> getActorByMovie(String movieId);
}