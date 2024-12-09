import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/api/api_repository.dart';
import 'package:movie_db/domain/models/countries_model.dart';
import 'package:movie_db/domain/models/genres.dart';
import 'package:movie_db/domain/models/user_data_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider with ChangeNotifier {
  final bool isAuth;

  MoviesProvider({required this.isAuth});

  static final _apiKey = dotenv.get('API_KEY');
  int pageIndex = 0;

  var isLogged = false;

  logged() {
    if (kDebugMode) {
      print('logged');
    }
    isLogged = true;

    notifyListeners();
  }

  logOut() {
    if (kDebugMode) {
      print('logOut');
    }
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

  String sessionIdPr = '';

  getAllApi(sessionId) async {
    movieGenres = await ApiRepository().getAllGenres();
    tvGenres = await ApiRepository().getAllGenresTv();
    countries = await ApiRepository().getAllCountries();
    sessionId != null ? userData = await ApiRepository().getUserData(sessionId) : null;
    // logged();
    sessionId != null ? sessionIdPr = sessionId : null;

    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchFavoriteMoviesData(String sessionId) async {
    final String url =
        'https://api.themoviedb.org/3/account/${userData.id}/favorite/movies?session_id=$sessionId&api_key=$_apiKey';
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to load favorite movies data');
    }
  }

  Future<Map<String, dynamic>> fetchFavoriteTvShowsData(String sessionId) async {
    final String url =
        'https://api.themoviedb.org/3/account/${userData.id}/favorite/tv?session_id=$sessionId&api_key=$_apiKey';
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to load favorite TV shows data');
    }
  }

  Stream<Map<String, dynamic>> favoriteMediaDataStream(String sessionId) async* {
    while (true) {
      final moviesData = await fetchFavoriteMoviesData(sessionId);
      final tvShowsData = await fetchFavoriteTvShowsData(sessionId);

      yield {
        'movies': moviesData['results'],
        'tvShows': tvShowsData['results'],
        'page': moviesData['page'],
        'total_pages': moviesData['total_pages'],
        'total_results': moviesData['total_results'] + tvShowsData['total_results']
      };

      await Future.delayed(const Duration(seconds: 1)); // Refresh every 1 seconds
    }
  }

  Future<void> setFav({required int mediaId, required String mediaType, required bool isFav}) async {
    final String url =
        'https://api.themoviedb.org/3/account/${userData.id}/favorite?session_id=$sessionIdPr&api_key=$_apiKey';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"media_id": mediaId, "media_type": mediaType, "favorite": isFav}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to set favorite status ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(int mediaId, String mediaType, bool isFavorite) async {
    final String url =
        'https://api.themoviedb.org/3/account/21120152/favorite?session_id=$sessionIdPr&api_key=$_apiKey';

    // final Map<String, dynamic> data = {
    //   "media_id": mediaId,
    //   "media_type": mediaType,
    //   "favorite": !isFavorite
    // };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"media_id": mediaId, "media_type": mediaType, "favorite": !isFavorite}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle favorite status: ${response.reasonPhrase}');
    }
  }

  Future<bool> isFavorite({required int mediaId, required String mediaType}) async {
    final String url =
        'https://api.themoviedb.org/3/account/${userData.id}/favorite/$mediaType?session_id=$sessionIdPr&api_key=$_apiKey';
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> results = responseData['results'];

      for (var result in results) {
        if (result['id'] == mediaId) {
          return true;
        }
      }

      return false;
    } else {
      throw Exception('Failed to load favorite status');
    }
  }

  goFirstPage(
    BuildContext context,
  ) {
    switch (pageIndex) {
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

  goToPage(BuildContext context, page) {
    switch (page) {
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
