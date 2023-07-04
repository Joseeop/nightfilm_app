import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightfilm/presentation/providers/providers.dart';

import 'package:nightfilm/presentation/widgets/widgets.dart';






class HomeScreen extends StatelessWidget {
//Para llegar a esta pantalla
  static const name = 'home-screen';

  final Widget childView;
  const HomeScreen({
    super.key, 
    required this.childView});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:childView,
     bottomNavigationBar:const CustomBottomNavigation() ,
        
      
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