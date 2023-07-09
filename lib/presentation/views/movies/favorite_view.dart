import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

    if (favoritesMovies.isEmpty){
      final colors = Theme.of(context).colorScheme;

      return Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border_sharp ,size: 60, color: colors.primary),
          Text('¡Vaaaaaya!', style: TextStyle(fontSize: 30, color: colors.primary)),
          const Text('No tienes películas favoritas',style: TextStyle(fontSize: 20,color: Colors.black45),),
          const SizedBox(height: 20,),
          FilledButton.tonal(
            onPressed: () => context.go('/home/0'), 
            child: const Text('Busca tus películas favoritas'))
        ],
       )
      );
    }


    return Scaffold(
      body : MovieMasonry(
        loadNextPage: loadNextPage,
        movies: favoritesMovies)
    );
  }
}