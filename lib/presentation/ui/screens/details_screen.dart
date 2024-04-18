import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/models/credits_model.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';
import 'package:movie_db/presentation/ui/widgets/movies_list_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/bloc/movies_db/movies_db_bloc.dart';
import '../../../domain/models/movie_details.dart';

import '../widgets/actors_images_widget.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, this.inSearch = false});

  final bool inSearch;

  String convertMinute(minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return '$hours ч $remainingMinutes мин';
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        context.read<MoviesDbBloc>().add(MoviesLoadEvent());
        context.go('/home');
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.mainDark,
        body: Container(
          color: AppColors.mainDark,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: BlocBuilder<MoviesDbBloc, MoviesDbState>(
                  builder: (context, state) {
                    if (state is DetailsLoadedState) {
                      final MovieDetails? details = state.movieDetails;
                      final Credits? credits = state.credits;

                      print("${details?.id} id");
                      return Column(
                        children: [
                          Container(
                            width: size.width,
                            height: 570,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage('https://image.tmdb.org/t/p/w500${details?.posterPath}'),
                                  fit: BoxFit.cover),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: size.width,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [AppColors.mainDark.withOpacity(0.0), AppColors.mainDark])),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${details?.title}",
                                        style: AppStyle.titleStyle.copyWith(fontSize: 30),
                                      ),
                                      Text(
                                          "${details?.releaseDate?.substring(0, 4)} · ${convertMinute(details?.runtime)}",
                                          style: AppStyle.normalStyle.copyWith(fontSize: 12)),
                                      details!.productionCountries!.isNotEmpty
                                          ? Text(
                                              "${details.productionCountries?[0].name} · ${details?.genres?.map((e) => e.name).join(', ')}",
                                              style: AppStyle.normalStyle.copyWith(fontSize: 11, letterSpacing: 0.7))
                                          : const SizedBox(),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              _launchUrl(Uri.parse('https://www.youtube.com/watch?v=${state.ytInfo!.results?[0].keyYt}'));
                                              // await launchUrl();
                                            } ,
                                            child: Container(
                                              width: size.width * .65,
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
                                          ),
                                          const Icon(
                                            Icons.favorite_border,
                                            size: 30,
                                            color: AppColors.whiteColor,
                                          ),
                                          const Icon(
                                            Icons.more_vert,
                                            size: 30,
                                            color: AppColors.whiteColor,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          ratingWidget(details?.voteAverage ?? 0.0),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${details?.overview}",
                                  style: AppStyle.normalStyle,
                                  maxLines: 8,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                credits!.crew!.isEmpty
                                    ? const SizedBox()
                                    : Column(
                                        children: [
                                          creditsWidget(
                                              title: 'Directing ',
                                              body: credits!.crew!
                                                  .where((el) => el.department == "Directing")
                                                  .map((e) => e.name)
                                                  .join(',  ')),
                                          creditsWidget(
                                              title: 'Cast ',
                                              body: credits.cast!.take(15).map((e) => e.name).join(',  ')),
                                          creditsWidget(
                                              title: 'Production ',
                                              body: credits.crew!
                                                  .where((el) => el.department == "Production")
                                                  .take(15)
                                                  .map((e) => e.name)
                                                  .join(',  ')),
                                          creditsWidget(
                                              title: 'Writing ',
                                              body: credits.crew!
                                                  .where((el) => el.department == "Writing")
                                                  .map((e) => e.name)
                                                  .join(',  ')),
                                        ],
                                      ),
                                const SizedBox(height: 10),
                                const SizedBox(height: 10),
                                credits.cast!.isEmpty
                                    ? const SizedBox()
                                    : Column(
                                        children: [
                                          const Text(
                                            'Actors:',
                                            style: AppStyle.titleStyle,
                                          ),
                                          ActorsAvatars(
                                            cast: credits.cast,
                                          ),
                                        ],
                                      ),
                                const SizedBox(height: 50),
                                MoviesListWidget(
                                  movies: state.recommendMovies?.results,
                                  genres: state.genresList,
                                  title: 'Recommend Movies',
                                ),
                              ],
                            ),
                          ),

                          // const MoviesListWidget()
                        ],
                      );
                    }
                    if (state is MoviesErrorState) {
                      print(state.error);
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Error ${state.error}',
                              style: AppStyle.titleStyle,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox(
                        child: Text('data'),
                      );
                    }
                  },
                ),
              ),
              Positioned(
                  top: 30,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      // Navigator.pop(context);

                      // context.go('/home');
                      !inSearch
                          ? context.read<MoviesDbBloc>().add(MoviesLoadEvent())
                          : context
                              .read<MoviesDbBloc>()
                              .add(MoviesSearchEvent(query: context.read<MoviesProvider>().searchController.text));

                      context.read<MoviesProvider>().goFirstPage(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.appDark),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget creditsWidget({required String title, required String body}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: RichText(
          text: TextSpan(style: const TextStyle(height: 1.3), children: [
        TextSpan(
          text: "$title: ",
          style: AppStyle.normalStyle,
        ),
        TextSpan(
          text: body,
          style: AppStyle.normalStyle.copyWith(color: AppColors.grayText),
        ),
      ])),
    );
  }

  Widget ratingWidget(double votes) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                votes.toStringAsFixed(1),
                style: AppStyle.titleStyle.copyWith(fontSize: 18),
              ),
              Text(
                'IMDB',
                style: AppStyle.titleStyle.copyWith(fontSize: 13),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 20,
            color: AppColors.grayText,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'No data',
                style: AppStyle.titleStyle.copyWith(fontSize: 12),
              ),
              Text(
                'Кинопоиск',
                style: AppStyle.titleStyle.copyWith(fontSize: 13),
              ),
            ],
          ),
        ]);
  }
}
