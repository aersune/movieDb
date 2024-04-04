import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/domain/models/credits_model.dart';
import 'package:movie_db/domain/models/tv_series_details.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';
import 'package:movie_db/presentation/ui/widgets/recommend_tv_widget.dart';

import '../../../domain/bloc/movies_db/movies_db_bloc.dart';
import '../widgets/actors_images_widget.dart';

class TvSeriesDetailsScreen extends StatelessWidget {
  const TvSeriesDetailsScreen({super.key, this.inSearch = false});

  final bool inSearch;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.mainDark,
      body: Container(
        color: AppColors.mainDark,
        child: BlocBuilder<MoviesDbBloc, MoviesDbState>(
          builder: (context, state) {
            if (state is TvSeriesDetailsLoadedState) {
              final TvSeriesDetails? details = state.seriesDetails;
              final Credits? credits = state.credits;

              print("${details?.id} id");
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: size.width,
                          height: 570,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage('https://image.tmdb.org/t/p/w500${details?.posterPath}'), fit: BoxFit.cover),
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
                                      "${details?.name}",
                                      style: AppStyle.titleStyle.copyWith(fontSize: 30),
                                    ),
                                    Text(
                                        "2024 · Season ${details?.lastEpisodeToAir?.seasonNumber} serie ${details?.lastEpisodeToAir?.episodeNumber}",
                                        style: AppStyle.normalStyle.copyWith(fontSize: 14)),
                                    details?.productionCountries != null && details!.productionCountries!.isNotEmpty ?
                                    Text("${details?.productionCountries?[0].name} · ${details?.genres?.map((e) => e.name).join(', ')}",
                                        style: AppStyle.normalStyle.copyWith(fontSize: 11, letterSpacing: 0.7)) : const SizedBox(),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {},
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
                        ratingWidget(details?.voteAverage ?? 0.0, details!.numberOfEpisodes ?? 0, details.numberOfSeasons ?? 0),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                "${details.overview}",
                                style: AppStyle.normalStyle,
                                maxLines: 8,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              creditsWidget(
                                  title: 'Directing ',
                                  body: credits!.crew!.where((el) => el.department == "Directing").map((e) => e.name).join(',  '), context: context),
                              creditsWidget(title: 'Cast ', body: credits.cast!.take(15).map((e) => e.name).join(',  '), context: context),
                              creditsWidget(
                                  title: 'Production ',
                                  body: credits.crew!.where((el) => el.department == "Production").take(15).map((e) => e.name).join(',  '), context: context),
                              creditsWidget(
                                  title: 'Writing ',
                                  body: credits.crew!.where((el) => el.department == "Writing").map((e) => e.name).join(',  '), context: context),
                              const SizedBox(height: 10),
                              const Text(
                                'Actors:',
                                style: AppStyle.titleStyle,
                              ),
                              const SizedBox(height: 10),
                              credits.cast!.isNotEmpty ?
                              ActorsAvatars(
                                cast: credits.cast,
                              ) : const SizedBox(),
                              const SizedBox(height: 50),
                              state.recommendSeries!.results!.isNotEmpty ?
                              RecommendTvSeries(
                                series: state.recommendSeries?.results,
                                title: 'Recommend Movies',
                              ) : const SizedBox(),
                            ],
                          ),
                        ),

                        // const MoviesListWidget()
                      ],
                    ),
                  ),
                  Positioned(
                      top: 30,
                      left: 20,
                      child: InkWell(
                        onTap: () {
                          !inSearch ? context.read<MoviesDbBloc>().add(MoviesLoadEvent()) :
                          context.read<MoviesDbBloc>().add(MoviesSearchEvent(query: context.read<MoviesProvider>().searchController.text));
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
                      )),
                ],
              );
            }
            if (state is MoviesErrorState) {
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
    );
  }

  Widget creditsWidget({ required BuildContext context ,required String title, required String body}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 8.0),
      child: RichText(
        textAlign: TextAlign.start,
          text: TextSpan(style: const TextStyle(height: 1.3), children: [
        TextSpan(

          text: "$title: ",
          style: AppStyle.normalStyle,
        ),
        TextSpan(
          text: body == '' ? 'no data found' : body,
          style: AppStyle.normalStyle.copyWith(color: AppColors.grayText),
        ),
      ])),
    );
  }

  Widget ratingWidget(double votes, int episodes, int seasons) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
            "Seasons $seasons",
            style: AppStyle.titleStyle.copyWith(fontSize: 15),
          ),
          Text(
            "Episodes $episodes",
            style: AppStyle.titleStyle.copyWith(fontSize: 15),
          ),
        ],
      ),
    ]);
  }
}
