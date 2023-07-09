import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightfilm/presentation/providers/storage/favorites_movies_provider.dart';
import 'package:nightfilm/presentation/widgets/movies/movie_masonry.dart';



class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage() ;
    
  }

  void loadNextPage() async{
    //Si está cargando o si estamos en la última página salimos de la función
    if ( isLoading || isLastPage )return;
    isLoading = true;

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty){
      isLastPage=true;
    }

  }

  @override
  Widget build(BuildContext context) {
    //Listamos el mapa de películas
    final favoritesMovies = ref.watch(favoriteMoviesProvider).values.toList();


    return Scaffold(
      body : MovieMasonry(
        loadNextPage: loadNextPage,
        movies: favoritesMovies)
    );
  }
}