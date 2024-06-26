part of 'movies_db_bloc.dart';

@immutable
sealed class MoviesDbState {}

final class MoviesDbInitial extends MoviesDbState {}

final class MoviesLoadedState extends MoviesDbState {
  late int? sliderIndex;
  late MoviesModel? popularMovies;
  late TvSeries? tvSeries;
  late MoviesModel? nowPlaying;
  late GenresList? genresList;


  MoviesLoadedState({
    this.popularMovies,
    this.sliderIndex,
    this.genresList,
    this.nowPlaying,
    this.tvSeries,
  });

  MoviesLoadedState copyWith({
    int? sliderIndex,
    MoviesModel? popularMovies,
    GenresList? genresList,
    MoviesModel? nowPlaying,
    TvSeries? tvSeries,
    int? navBarIndex
  }) {
    return MoviesLoadedState(
      sliderIndex: sliderIndex ?? this.sliderIndex,
      popularMovies: popularMovies ?? this.popularMovies,
      genresList: genresList ?? this.genresList,
      nowPlaying: nowPlaying ?? this.nowPlaying,
        tvSeries: tvSeries ?? this.tvSeries,
    );
  }
}

final class DetailsLoadedState extends MoviesDbState {
  final MovieDetails? movieDetails;
  final Credits? credits;
  final MoviesModel? recommendMovies;
  late GenresList? genresList;
  final YoutubeInfo? ytInfo;
  final int? navBarIndex;

  DetailsLoadedState({ this.movieDetails,  this.credits,  this.recommendMovies, this.genresList,  this.navBarIndex, this.ytInfo});

  DetailsLoadedState copyWith({
    MovieDetails? movieDetails,
    Credits? credits,
    MoviesModel? recommendMovies,
    GenresList? genresList,
    int? navBarIndex,
    YoutubeInfo? ytInfo,
  }) {
    return DetailsLoadedState(
      movieDetails: movieDetails ?? this.movieDetails,
      credits: credits ?? this.credits,
      recommendMovies: recommendMovies ?? this.recommendMovies,
      genresList: genresList ?? this.genresList,
      navBarIndex: navBarIndex ?? this.navBarIndex,
      ytInfo: ytInfo ?? this.ytInfo,
    );
  }
}
final class TvSeriesDetailsLoadedState extends MoviesDbState {
  final TvSeriesDetails? seriesDetails;
  final Credits? credits;
  final TvSeries? recommendSeries;


  TvSeriesDetailsLoadedState({ this.seriesDetails,  this.credits,  this.recommendSeries,});

  TvSeriesDetailsLoadedState copyWith({
    TvSeriesDetails? seriesDetails,
    Credits? credits,
    TvSeries? recommendSeries,

  }) {
    return TvSeriesDetailsLoadedState(
        seriesDetails: seriesDetails ?? this.seriesDetails,
        credits: credits ?? this.credits,
      recommendSeries: recommendSeries ?? this.recommendSeries,
    );
  }
}
final class SearchBarEmptyState extends MoviesDbState {}

final class MoviesSearchState extends MoviesDbState {
  final SearchResultsModel searchResult;
  MoviesSearchState({required this.searchResult});
}

final class MoviesErrorState extends MoviesDbState {
  final String error;
  MoviesErrorState({required this.error});
}
