import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';
import 'package:movie_db/presentation/ui/widgets/search_results_widget.dart';

import '../../../domain/bloc/movies_db/movies_db_bloc.dart';
import '../widgets/movies_grid_widget.dart';
import '../widgets/search_widget.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    if(state is SearchBarEmptyState){
                      return SizedBox(
                        width: size.width,
                        height: size.height * .7,
                        child:  const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              Text('Смотри то, что нравится', style: AppStyle.titleStyle,),
                              Text('Ищи фильмы, сериалы, мультфильмы и многое другое ', style: AppStyle.normalStyle,),
                          ],
                        ),
                      );
                    }
                    if(state is MoviesSearchState){
                      return SearchResultsWidget(searchResult: state.searchResult);
                    }

                    if(state is MoviesLoadedState){
                      context.read<MoviesProvider>().searchController.clear();
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
              child: SearchWidget(),
           )
        ],
      ),
    );
  }
}
