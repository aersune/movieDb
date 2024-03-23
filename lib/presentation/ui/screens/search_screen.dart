import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/presentation/components/app_colors.dart';

import '../../../domain/bloc/movies_db/movies_db_bloc.dart';
import '../widgets/movies_grid_widget.dart';
import '../widgets/search_widget.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColors.mainDark,
      child:  Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 130),
                BlocBuilder<MoviesDbBloc, MoviesDbState>(
                  builder: (context, state) {
                    if(state is MoviesLoadedState){
                      return MoviesGridWidget(movies: state.popularMovies!.results, genres: state.genresList,);
                    }
                    else{
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
          const Positioned(
              top: 20,
              child: SearchWidget())
        ],
      ),
    );
  }
}
