import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';

import '../../../domain/bloc/movies_db/movies_db_bloc.dart';

class FavoriteCard extends StatelessWidget {
  final String name;
  final String date;
  final String image;
  final VoidCallback callback;
  final String type;
  final int id;

  const FavoriteCard({
    super.key,
    required this.name,
    required this.date,
    required this.image,
    required this.callback,
    required this.type,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prov = context.read<MoviesProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
          height: size.height * .15,
          decoration: BoxDecoration(
            color: AppColors.appDark,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                type != 'tv'
                    ? context.read<MoviesDbBloc>().add(MoviesDetailsEvent(
                          idMovie: id,
                        ))
                    : context.read<MoviesDbBloc>().add(TvSeriesDetailsEvent(
                          idMovie: id,
                        ));
                context.read<MoviesProvider>().firstDetailsId = id;
                type != 'tv' ? context.pushNamed('movlistDetails') : context.pushNamed('tvDetails');
              },
              child: Ink(
                child: Row(
                  children: [
                    Container(
                        width: size.width * .23,
                        height: size.height * .15,
                        decoration: BoxDecoration(
                            color: AppColors.appDark,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider("https://image.tmdb.org/t/p/w500$image"),
                              fit: BoxFit.cover,
                            ))),
                    SizedBox(width: size.width * .05),
                    SizedBox(
                      width: size.width * .45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(name,
                              maxLines: 3,
                              style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.clip)),
                          const Spacer(),
                          Text(date,
                              style: const TextStyle(
                                  color: AppColors.whiteColor, fontSize: 15, fontWeight: FontWeight.w400)),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          callback();
                        },
                        icon: const Icon(Icons.bookmark_sharp, size: 30, color: AppColors.whiteColor))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
