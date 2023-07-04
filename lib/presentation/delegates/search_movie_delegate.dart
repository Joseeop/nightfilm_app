

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:nightfilm/config/helpers/human_formats.dart';
import 'package:nightfilm/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future <List<Movie>> Function (String query);

//Regresamos una Movie para cuando pulsemos atrás.
class SearchMovieDelegate extends SearchDelegate<Movie?>{

  final SearchMoviesCallback searchMovies;
   List <Movie> initialMovies;
  //Podemos tener múltiples listeners
  StreamController <List<Movie>> debouncedMovies= StreamController.broadcast();
  Timer? _debounceTimer;
  

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
    });

//Función para cerrar el delegate
    void clearStreams(){
      debouncedMovies.close();
    }


    void _onQueryChaned(String query) {

      print('Cambió el query');
        if (_debounceTimer?.isActive ?? false)_debounceTimer!.cancel();
        //Esperamos a que el usuario deje de escribir en la barra de búsqueda para realizar peticiones y que no lo haga con cada letra que escriba.
        _debounceTimer= Timer(const Duration(microseconds: 500), () async{
    
         //Si ya tenemos valor en el query:

         final movies = await searchMovies(query);
         debouncedMovies.add(movies);
         initialMovies = movies;
        });
    }

//Sobreescribimos el método searchFieldLabel para personalizar el hint de búsqueda.
  @override
  String get searchFieldLabel => 'Buscar película';

  Widget buildResultsAndSuggestions(){
    return StreamBuilder(
    initialData: initialMovies,
    stream: debouncedMovies.stream,
    builder:(context, snapshot) {

      

     //! Revisar peticiones print('Realizando petición');

      final  movies = snapshot.data ?? [];
      return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) => _MovieItem( 
          movie : movies[index],
          onMovieSelected: (context,movie){
            clearStreams();
            close(context,movie);
            })
        

        
      ,);
    },);
  }

  //Defininimos acciones
  @override
  List<Widget>? buildActions(BuildContext context) {

   
    
    return[
      //Comprobamos si la query está vacía para que aparezca el icono si hay algo escrito.
      //if(query.isNotEmpty)
         //IconButton que borrará el query y lo pondrá en campo vacío al pulsarlo.
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          onPressed: ()=> query = '' ,
          icon: const Icon(Icons.clear)
          ),
      )
      

      
     
      
    ];
  }

//Defininimos apariencia
  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(onPressed: () => {
        clearStreams(),
        close(context, null)
        } ,
       icon: const Icon(Icons.arrow_back_rounded));
    
  }

//Defininimos resultados cuando pulsamos enter
  @override
  Widget buildResults(BuildContext context) {
   
   return buildResultsAndSuggestions();
  }

//Defininimos sugerencias
  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChaned(query);
   
   return buildResultsAndSuggestions();
      
  }


}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({
    required this.movie, 
    required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    //Envolvemos el padding en un nuevo widget para reaccionar cuando hagamos click en cada película de la lista.
    return GestureDetector(
      onTap: (){
        onMovieSelected(context,movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Row(children: [
    
          //Image
          SizedBox(
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(movie.posterPath,
              loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),),
              
            ),
          ),
    
          //descripción
    
          const SizedBox(width: 10,),
    
          SizedBox(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,style: textStyle.titleMedium,),
                (movie.overview.length > 100)
                ?Text('${movie.overview.substring(0,100)}...')
                : Text(movie.overview),
    
              Row(children: [
                Icon(Icons.star_half_rounded,color: Colors.yellow.shade800),
                const SizedBox(width: 5),
                Text (HumanFormats.number(movie.voteAverage,1),
                style:  textStyle.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                )
              ],)
              ],
            ),
          )
        ]),
        
        
        ),
    );
  }
}