import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/domain/bloc/movies_db/movies_db_bloc.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';


class SearchWidget extends StatelessWidget {
   const SearchWidget({super.key});



  @override
  Widget build(BuildContext context) {
    var searchController =  context.watch<MoviesProvider>().searchController;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50), child: TextField(
      controller: searchController,
      autofocus: false,
      onTap: (){
        context.read<MoviesDbBloc>().add(MoviesSearchEvent(query: searchController.text));
      },
      onChanged: (val){
        context.read<MoviesDbBloc>().add(MoviesSearchEvent(query: val));
      },
      style: const TextStyle(color: AppColors.whiteColor),
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
