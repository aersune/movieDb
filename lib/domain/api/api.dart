

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_db/domain/models/countries_model.dart';
import 'package:movie_db/domain/models/search_results_model.dart';
import 'package:movie_db/domain/models/tv_series_details.dart';
import 'package:movie_db/domain/models/user_data_model.dart';

import '../models/credits_model.dart';
import '../models/genres.dart';
import '../models/movie_details.dart';
import '../models/popular_movies.dart';
import '../models/tv_series_model.dart';

class Api {
  // &page=2
  // ?language=ru-RU
  static final apiKey = dotenv.get('API_KEY');
  static final dio = Dio();
  // https://api.themoviedb.org/3/account?api_key=blahblahblah&session_id=xxxxxxxxxxx

  static Future<UserData> getProfileInfo(String sessionId) async{
    final response = await dio.get('https://api.themoviedb.org/3/account?api_key=${Api.apiKey}&session_id=$sessionId');
    if(response.statusCode == 200){
      return UserData.fromJson(response.data);
    }else{
      throw Exception('Error ${response.statusCode}');
    }
  }

  static Future<MoviesModel> getPopularMovies() async{
    final response = await dio.get('https://api.themoviedb.org/3/movie/popular?api_key=${Api.apiKey}');
    if(response.statusCode == 200){
      return MoviesModel.fromJson(response.data);
    }else{
      throw Exception('Error ${response.statusCode}');
    }
  }
  static Future<TvSeries> getTvSeries() async{
    final response = await dio.get('https://api.themoviedb.org/3/tv/popular?api_key=${Api.apiKey}');
    if(response.statusCode == 200){
      return TvSeries.fromJson(response.data);
    }else{
      throw Exception('Error ${response.statusCode}');
    }
  }
   static Future<GenresList> getGenres()  async{
      final response = await dio.get('https://api.themoviedb.org/3/genre/movie/list?api_key=${Api.apiKey}');
      if(response.statusCode == 200){
        return GenresList.fromJson(response.data);
      }else{
        throw Exception('Error ${response.statusCode}');
      }
   }
  static Future<GenresList> getGenresTv()  async{
    final response = await dio.get('https://api.themoviedb.org/3/genre/tv/list?api_key=${Api.apiKey}');
    if(response.statusCode == 200){
      return GenresList.fromJson(response.data);
    }else{
      throw Exception('Error ${response.statusCode}');
    }
  }
   
   static Future<MovieDetails> getMovieDetails(int id)  async{
      final response = await dio.get('https://api.themoviedb.org/3/movie/$id?api_key=${Api.apiKey}');
      if(response.statusCode == 200) {
        return MovieDetails.fromJson(response.data);
      }else{
        throw Exception('Error ${response.statusCode}');
      }
   }
  static Future<TvSeriesDetails> getSerialDetails(int id)  async{
    final response = await dio.get('https://api.themoviedb.org/3/tv/$id?api_key=${Api.apiKey}');
    if(response.statusCode == 200) {
      return TvSeriesDetails.fromJson(response.data);
    }else{
      throw Exception('Error ${response.statusCode}');
    }
  }

   static Future<Credits> getCredits(int id) async{
      final response = await dio.get('https://api.themoviedb.org/3/movie/$id/credits?api_key=${Api.apiKey}');
      if(response.statusCode == 200) {
        return Credits.fromJson(response.data);
      }else{
        throw Exception('Error ${response.statusCode}');
      }
   }
  static Future<Credits> getSerialCredits(int id) async{
    final response = await dio.get('https://api.themoviedb.org/3/tv/$id/credits?api_key=${Api.apiKey}');
    if(response.statusCode == 200) {
      return Credits.fromJson(response.data);
    }else{
      throw Exception('Error ${response.statusCode}');
    }
  }
  static Future<MoviesModel> getRecommend(int id) async{
    final response = await dio.get('https://api.themoviedb.org/3/movie/$id/recommendations?api_key=${Api.apiKey}');
    if(response.statusCode == 200) {
      return MoviesModel.fromJson(response.data);
    }else{
      throw Exception('Error ${response.statusCode}');
    }
  }
  static Future<TvSeries> getRecommendSeries(int id) async{
    final response = await dio.get('https://api.themoviedb.org/3/tv/$id/recommendations?api_key=${Api.apiKey}');
    if(response.statusCode == 200) {
      return TvSeries.fromJson(response.data);
    }else{
      throw Exception('Error ${response.statusCode}');
    }
  }

  static Future<MoviesModel> getNowPlaying() async{
    final response = await dio.get('https://api.themoviedb.org/3/movie/now_playing?api_key=${Api.apiKey}');
    if(response.statusCode == 200) {
      return MoviesModel.fromJson(response.data);
    }else{
      throw Exception('Error ${response.statusCode}');
    }
  }

  static Future<SearchResultsModel> getSearchResult(String query) async{
    final response = await dio.get('https://api.themoviedb.org/3/search/multi?api_key=${Api.apiKey}&query=$query');
    if(response.statusCode == 200) {
      return SearchResultsModel.fromJson(response.data);
    }else{
      throw Exception('Error ${response.statusCode}');
    }
  }
  static Future<List<Countries>> getCountries() async{
    final response = await dio.get('https://api.themoviedb.org/3/configuration/countries?api_key=${Api.apiKey}');
    if(response.statusCode == 200) {
      Iterable list = response.data;
      return list.map((e) => Countries.fromJson(e)).toList();
    }else{
      throw Exception('Error ${response.statusCode}');
    }
  }







}