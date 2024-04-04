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
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration:  BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.whiteColor),
              image: const DecorationImage(
                  image: AssetImage(
                      "assets/profile.png"),
              fit: BoxFit.cover
              )),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${prov.userData.username}", style: AppStyle.titleStyle.copyWith(fontWeight: FontWeight.w400),),
            Text('useremail@gmail.com', style: AppStyle.normalStyle.copyWith(fontWeight: FontWeight.w400, color: AppColors.grayText),),
          ],
        )
      ],
    );
  }
}
