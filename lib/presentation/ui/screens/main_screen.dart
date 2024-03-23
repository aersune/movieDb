import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/router/app_routes.dart';
import 'package:movie_db/presentation/ui/screens/details_screen.dart';
import 'package:movie_db/presentation/ui/screens/library_screen.dart';
import 'package:movie_db/presentation/ui/screens/search_screen.dart';
import 'package:movie_db/presentation/ui/screens/settings_screen.dart';

import '../../../domain/bloc/movies_db/movies_db_bloc.dart';
import 'home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const LibraryScreen(),
    const SettingsScreen(),
  ];

  void _goToBranch(int index){
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainDark,
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          context.read<MoviesDbBloc>().add(MoviesLoadEvent());
         // if(index < 4) {
           _goToBranch(index);
         // }
          context.read<NavigateProvider>().changePage(page: index);
        },
          currentIndex: context.watch<NavigateProvider>().pageIndex,
          backgroundColor: AppColors.appDark,
          items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled, color: Colors.red,),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_rounded,color: Colors.red,),
            label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_outline,color: Colors.red,),
            label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings,color: Colors.red,),
            label: ''
        ),

      ]),

      // CupertinoTabScaffold(
      //
      //     tabBar: CupertinoTabBar(
      //         currentIndex: context.watch<NavigateProvider>().pageIndex,
      //         activeColor: AppColors.lightColor,
      //         inactiveColor: AppColors.whiteColor,
      //         backgroundColor: AppColors.appDark,
      //         onTap: (index){
      //           context.read<NavigateProvider>().changePage(page: index);
      //         },
      //         items: const [
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.home_filled),
      //           ),
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.dashboard_rounded),
      //           ),
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.bookmark_outline),
      //           ),
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.settings),
      //           ),
      //
      //         ]),
      //
      //     tabBuilder: (context, index) {
      //
      //       return CupertinoTabView(
      //         routes: {
      //           '/': (context) => const HomeScreen(),
      //           '/library_screen': (context) => const LibraryScreen(),
      //           AppRoutes.details: (context) => const DetailsScreen(),
      //           AppRoutes.search: (context) => const SearchScreen(),
      //         },
      //         builder: (context) {
      //           return    navigationShell;
      //
      //         },
      //       );
      //     }
      //     ),
    );
  }
}
