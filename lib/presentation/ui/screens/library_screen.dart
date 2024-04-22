import 'package:flutter/material.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.mainDark,

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Моя библиотека',
                  style: AppStyle.titleStyle.copyWith(color: AppColors.lightColor, fontSize: 30),
                ),
              ),
              const SizedBox(height: 25),
              // const MoviesListWidget(),
              // const MoviesListWidget(),
          
            ],
          ),
        ));
  }
}
