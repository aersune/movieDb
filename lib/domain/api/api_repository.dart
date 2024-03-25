
import 'package:movie_db/domain/api/api.dart';
import 'package:movie_db/domain/models/tv_series_details.dart';

import '../models/credits_model.dart';
import '../models/genres.dart';
import '../models/movie_details.dart';
import '../models/popular_movies.dart';
import '../models/tv_series_model.dart';

class ApiRepository {
  Future<MoviesModel> getAllPopularMovies() => Api.getPopularMovies();
  Future<TvSeries> getAllTvSeries() => Api.getTvSeries();
  Future<TvSeriesDetails> getAllTvSeriesDetails(int id) => Api.getSerialDetails(id);
  Future<MoviesModel> getAllRecommend(int id) => Api.getRecommend(id);
  Future<TvSeries> getAllRecommendSeries(int id) => Api.getRecommendSeries(id);
  Future<MoviesModel> getAllNowPlaying() => Api.getNowPlaying();
  Future<GenresList> getAllGenres() => Api.getGenres();
  Future<MovieDetails> getDetails(int id) => Api.getMovieDetails(id);
  Future<Credits> getAllCredits(int id) => Api.getCredits(id);
  Future<Credits> getAllSerialCredits(int id) => Api.getSerialCredits(id);
  Future<MoviesModel> getMovSearchResult(String query) => Api.getMovSearchResult(query);
  Future<TvSeries> getTvSearchResult(String query) => Api.getTvSearchResult(query);

}