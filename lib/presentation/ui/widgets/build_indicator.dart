import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/domain/bloc/movies_db/movies_db_bloc.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BuildIndicator extends StatelessWidget {
  const BuildIndicator({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesDbBloc, MoviesDbState>(builder: (context, state){
      if(state is MoviesLoadedState){
        return AnimatedSmoothIndicator(
            effect: const ExpandingDotsEffect(
              dotWidth: 50,
              dotHeight: 5,
              activeDotColor: AppColors.whiteColor
            ),
            activeIndex: state.sliderIndex ?? 0, count: count,
        );
      }
      return const SizedBox();
    });
  }
}
