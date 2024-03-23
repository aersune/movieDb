import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_db/domain/api/api_repository.dart';
import 'package:movie_db/domain/bloc/movies_db/movies_db_bloc.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/router/app_navigation.dart';
import 'package:movie_db/presentation/router/app_router.dart';
import 'package:movie_db/presentation/ui/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.appDark,
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiRepository = ApiRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          MoviesDbBloc(apiRepository)
            ..add(MoviesLoadEvent()),
        ),
        ChangeNotifierProvider(create: (context) => NavigateProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: AppNavigation.router,
      ),
    );
  }
}

