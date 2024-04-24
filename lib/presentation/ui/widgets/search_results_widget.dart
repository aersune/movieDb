import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/domain/bloc/movies_db/movies_db_bloc.dart';
import 'package:movie_db/domain/models/search_results_model.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/ui/widgets/not_found_widgte.dart';



class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({super.key, required this.searchResult});

  final SearchResultsModel searchResult;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prov = context.watch<MoviesProvider>();

    return SizedBox(
      height: size.height * .8,
      width: size.width,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: searchResult.results!.isEmpty ?
            NotFoundWidget(query: prov.searchController.text) :

        ListView.builder(
          padding: const EdgeInsets.only(bottom: 50, top: 20),
          shrinkWrap: true,
            itemCount: searchResult.results?.length ?? 0,
            itemBuilder: (context, index){
              var result = searchResult.results?[index];
              var genreName;
              var tvGenre;

              try{
                final movFilter = prov.movieGenres.genres?.where((el) => el.id == result!.genreIds?[0]);
                final tvFilter = prov.tvGenres.genres?.where((el) => el.id == result!.genreIds?[0]);


                if(movFilter != null && movFilter.isNotEmpty){
                  genreName = movFilter.first.name;
                }
                if(tvFilter != null && tvFilter.isNotEmpty){
                  tvGenre = tvFilter.first.name;
                }


              } catch(_){}
              return result?.posterPath == null ?
                  const SizedBox() :
                InkWell(
                  onTap: (){
                    result.mediaType == 'tv' ?
                    context.pushNamed('TvSearchDetails') :
                    context.pushNamed('movSearchDetails');
                    result.mediaType == 'tv' ?
                    context.read<MoviesDbBloc>().add(TvSeriesDetailsEvent(idMovie: result.id ?? 0)) :
                    context.read<MoviesDbBloc>().add(MoviesDetailsEvent(idMovie: result.id ?? 0));
                  },
                  child: Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 65,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w500${result?.posterPath}"),
                          fit: BoxFit.cover
                          )
                        ),
                      ),

                      const SizedBox(width: 20),
                      SizedBox(
                        width: size.width * .7,
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            result?.name != null ?
                            Text("${result?.name}", style: const TextStyle(fontSize: 20, color: AppColors.whiteColor,),maxLines: 3,)
                           : Text("${result?.title}", style: const TextStyle(fontSize: 20, color: AppColors.whiteColor,),maxLines: 3,),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              // physics: const NeverScrollableScrollPhysics(),
                              child: Row(
                                children: [

                                  result!.originCountry != null && result.originCountry!.isNotEmpty  ?
                                  Text("${prov.countries.where((el) => el.countryCode == result.originCountry?[0]).first.nativeName} · ", style: const TextStyle(color: AppColors.whiteColor),)
                                  : const SizedBox(),
                                  result.mediaType == 'tv' ?
                                  Text(" $tvGenre", style: const TextStyle(fontSize: 14, color: AppColors.whiteColor,), maxLines: 2,)
                                  : Text("$genreName", style: const TextStyle(fontSize: 14, color: AppColors.whiteColor,), maxLines: 2),

                                  result.firstAirDate != null && result.firstAirDate!.isNotEmpty?
                                  Text(" · ${result.firstAirDate?.substring(0,4)}", style: const TextStyle(color: AppColors.whiteColor),)
                                  : Text(" · ${result.releaseDate!.isNotEmpty ? result.releaseDate?.substring(0,4) : ''}", style: const TextStyle(color: AppColors.whiteColor),)
                                  ,
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                              ),
                );
        }),
      ),
    );
  }
}
