

import 'package:nightfilm/domain/datasources/movies_datasource.dart';
import 'package:nightfilm/domain/entities/movie.dart';
import 'package:nightfilm/domain/repositories/movies_repositories.dart';

class MovieRepositoryImpl extends MoviesRepository{

  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
   
    
    return datasource.getNowPlaying(page:page);
  }

}
