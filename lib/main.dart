import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_db/domain/api/api_repository.dart';
import 'package:movie_db/domain/bloc/movies_db/movies_db_bloc.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/my_app_model.dart';
import 'package:movie_db/presentation/router/app_navigation.dart';

import 'package:provider/provider.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.appDark,
      )
  );
  final model = MyAppModel();
  await model.checkAuth();

  runApp( MyApp(model: model,));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key, required this.model});

  final MyAppModel model;

  @override
  Widget build(BuildContext context) {


    final apiRepository = ApiRepository();

    // final prov = context.watch<MoviesProvider>();
// AppNavigation.initR
    AppNavigation.initR = model.isAuth ? '/home' : '/login';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          MoviesDbBloc(apiRepository)
            ..add(MoviesLoadEvent()),
        ),
        ChangeNotifierProvider(create: (context) => MoviesProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig:   AppNavigation.router ,

      ),
    );
  }
}

