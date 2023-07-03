import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nightfilm/domain/entities/movie.dart';
import 'package:nightfilm/domain/repositories/movies_repositories.dart';
import 'package:nightfilm/presentation/delegates/search_movie_delegate.dart';
import 'package:nightfilm/presentation/providers/providers.dart';



class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle= Theme.of(context).textTheme.titleMedium;
    
    return  SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(Icons.movie_outlined,color: colors.primary),
            const SizedBox(width: 5),
             Text('Nightfilm',style: titleStyle),
             //widget que ocupe todo el espacio posible
             const Spacer(),
             //!Usamos SearchDelegate para hacer búsqueda, delegate será el encargado de realizar la búsqueda
             IconButton(onPressed: () {

              final movieRepository = ref.read(movieRepositoryProvider);

                showSearch<Movie?>(
                  context: context, 
                  delegate: SearchMovieDelegate(
                    searchMovies: movieRepository.searchMovie
                  )
                  ).then((movie) {
                    if(movie == null) return;
                      context.push('/movie/${movie.id}');   
                  });
                  
                      
                  
                  
                 
             }
             , icon: const Icon(Icons.search_outlined))
          ],
        ),
      ),),
    );
  }
}