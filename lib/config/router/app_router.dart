


import 'package:go_router/go_router.dart';

import 'package:nightfilm/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes:[


    
    GoRoute(
    path: '/home/:page',
    name:HomeScreen.name,
    builder: (context, state) {
      final pageIndex = state.pathParameters['page'] ?? '0';
      return  HomeScreen(pageIndex: int.parse(pageIndex) ,);
    },
    //Hacemos rutas hijas para no perder el botón atrás de navegación.
    routes: [
      GoRoute(path: 'movie/:id',
      name:MovieScreen.name,
      builder: (context, state) {
      final movieId = state.pathParameters['id'] ?? 'no-id';

      return  MovieScreen(movieId: movieId);
    } 
    ,)
    ]
    
    ),
    
    GoRoute(
      path: '/',
      //Cuando no necesitamos argumentos ponemos _,__
      redirect: (_, __) => '/home/0')
    


  ] );