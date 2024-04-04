

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/api/api_repository.dart';
import 'package:movie_db/domain/models/countries_model.dart';
import 'package:movie_db/domain/models/genres.dart';
import 'package:movie_db/domain/models/user_data_model.dart';


class MoviesProvider extends ChangeNotifier {
    int pageIndex = 0;

    bool isLogged = false;

    logged(){
      isLogged = true;
      notifyListeners();
    }
    logOut(){
      isLogged = false;
      notifyListeners();
    }

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    changePage({required int page}) {
      pageIndex = page;

      notifyListeners();
    }
    var firstDetailsId = 0;

    late GenresList movieGenres;
    late GenresList tvGenres;
    late UserData userData;
    late List<Countries> countries;
    TextEditingController searchController = TextEditingController();

  getAllApi(sessionId) async{
    movieGenres = await ApiRepository().getAllGenres();
    tvGenres = await ApiRepository().getAllGenresTv();
    countries = await ApiRepository().getAllCountries();
    userData = await ApiRepository().getUserData(sessionId);
    notifyListeners();
  }




  goFirstPage(BuildContext context,) {
    switch(pageIndex){
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/search');
      case 2:
        context.go('/library');
      case 3:
        context.go('/settings');
    }
  }

    goToPage(BuildContext context,page) {
      switch(page){
        case 0:
          context.go('/home');
          break;
        case 1:
          context.go('/search');
        case 2:
          context.go('/library');
        case 3:
          context.go('/settings');
      }
    }
}