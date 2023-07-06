import 'package:isar/isar.dart';
import 'package:nightfilm/domain/datasources/local_storage_datasource.dart';
import 'package:nightfilm/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource{
  
  late Future<Isar> db;

  IsarDatasource(){
    db=openDB();
  }

  Future <Isar> openDB() async{

    final dir= await getApplicationDocumentsDirectory();

    if(Isar.instanceNames.isEmpty){
      return await Isar.open(
      [MovieSchema],
      inspector: true,
      directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }


  
  @override
  Future<bool> isMovieFavorite(int movieId) async {
    //Esperamos que la db esté arriba
    //Vamos al esquema movies-> le decimos a Isar que vamos a filtrar
    //-> filtramos por que el id sea igual al movieID que recibimos por parámetros
    final isar = await db;
    final Movie? isFavoriteMovie = await isar.movies
    .filter()
    .idEqualTo(movieId)
    .findFirst();

    return isFavoriteMovie !=null;
  }



  @override
  Future<void> toggleFavorite(Movie movie) async{
    final isar = await db;

    final favortiteMovie = await isar.movies
    .filter()
    .idEqualTo(movie.id)
    .findFirst();

  if( favortiteMovie != null){
    //borrar
    isar.writeTxnSync(() => isar.movies.deleteSync(favortiteMovie.isarId!));
    return;
  }

  //Insertar
  isar.writeTxnSync(() => isar.movies.putSync(movie));
  }


    @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async{
    
    final isar = await db;

    return isar.movies.where()
    .offset(offset)
    .limit(limit)
    .findAll();
  }

}