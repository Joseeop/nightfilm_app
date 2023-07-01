


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightfilm/domain/entities/movie.dart';
import 'package:nightfilm/presentation/providers/movies/movies_repository_provider.dart';

//Proveedor de información que notifica cuando  cambia el estado.
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref){
final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

return MoviesNotifier(
  fetchMoreMovies:fetchMoreMovies
  );
});


final popularMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref){
final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;

return MoviesNotifier(
  fetchMoreMovies:fetchMoreMovies
  );
});

final upComingMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref){
final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpComing;

return MoviesNotifier(
  fetchMoreMovies:fetchMoreMovies
  );
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref){
final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;

return MoviesNotifier(
  fetchMoreMovies:fetchMoreMovies
  );
});


typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>>{
  
  int currentPage =0;
  bool isLoading=false;
  MovieCallback fetchMoreMovies;    



  MoviesNotifier({
    required this.fetchMoreMovies
  }):super([]);

//Hacerle alguna modificiación al State
  Future <void> loadNextPage() async{
    if(isLoading) return;
    isLoading=true;
    print('loading more movies');
    currentPage++;
    


    final List<Movie> movies= await fetchMoreMovies(page:currentPage);
    state = [...state,...movies];
    isLoading=false;
  }
  
}