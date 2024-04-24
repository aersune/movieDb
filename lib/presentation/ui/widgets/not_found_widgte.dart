import 'package:flutter/material.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
         SizedBox(height: MediaQuery.of(context).size.height * .2),
        const Icon(Icons.image_search_outlined, size: 100, color: AppColors.whiteColor,),
        const SizedBox(height: 20),
        Text('По запросу <<$query>> ничего нет', style: AppStyle.titleStyle,),
        const SizedBox(height: 10),
        Text('Проверь, нет ли опечаток, или попробуй ввести другой запрос', style: AppStyle.normalStyle.copyWith(color: AppColors.grayText, fontSize: 15),
        textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
