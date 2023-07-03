



import 'package:dio/dio.dart';
import 'package:nightfilm/config/constants/environment.dart';
import 'package:nightfilm/domain/datasources/movies_datasource.dart';
import 'package:nightfilm/domain/entities/movie.dart';
import 'package:nightfilm/infrastructure/mappers/movie_mapper.dart';
import 'package:nightfilm/infrastructure/models/moviedb/movie_details.dart';
import 'package:nightfilm/infrastructure/models/moviedb/moviedb_response.dart';

//!CLIENTE DE PETICIONES HTTP PARA THEMOVIEDB

class MoviedbDatasource extends MoviesDatasource{
  final dio =Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.movieDbKey,
      'language':'es'
    }
  ));

  List <Movie> _jsonToMovies(Map<String,dynamic>json){
    final movieDBResponse= MovieDbResponse.fromJson(json);

      final List<Movie> movies=movieDBResponse.results
      //Si no pasa esta condición no cargamos la película.
      .where((moviedb) => moviedb.posterPath != 'no-poster')
      .map(
        (moviedb) => MovieMapper.movieDBToEntity(moviedb)
        ).toList();

    
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

      final response = await dio.get('/movie/now_playing',
      queryParameters:{
        'page':page
      } );
      
     return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async{
   final response = await dio.get('/movie/popular',
      queryParameters:{
        'page':page
      } );
       return _jsonToMovies(response.data);
}
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async{
   final response = await dio.get('/movie/upcoming',
      queryParameters:{
        'page':page
      } );
       return _jsonToMovies(response.data);
}
 @override
  Future<List<Movie>> getTopRated({int page = 1}) async{
   final response = await dio.get('/movie/top_rated',
      queryParameters:{
        'page':page
      } );
       return _jsonToMovies(response.data);
}

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    if(response.statusCode != 200) throw Exception('Movie with id: $id not found');

    final movieDetails= MovieDetails.fromJson(response.data);
    final Movie movie= MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
      



  }
  
  @override
  Future<List<Movie>> searchMovie(String query) async{

    final response = await dio.get('/search/movie',
      queryParameters:{
        'query':query
      } );
       return _jsonToMovies(response.data);
  }
}