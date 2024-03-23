import 'package:flutter/material.dart';
import 'package:movie_db/presentation/components/app_colors.dart';


class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50), child: TextField(
      decoration: InputDecoration(
        fillColor: AppColors.appDark,
        filled: true,
        hintText: 'Фильм, сериал или аниме',
        hintStyle: const TextStyle(color: AppColors.grayText ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide.none),
        prefixIcon: const Icon(Icons.search, color: AppColors.whiteColor,)
      ),
    ),);
  }
}
