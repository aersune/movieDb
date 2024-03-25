import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';

import '../../../domain/models/credits_model.dart';


class ActorsAvatars extends StatelessWidget {
  const ActorsAvatars({super.key, required this.cast});

  final List<Cast>? cast;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 165,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        shrinkWrap: true,
          itemCount: cast?.length ?? 0,
          itemBuilder: (context, i){

        if (cast?[i].profilePath?.isNotEmpty ?? false) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w500${cast?[i].profilePath}"),fit: BoxFit.cover)
                ),
              ),
              Text("${cast?[i].name}", style: AppStyle.normalStyle.copyWith(fontSize: 15),),
              Text(

                "${cast?[i].character?.replaceAll('/', "\n-")}",
                style: AppStyle.normalStyle.copyWith(fontSize: 15, color: AppColors.grayText, ),
              textAlign: TextAlign.center,
              ),
            ],
          );
        }
          const SizedBox();
      }),
    );
  }
}
