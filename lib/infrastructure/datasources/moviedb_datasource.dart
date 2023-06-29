



import 'package:dio/dio.dart';
import 'package:nightfilm/config/constants/environment.dart';
import 'package:nightfilm/domain/datasources/movies_datasource.dart';
import 'package:nightfilm/domain/entities/movie.dart';

//!CLIENTE DE PETICIONES HTTP PARA THEMOVIEDB

class MoviedbDatasource extends MovieDatasource{
  final dio =Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.movieDbKey,
      'language':'es'
    }
  ));


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

      final response = await dio.get('/movie/now_playing');
      final List<Movie> movies=[];

    
    return movies;
  }



}