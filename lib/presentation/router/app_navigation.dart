
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/models/search_results_model.dart';
import 'package:movie_db/presentation/ui/screens/details_screen.dart';
import 'package:movie_db/presentation/ui/screens/home_screen.dart';
import 'package:movie_db/presentation/ui/screens/library_screen.dart';
import 'package:movie_db/presentation/ui/screens/main_screen.dart';
import 'package:movie_db/presentation/ui/screens/search_screen.dart';
import 'package:movie_db/presentation/ui/screens/series_details_screen.dart';
import 'package:movie_db/presentation/ui/screens/settings_screen.dart';
import 'package:movie_db/presentation/ui/widgets/movies_grid_widget.dart';
import 'package:movie_db/presentation/ui/widgets/movies_list_widget.dart';
import 'package:movie_db/presentation/ui/widgets/search_results_widget.dart';
import 'package:movie_db/presentation/ui/widgets/tv_series_list.dart';
import 'package:movie_db/domain/models/auth_model.dart';
import 'package:movie_db/presentation/ui/screens/login_screen.dart';


class AppNavigation {

  AppNavigation._();



  static String initR = '';
   initialRoute(bool isAuth) => isAuth ? initR = '/home' : '/login';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _rootNavigatorSearch = GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
  static final _rootNavigatorLibrary = GlobalKey<NavigatorState>(debugLabel: 'shellLibrary');
  static final _rootNavigatorSetting = GlobalKey<NavigatorState>(debugLabel: 'shellSetting');
  static final _rootNavigatorLogin = GlobalKey<NavigatorState>(debugLabel: 'shellLogin');

  static final GoRouter router =
      GoRouter(initialLocation: initR, navigatorKey: _rootNavigatorKey, debugLogDiagnostics: true, routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigatorShell) {
          return MainScreen(
            navigationShell: navigatorShell,
            isLogged: initR == '/home',
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(navigatorKey: _rootNavigatorHome, routes: [
            GoRoute(
                path: '/home',
                name: 'Home',
                builder: (context, state) {
                  return HomeScreen(
                    key: state.pageKey,
                  );
                },
                routes: [

                  GoRoute(
                      path: 'slider',
                      name: 'slider',
                      builder: (context, state) {
                        return SettingsScreen(
                          key: state.pageKey,
                        );
                      },
                      routes: [
                        GoRoute(
                            path: 'details2',
                            name: "details2",
                            builder: (context, state) {
                              return DetailsScreen(
                                key: state.pageKey,
                              );
                            })
                      ]),
                  GoRoute(
                      path: 'movsList',
                      name: "movsList",
                      builder: (context, state) {
                        return MoviesListWidget(
                          key: state.pageKey,
                          movies: [],
                          title: '',
                          genres: null,
                        );
                      },
                      routes: [
                        GoRoute(
                            path: 'movlistDetails',
                            name: "movlistDetails",
                            builder: (context, state) {
                              return DetailsScreen(
                                key: state.pageKey,
                              );
                            }),
                      ]),
                  GoRoute(path: 'tvList', name: 'tvList', builder: (context, state ){
                    return const TvSeriesList(series: [], title: 'title');
                  },
                  routes: [
                    GoRoute(path: 'tvDetails', name: 'tvDetails', builder: (context, state) {
                      return const TvSeriesDetailsScreen();
                    })
                  ]
                  )
                ]),
          ]),
          StatefulShellBranch(navigatorKey: _rootNavigatorSearch, routes: [
            GoRoute(
                path: '/search',
                name: 'Search',
                builder: (context, state) {
                  return SearchScreen(
                    key: state.pageKey,
                  );
                },
                routes: [
                  GoRoute(
                      path: 'movsGrid',
                      name: 'movsGrid',
                      builder: (context, state) {
                        return const MoviesGridWidget(
                          movies: [],
                        );
                      },
                      routes: [
                        GoRoute(
                            path: 'searchDetails',
                            name: "searchDetails",
                            builder: (context, state) {
                              return DetailsScreen(
                                key: state.pageKey,
                              );
                            })
                      ]),
                  GoRoute(
                      path: 'movSearch',
                      name: 'movSearch',
                      builder: (context, state) {
                        return SearchResultsWidget(
                          searchResult: SearchResultsModel(),
                        );
                      },
                      routes: [
                        GoRoute(
                            path: 'movSearchDetails',
                            name: "movSearchDetails",
                            builder: (context, state) {
                              return DetailsScreen(
                                key: state.pageKey,
                                inSearch: true,
                              );
                            }),
                        GoRoute(
                            path: 'tvSearchDetails',
                            name: "TvSearchDetails",
                            builder: (context, state) {
                              return TvSeriesDetailsScreen(
                                key: state.pageKey,
                                inSearch: true,
                              );
                            }),
                      ]),
                  // GoRoute(path: 'searchDetails', name: "DetailsSearch",builder:  (context, state) {
                  //   return DetailsScreen(key: state.pageKey,);
                  // })
                ])
          ]),
          StatefulShellBranch(navigatorKey: _rootNavigatorLibrary, routes: [
            GoRoute(
                path: '/library',
                name: 'Library',
                builder: (context, state) {
                  return LibraryScreen(
                    key: state.pageKey,
                  );
                })
          ]),
          StatefulShellBranch(navigatorKey: _rootNavigatorSetting, routes: [
            GoRoute(
                path: '/settings',
                name: 'Settings',
                builder: (context, state) {
                  return SettingsScreen(
                    key: state.pageKey,
                  );
                })
          ]),
          StatefulShellBranch(navigatorKey: _rootNavigatorLogin, routes: [
            GoRoute(path: '/login', name: 'login', builder: (context, state) => AuthProvider(model: AuthModel(), child:  LoginScreen(key: state.pageKey,))),
          ]),
        ]),
  ]);
}
