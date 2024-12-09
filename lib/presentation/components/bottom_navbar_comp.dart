
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/bloc/movies_db/movies_db_bloc.dart';
import 'package:movie_db/domain/provider.dart';
import 'app_colors.dart';


class BottomNavbarComp extends StatelessWidget {

  const BottomNavbarComp({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;



  @override
  Widget build(BuildContext context) {
    final model = context.watch<MoviesProvider>();
    return  model.isAuth ?  BottomAppBar(
      height: 55,
      color: AppColors.mainDark,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavbarButton(index: 0,icon: Icons.home_filled, navigationShell: navigationShell,),
          NavbarButton(index: 1,icon: Icons.dashboard_rounded, navigationShell: navigationShell),
          NavbarButton( index: 2,icon: Icons.bookmark_outline, navigationShell: navigationShell),
          NavbarButton( index: 3,icon: Icons.settings, navigationShell: navigationShell),
        ],
      ),
    ) : const SizedBox.shrink();
  }

}

class NavbarButton extends StatelessWidget {
  const NavbarButton({super.key, required this.index, required this.icon, required this.navigationShell, });

  final int index;
  final  IconData icon;

  final StatefulNavigationShell navigationShell;
  void _goToBranch(int index){
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);

  }

  @override
  Widget build(BuildContext context,) {

    var isActive = index == context.watch<MoviesProvider>().pageIndex;

    return Material(
      color: Colors.transparent,
      child: InkWell(

        borderRadius: BorderRadius.circular(25),
        onTap: () {

          context.read<MoviesDbBloc>().add(MoviesLoadEvent());

          context.read<MoviesProvider>().changePage(page: index);

          _goToBranch(index);

        },
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? AppColors.whiteColor : Colors.transparent,
            borderRadius: BorderRadius.circular(25)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 4),

          child:  Icon(icon, color: isActive ?  AppColors.mainDark : AppColors.whiteColor, opticalSize: 2,),
        ),
      ),
    );
  }
}