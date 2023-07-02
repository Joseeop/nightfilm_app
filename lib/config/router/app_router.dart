


import 'package:go_router/go_router.dart';

import 'package:nightfilm/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes:[


    
    GoRoute(path: '/',
    name:HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
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
    
    


  ] );