import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';
import 'package:movie_db/presentation/components/bottom_navbar_comp.dart';
import 'package:movie_db/presentation/ui/screens/library_screen.dart';
import 'package:movie_db/presentation/ui/screens/login_screen.dart';
import 'package:movie_db/presentation/ui/screens/search_screen.dart';
import 'package:movie_db/presentation/ui/screens/settings_screen.dart';
import 'package:provider/provider.dart';

import '../../../domain/api/data_providers/session_data_provider.dart';
import 'home_screen.dart';


class MainScreen extends StatelessWidget {
   const MainScreen({super.key, required this.navigationShell, required this.isLogged});
  final bool isLogged;

  final StatefulNavigationShell navigationShell;

  static List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const LibraryScreen(),
    const SettingsScreen(),
    const LoginScreen(),
  ];

  // void _goToBranch(int index){
  //   navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  // }


  @override
  Widget build(BuildContext context) {
    // final sessionId = SessionDataProvider().read();
    final provider = context.read<MoviesProvider>();


    return FutureBuilder(
      future: SessionDataProvider().read(),
      builder: (context,  AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {

            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            provider.getAllApi(snapshot.data);
            return MainBody(navigationShell : navigationShell);

            // return Text('Session ID: ${snapshot.data}');
          }

        }

        provider.getAllApi(null);
        return MainBody(navigationShell : navigationShell,);

      }
    ) ;
  }

}


class MainBody extends StatelessWidget {
  const MainBody({super.key, required this.navigationShell});


  final StatefulNavigationShell navigationShell;


  @override
  Widget build(BuildContext context) {
   
     
     
    return Scaffold(
        backgroundColor: AppColors.mainDark,
        body: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (context,AsyncSnapshot<List<ConnectivityResult>> snapshot) {
              // print(snapshot.toString());
              if(snapshot.hasData){
                List<ConnectivityResult>? result = snapshot.data;
                if(result!.contains(ConnectivityResult.mobile)){
                  return navigationShell;
                }else if(result.contains(ConnectivityResult.wifi)){
                  return navigationShell;
                }else{
                  return noInternet(context);
                }
              }else{
                return loading();
              }
              // return ;
            }
        ),

        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: AppColors.mainDark,
              primaryColor: Colors.blue,
            ),
            child: BottomNavbarComp(navigationShell: navigationShell,)
        )

    );
  }
  Widget loading(){
    return const Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green),),
    );
  }
  Widget noInternet(context){
    return  Container(
      color: AppColors.appDark,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/no_connection.png",height: 150,),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text("Нет подключение к интернету", style: AppStyle.titleStyle,),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child:  Text("Проверьте подключение к Интернету и обновите страницу.", style: AppStyle.normalStyle.copyWith(color: Colors.white70),),
          ),
        ],
      ),
    );
  }
}

