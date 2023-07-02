

import 'package:nightfilm/domain/entities/actor.dart';

abstract class ActorsRepository{
  Future <List<Actor>> getActorByMovie(String movieId);
}