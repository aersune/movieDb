import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/models/tv_series_model.dart';
import 'package:movie_db/presentation/ui/screens/series_details_screen.dart';

import '../../../domain/bloc/movies_db/movies_db_bloc.dart';
import '../../../domain/models/genres.dart';
import '../../components/app_colors.dart';
import '../../components/app_style.dart';


class TvSeriesList extends StatelessWidget {
  const TvSeriesList({
    super.key,
    required this.series,
    required this.title,

  });

  final List<TvSeriesResults>? series;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppStyle.titleStyle,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.lightColor,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 300,
          child: BlocBuilder<MoviesDbBloc, MoviesDbState>(
            builder: (context, state) {
              if(state is MoviesLoadedState){
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: series?.length ?? 0,
                  separatorBuilder: (context, i) => const SizedBox(
                    width: 15,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        // print(state.tvSeries!.results?[index].id);
                        context.read<MoviesDbBloc>().add(TvSeriesDetailsEvent(idMovie: state.tvSeries!.results![index].id ?? 0));
                        context.pushNamed('tvDetails');
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 230,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w500${series?[index].posterPath}",
                                  ),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 150,
                            child: Text(

                              "${series?[index].name}",
                              style: AppStyle.titleStyle.copyWith(
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                              // "${genres?.genres?.where((g) => g.id == series![0].genreIds?[0]).toSet().first.id} ·"
                            // "${series?[0].genreIds?.join('')}"
                                  " ${series?[index].firstAirDate?.substring(0, 4)}"
                              ,
                              style: AppStyle.normalStyle),
                        ],
                      ),
                    );
                  });
              }
              else{
                return const SizedBox();
              }
            },
          ),
        )
      ],
    );
  }
}
