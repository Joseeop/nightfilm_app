import 'package:nightfilm/domain/entities/movie.dart';
import 'package:nightfilm/infrastructure/models/moviedb/movie_details.dart';
import 'package:nightfilm/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) {
    String posterPath = moviedb.posterPath;
    if (posterPath.isEmpty) {
      // Asignar una URL de imagen predeterminada cuando no hay imagen disponible
      posterPath = 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg';
    } else {
      posterPath = 'https://image.tmdb.org/t/p/w500$posterPath';
    }

    return Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath.isNotEmpty)
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: posterPath,
      releaseDate: moviedb.releaseDate !=null? moviedb.releaseDate! : DateTime.now(),
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount,
    );
  }

 static Movie movieDetailsToEntity(MovieDetails moviedb) {
  String posterPath = moviedb.posterPath;
  if (posterPath.isEmpty) {
    // Asignar una URL de imagen predeterminada cuando no hay imagen disponible
    posterPath = 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg';
  } else {
    posterPath = 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  return Movie(
    adult: moviedb.adult,
    backdropPath: (moviedb.backdropPath.isNotEmpty)
        ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
        : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
    genreIds: moviedb.genres.map((e) => e.name).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath: posterPath,
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
  );
}}