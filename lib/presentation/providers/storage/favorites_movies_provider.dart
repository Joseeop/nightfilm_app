


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightfilm/domain/entities/movie.dart';
import 'package:nightfilm/domain/repositories/local_storage_repository.dart';
import 'package:nightfilm/presentation/providers/providers.dart';

final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int,Movie>> ((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
},);

/*
Llave movie Id que apunta al objeto de la película
  {
    1234: Movie,
    12214: Movie,
    1236: Movie,
    1268: Movie,
  }
*/

class StorageMoviesNotifier  extends StateNotifier <Map<int, Movie>>{
  int page = 0;
  final LocalStorageRepository localStorageRepository;
  

  
  StorageMoviesNotifier({
    
     required this.localStorageRepository}):super({});


     Future <void> loadNextPage() async{
      final movies = await localStorageRepository.loadMovies(offset: page *10);
      page++;
      final tempMoviesMap= <int,Movie>{};
      //Pasamos el listado de movies a un mapa

      for (final movie in movies){
        tempMoviesMap[movie.id] = movie;

      
     }
        state = {...state, ...tempMoviesMap};
       // return movies;
}


}