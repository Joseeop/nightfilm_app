import 'package:animate_do/animate_do.dart';
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
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      //double.infinity hace que tome todo el ancho posible
      width: double.infinity,
      //Widget del paquete card_swiper que nos ayuda a manejar el swipe de las slides.
      child: Swiper(
        //Coloca los puntitos de referencia de las slides.
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top:0 ),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary )
        ),
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
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null){
                return const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.black12)
                  );
              }

              //FadeIn de animate_do simula una carga reciente de la imagen.
              return FadeIn(child : child);
            },
          )
          )
          ),
          ) ;
  }
}