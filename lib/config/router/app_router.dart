import 'package:go_router/go_router.dart';

import 'package:nightfilm/presentation/screens/screens.dart';
import 'package:nightfilm/presentation/views/home_views/favorites_view.dart';
import 'package:nightfilm/presentation/views/home_views/home_view.dart';

final appRouter = GoRouter(initialLocation: '/', 
routes: [
  ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                path: 'movie/:id',
                name: MovieScreen.name,
                builder: (context, state) {
                  final movieId = state.pathParameters['id'] ?? 'no-id';

                  return MovieScreen(movieId: movieId);
                },
              )
            ]),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesViews();
          },
        ),
        GoRoute(
          path: '/categories',
          builder: (context, state) {
            return const HomeView();
          },
        )
      ]),

  //!Rutas padre/hijo
  // GoRoute(path: '/',
  // name:HomeScreen.name,
  // builder: (context, state) => const HomeScreen(childView: HomeView()),
  // //Hacemos rutas hijas para no perder el botón atrás de navegación.
  // routes: [
  //   GoRoute(path: 'movie/:id',
  //   name:MovieScreen.name,
  //   builder: (context, state) {
  //   final movieId = state.pathParameters['id'] ?? 'no-id';

  //   return  MovieScreen(movieId: movieId);
  // }
  // ,)
  // ]

  // ),
]);
