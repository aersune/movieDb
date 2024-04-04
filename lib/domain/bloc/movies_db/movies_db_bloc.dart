import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_db/domain/models/search_results_model.dart';
import 'package:movie_db/domain/models/tv_series_details.dart';

import '../../api/api_repository.dart';
import '../../models/credits_model.dart';
import '../../models/details_model.dart';
import '../../models/genres.dart';
import '../../models/movie_details.dart';
import '../../models/popular_movies.dart';
import '../../models/tv_series_model.dart';

part 'movies_db_event.dart';

part 'movies_db_state.dart';

class MoviesDbBloc extends Bloc<MoviesDbEvent, MoviesDbState> {
  final ApiRepository apiRepository;

  MoviesDbBloc(this.apiRepository) : super(MoviesDbInitial()) {
    on<MoviesLoadEvent>((event, emit) async {

      try {
        final MoviesModel popularMovies = await apiRepository.getAllPopularMovies();
        final GenresList genresList = await apiRepository.getAllGenres();
        final MoviesModel nowPlaying = await apiRepository.getAllNowPlaying();
        final TvSeries series = await apiRepository.getAllTvSeries();

        if(state is MoviesLoadedState) {
          final currentState = state as MoviesLoadedState;
          emit(currentState.copyWith(popularMovies: popularMovies, sliderIndex: 0, genresList: genresList, nowPlaying: nowPlaying,
              tvSeries: series
          ));
        }
        else{
          emit(MoviesLoadedState(popularMovies: popularMovies, sliderIndex: 0, genresList: genresList, nowPlaying: nowPlaying,
              tvSeries: series
          ));
        }

      } catch (e) {
        emit(MoviesErrorState(error: e.toString()));
      }
    });
    on<SliderIndexChangedEvent>((event, emit) {
      if (state is MoviesLoadedState) {
        final currentState = state as MoviesLoadedState;
        emit(currentState.copyWith(sliderIndex: event.sliderIndex));
      } else {
        emit(MoviesLoadedState(sliderIndex: event.sliderIndex));
      }
    });
    on<TvSeriesDetailsEvent>((event, emit) async{
      try{
        final TvSeriesDetails tvSeriesDetails = await apiRepository.getAllTvSeriesDetails(event.idMovie);
        final Credits credits = await apiRepository.getAllSerialCredits(event.idMovie);
        final TvSeries recommend = await apiRepository.getAllRecommendSeries(event.idMovie);

        emit(TvSeriesDetailsLoadedState(seriesDetails: tvSeriesDetails, credits: credits, recommendSeries: recommend));

      } catch(_){

      }
    });



    on<MoviesDetailsEvent>((MoviesDetailsEvent event, emit) async {
      try {
        final MovieDetails movieDetails = await apiRepository.getDetails(event.idMovie);
        final Credits credits = await apiRepository.getAllCredits(event.idMovie);
        final MoviesModel recommend = await apiRepository.getAllRecommend(event.idMovie);
        final GenresList genresList = await apiRepository.getAllGenres();

        if(state is DetailsLoadedState){
          final currentState = state as DetailsLoadedState;
          emit(currentState.copyWith(movieDetails: movieDetails, credits: credits, recommendMovies: recommend, genresList: genresList,));
        }else{
          emit(DetailsLoadedState(movieDetails: movieDetails, credits: credits, recommendMovies: recommend, genresList: genresList, ));
        }

      } catch (e) {
        emit(MoviesErrorState(
          error: e.toString()
        ));
      }
    });

    on<MoviesSearchEvent>((event, emit)  async{

      final SearchResultsModel searchResult = await apiRepository.getAllSearchResult(event.query);
      if(event.query == '') {
        emit(SearchBarEmptyState());
      }else{
        emit(MoviesSearchState(searchResult: searchResult));
      }

    });
  }
}
