
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightfilm/presentation/providers/movies/movie_info_provider.dart';


class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie_screen';

  final String movieId;

  const MovieScreen({
    super.key, 
    required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
   
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Movie ID: ${widget.movieId}'),
      ),
    );
  }
}