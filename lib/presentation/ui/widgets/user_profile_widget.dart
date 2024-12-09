import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final prov = context.watch<MoviesProvider>();
    var image = prov.userData.avatar?.tmdb?.avatarPath;
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.whiteColor),
              image: DecorationImage(
                  image: image != null
                      ? CachedNetworkImageProvider("https://image.tmdb.org/t/p/w500$image")
                      : const AssetImage("assets/profile.png") as ImageProvider,
                  fit: BoxFit.cover)),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              prov.userData.name ?? 'user',
              style: AppStyle.titleStyle.copyWith(fontWeight: FontWeight.w400),
            ),
            Text(
              prov.userData.username ?? 'username...',
              style: AppStyle.normalStyle.copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.grayText),
            ),
          ],
        )
      ],
    );
  }
}
