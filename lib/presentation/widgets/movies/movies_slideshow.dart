import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:nightfilm/domain/entities/movie.dart';


class MoviesSlidehow extends StatelessWidget {


  const MoviesSlidehow({
    super.key, 
    required this.movies
    });

  final List <Movie> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      //double.infinity hace que tome todo el ancho posible
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        itemCount:movies.length,
        itemBuilder:(context,index){
          final movie=movies[index];
          return _Slide(movie: movie);
        }  ),
    );
  }
}


class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({
     
  required this.movie});

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow:const [
         BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset:Offset(0, 10)

        )
        
      ]
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover
          )
          )
          ),
          ) ;
  }
}