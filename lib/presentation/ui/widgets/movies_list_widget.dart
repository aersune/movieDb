import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/models/genres.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';
import '../../../domain/bloc/movies_db/movies_db_bloc.dart';
import '../../../domain/models/popular_movies.dart';

class MoviesListWidget extends StatelessWidget {
  const MoviesListWidget({
    super.key,
    required this.movies,
    required this.title,
    required this.genres,
  });

  final List<Results>? movies;
  final String title;
  final GenresList? genres;

  @override
  Widget build(BuildContext context) {
    return
      movies!.isEmpty ?
          const SizedBox() :

      Column(
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
              // if(state is MoviesLoadedState){
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: movies?.length ?? 0,
                  separatorBuilder: (context, i) => const SizedBox(
                        width: 15,
                      ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        context.read<MoviesDbBloc>().add(MoviesDetailsEvent(idMovie: movies?[index].id ?? 0, ));
                        context.pushNamed('movlistDetails');
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
                                    "https://image.tmdb.org/t/p/w500${movies?[index].posterPath}",
                                  ),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 150,
                            child: Text(
                              "${movies?[index].title}",
                              style: AppStyle.titleStyle.copyWith(
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                              "${genres?.genres?.where((g) => g.id == movies![0].genreIds?[0]).first.name} · ${movies?[index].releaseDate?.substring(0, 4)}",
                              style: AppStyle.normalStyle),
                        ],
                      ),
                    );
                  });
              // }
              // else{
              //   return const SizedBox();
              // }
            },
          ),
        )
      ],
    );
  }
}
