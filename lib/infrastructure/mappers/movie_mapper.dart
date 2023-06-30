



import 'package:nightfilm/domain/entities/movie.dart';
import 'package:nightfilm/infrastructure/models/moviedb/movie_moviedb.dart';


//Tomar implementaión específica de TheMovieDB y transformalo a mi entidad.
//Así solo tendríamos que venir a nuestro mapper si cualquier de las variables cambiase. Es una capa de protección contra cambios.
class MovieMapper{

  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult, 
    backdropPath: (moviedb.backdropPath !='')
     ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
     :'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(), 
    id: moviedb.id, 
    originalLanguage: moviedb.originalLanguage, 
    originalTitle: moviedb.originalTitle, 
    overview: moviedb.overview, 
    popularity: moviedb.popularity, 
    posterPath: (moviedb.posterPath !='')
    ?'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}' 
    :'no-poster',
    releaseDate: moviedb.releaseDate, 
    title: moviedb.title, 
    video: moviedb.video, 
    voteAverage: moviedb.voteAverage, 
    voteCount: moviedb.voteCount);

}