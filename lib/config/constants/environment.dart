


import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{
  //Variable que hace referencia a nuestra APIkey
  static String movieDbKey=dotenv.env['THE_MOVIEDB_KEY']??'No hay api key';
}