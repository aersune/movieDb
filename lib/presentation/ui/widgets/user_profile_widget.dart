import 'package:flutter/material.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration:  BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.whiteColor),
              image: const DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/1435612/pexels-photo-1435612.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
              fit: BoxFit.cover
              )),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Anna Belkova', style: AppStyle.titleStyle.copyWith(fontWeight: FontWeight.w400),),
            Text('belkovaa@gmail.com', style: AppStyle.normalStyle.copyWith(fontWeight: FontWeight.w400, color: AppColors.grayText),),
          ],
        )
      ],
    );
  }
}
