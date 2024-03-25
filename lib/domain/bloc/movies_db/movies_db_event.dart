part of 'movies_db_bloc.dart';

@immutable
sealed class MoviesDbEvent {}

final class MoviesLoadEvent extends MoviesDbEvent {}

final class SliderIndexChangedEvent extends MoviesDbEvent {
  final int sliderIndex;
  SliderIndexChangedEvent({required this.sliderIndex});
}




final class MoviesDetailsEvent extends MoviesDbEvent {
  final int idMovie;

  MoviesDetailsEvent({required this.idMovie,});
}


final class TvSeriesDetailsEvent extends MoviesDbEvent {
  final int idMovie;

  TvSeriesDetailsEvent({required this.idMovie,});
}




