



import 'package:dio/dio.dart';
import 'package:nightfilm/config/constants/environment.dart';
import 'package:nightfilm/domain/datasources/actors_datasource.dart';
import 'package:nightfilm/domain/entities/actor.dart';
import 'package:nightfilm/infrastructure/mappers/actor_mapper.dart';
import 'package:nightfilm/infrastructure/models/moviedb/credits_reponse.dart';

class ActorMovieDbDatasource extends ActorDatasource{
  final dio =Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.movieDbKey,
      'language':'es'
    }
  ));





  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    final response = await dio.get(
      '/movie/$movieId/credits'
      );
      
    final casteResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors= casteResponse.cast.map((cast) => ActorMapper.castToEntity(cast)).toList();

     return actors;
  }

}