import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/presentation/router/app_routes.dart';
import 'package:movie_db/presentation/ui/screens/details_screen.dart';
import 'package:movie_db/presentation/ui/screens/home_screen.dart';
import 'package:movie_db/presentation/ui/screens/library_screen.dart';
import 'package:movie_db/presentation/ui/screens/search_screen.dart';

import '../ui/screens/main_screen.dart';


class AppRouter {

static final GoRoute details = GoRoute(path: 'details', name: "Details",builder:  (context, state) {
  return DetailsScreen(key: state.pageKey,);
});
  // static final GoRouter _router = GoRouter(routes: [
  //   GoRoute(
  //       // path: AppRoutes.main, builder: (context, state) => const MainScreen()),
  //   GoRoute(path: AppRoutes.home, builder: (context, state) => const HomeScreen()),
  //   GoRoute(path: AppRoutes.details, builder: (context, state) => const DetailsScreen()),
  //   GoRoute(path: AppRoutes.search, builder: (context, state) => const SearchScreen()),
  //   GoRoute(path: AppRoutes.library, builder: (context, state) => const LibraryScreen()),
  // ]);

  // static GoRouter get router => _router;
}