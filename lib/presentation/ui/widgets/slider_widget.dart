import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/bloc/movies_db/movies_db_bloc.dart';
import 'package:movie_db/domain/models/popular_movies.dart';
import '../../components/app_colors.dart';
import '../../components/app_style.dart';
import 'build_indicator.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key, required this.result});

  final List<Results> result;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (context, index, realIndx) {
                return Center(
                    child: Image.network("https://image.tmdb.org/t/p/w500${result[index].posterPath}",
                        fit: BoxFit.cover, width: 1000));
              },
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  context.read<MoviesDbBloc>().add(SliderIndexChangedEvent(sliderIndex: index));
                },
                height: size.height * .6,
                autoPlay: true,
                viewportFraction: 1,
                enlargeFactor: .2,
                aspectRatio: 5,
                enlargeCenterPage: true,
              ),
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: const Text(
                    'MovieDB',
                    style: AppStyle.titleStyle,
                  ),
                )),
            Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  height: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.mainDark.withOpacity(0.0), AppColors.mainDark])),
                )),
            Positioned(bottom: 15, child: centerWidget(widget: SizedBox(
                width: size.width,
                child: sliderTitle(context, movie: result)), size: size)),
          ],
        ),
        const SizedBox(height: 5),
        centerWidget(widget: const BuildIndicator(count: 5), size: size),
      ],
    );
  }

  Widget sliderTitle(context, {required List<Results> movie}) {
    return BlocBuilder<MoviesDbBloc, MoviesDbState>(
      builder: (context, state) {

        if (state is MoviesLoadedState) {
          final Results? movie = state.popularMovies!.results?[state.sliderIndex ?? 0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(

                "${state.popularMovies!.results?[state.sliderIndex ?? 0].title}",
                style: AppStyle.titleStyle,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              Text(
                "${state.genresList?.genres?.where((element) => element.id == movie?.genreIds?[0]).first.name} · ${movie?.releaseDate?.substring(0, 4)}",
                style: AppStyle.normalStyle,
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  context.read<MoviesDbBloc>().add(MoviesDetailsEvent(idMovie: movie?.id ?? 0));
                  context.pushNamed('details2');

                },
                child: Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.lightColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.play_arrow,
                        color: AppColors.whiteColor,
                        size: 18,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'Смотреть',
                        style: AppStyle.titleStyle.copyWith(fontSize: 13),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget centerWidget({required Widget widget, required size}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: size.width,
      child: Row(
        children: [
          const Spacer(),
          widget,
          const Spacer(),
        ],
      ),
    );
  }
}
