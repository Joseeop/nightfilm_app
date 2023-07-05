import 'package:flutter/material.dart';
import 'package:nightfilm/presentation/views/movies/home_view.dart';
import 'package:nightfilm/presentation/views/views.dart';


import 'package:nightfilm/presentation/widgets/widgets.dart';






class HomeScreen extends StatelessWidget {
//Para llegar a esta pantalla
  static const name = 'home-screen';
  final int pageIndex;
  const HomeScreen({
    required this.pageIndex,
    super.key});

    final viewRoutes = const <Widget>[
      HomeView(),
      SizedBox(),
      FavoritesView()
    ];

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      //! IndexedStack Widget nos permite mantener el "momentum" cuando cambiamos de views.
      body:IndexedStack(
        index: pageIndex,
        children:viewRoutes,
      ),
     bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex) ,
        
      
    );
  }
}




//!StatefulWidget debe tener initState


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