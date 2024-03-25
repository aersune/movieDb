import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/domain/api/api_repository.dart';

import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';
import 'package:movie_db/presentation/ui/widgets/tv_series_list.dart';

import '../../../domain/bloc/movies_db/movies_db_bloc.dart';
import '../widgets/movies_list_widget.dart';
import '../widgets/slider_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.mainDark,
      child: SingleChildScrollView(
        child: BlocBuilder<MoviesDbBloc, MoviesDbState>(
          builder: (context, state) {
            if (state is MoviesErrorState) {
              return const Center(
                child: Text(
                  'Error fetching data',
                  style: AppStyle.normalStyle,
                ),
              );
            }
            if (state is MoviesLoadedState) {
              final movies = state.popularMovies!.results;
              return Column(
                children: [
                  SliderWidget(result: state.popularMovies!.results!.sublist(0, 8)),
                  const SizedBox(height: 20),
                  MoviesListWidget(
                    movies: state.popularMovies!.results,
                    genres: state.genresList,
                    title: 'Популярное',
                  ),
                  MoviesListWidget(
                    movies: state.nowPlaying!.results,
                    genres: state.genresList,
                    title: 'Сейчас смотрят',
                  ),
                  TvSeriesList(series: state.tvSeries?.results, title: 'Serials',)
                  // MoviesListWidget(),
                  // MoviesListWidget(),
                ],
              );
            }
            return const SizedBox(
              child: Center(
                  child: CupertinoActivityIndicator()),
            );
          },
        ),
      ),
    );
  }
}
