import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/models/popular_movies.dart';
import 'package:movie_db/presentation/router/app_routes.dart';

import '../../../domain/bloc/movies_db/movies_db_bloc.dart';
import '../../../domain/models/genres.dart';
import '../../../domain/provider.dart';
import '../../components/app_style.dart';

class MoviesGridWidget extends StatelessWidget {
  const MoviesGridWidget({super.key, required this.movies, this.genres});


  final List<Results>? movies;
  final GenresList? genres;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies?.length ,
      shrinkWrap: true,
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          mainAxisExtent: MediaQuery.of(context).size.height * .27,
        ),
        itemBuilder: (context, index){
        final mov = movies?[index];
          return InkWell(
            onTap: (){
              print(movies?[index].id);
              context.read<MoviesDbBloc>().add(MoviesDetailsEvent(idMovie: movies?[index].id ?? 0, ));
              context.read<MoviesProvider>().firstDetailsId = movies![0].id!;
              context.pushNamed('searchDetails');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image:  DecorationImage(
                        image: NetworkImage(
                          "https://image.tmdb.org/t/p/w500${movies?[index].posterPath}",
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(height: 10),
                Text(
                  "${movies?[index].title}",
                  maxLines: 1,
                  style: AppStyle.titleStyle.copyWith(fontSize: 13),
                ),
                Text(
                    "${genres?.genres?.where((g) => g.id == movies![0].genreIds?[0]).first.name} · ${movies?[index].releaseDate?.substring(0, 4)}",
                    style: AppStyle.normalStyle),
              ],
            ),
          );
        });
  }
}
