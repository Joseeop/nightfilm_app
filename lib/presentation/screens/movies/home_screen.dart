import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightfilm/presentation/providers/providers.dart';

import 'package:nightfilm/presentation/widgets/widgets.dart';






class HomeScreen extends StatelessWidget {
//Para llegar a esta pantalla
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:_HomeView(),
     bottomNavigationBar:CustomBottomNavigation() ,
        
      
    );
  }
}




//!StatefulWidget debe tener initState
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);

    if(initialLoading) return const FullScreenLoader();
    
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    final nowPlayingMovies= ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);

    

//!Envolvemos el Column en SingleChildScrollView este widget que nos sirve para hacer scroll vertical y que no se desborde la pantalla.
    return CustomScrollView(
      slivers:[
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            titlePadding: EdgeInsets.zero,
            centerTitle: false,
          ),
        ),
        SliverList(
          delegate:SliverChildBuilderDelegate(
            (context, index){
                return Column(     
    
        children: [
         // const CustomAppbar(),
    
          //if(moviesSlideshow.isEmpty)
          MoviesSlidehow(movies: moviesSlideshow),
    
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title:'En cines',
            subTitle: 'Lunes 20',
            loadNextPage: (){
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
            ),
    
           MovieHorizontalListview(
            movies: upComingMovies,
            title:'Próximamente',
            subTitle: 'Este mes',
            loadNextPage: (){
              ref.read(upComingMoviesProvider.notifier).loadNextPage();
            },
            ),
             MovieHorizontalListview(
            movies: popularMovies,
            title:'Populares',
            //subTitle: '',
            loadNextPage: (){
              ref.read(popularMoviesProvider.notifier).loadNextPage();
            },
            ),
             MovieHorizontalListview(
            movies: topRatedMovies,
            title:'Mejor valorados',
            subTitle: 'De siempre',
            loadNextPage: (){
              ref.read(topRatedMoviesProvider.notifier).loadNextPage();
            },
            ),
            const SizedBox(height: 50,)
        ],
      );
          },
          childCount: 1
          )
           )
      ]
       
    );
  }
}

// Expanded(
        //   child: ListView.builder(
        //       itemCount: nowPlayingMovies.length,
        //       itemBuilder: (context,index){
        //   final movie=nowPlayingMovies[index];
        //   return ListTile(
        //     title: Text(movie.title),
        //     //subtitle: Text(movie.overview),
        //   );
        //       } ),
        // )