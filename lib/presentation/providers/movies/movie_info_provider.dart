
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightfilm/presentation/providers/movies/movies_repository_provider.dart';

import '../../../domain/entities/movie.dart';


final movieInfoProvider= StateNotifierProvider<MoviesMapNotifier,Map<String,Movie>>((ref){
  final movieRepository = ref.watch(movieRepositoryProvider);
return MoviesMapNotifier(getMovie: movieRepository.getMovieById);
});

typedef GetMovieCallback = Future <Movie> Function (String movieId);

class MoviesMapNotifier extends StateNotifier<Map<String,Movie>>{

final GetMovieCallback getMovie;

MoviesMapNotifier({
 required this.getMovie
 }):super({});


Future<void> loadMovie(String movieId) async{
  if( state[movieId]!=null) return;
  //print ('Realizando petición http');

  final movie = await getMovie(movieId);

  state= {...state,movieId:movie};

}
}