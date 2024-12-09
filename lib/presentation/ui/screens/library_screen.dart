import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/domain/api/data_providers/session_data_provider.dart';
import 'package:movie_db/domain/provider.dart';
import 'package:movie_db/presentation/components/app_colors.dart';
import 'package:movie_db/presentation/components/app_style.dart';
import 'package:movie_db/presentation/ui/widgets/favs_list_widget.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    final prov = context.read<MoviesProvider>();
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


              FutureBuilder(
                  future: SessionDataProvider().read(),
                  builder: (context, AsyncSnapshot<String?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return StreamBuilder<Map<String, dynamic>>(
                            stream: prov.favoriteMediaDataStream(snapshot.data.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (snapshot.hasData) {

                                final List<dynamic> movies = snapshot.data!['movies'];
                                final List<dynamic> tvShows = snapshot.data!['tvShows'];
                                final List<dynamic> media = movies + tvShows;


                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: media.length,
                                    itemBuilder: (context, index) {
                                      final item = media[index];
                                      return FavoriteCard(
                                        name: item['title'] ?? item['name'],
                                        image: item['backdrop_path'],
                                        date: item['release_date'] ?? item['first_air_date'],
                                        type: item['original_title'] != null ? 'movie' : 'tv',
                                        id: item['id'],
                                        callback: () {
                                          prov.setFav(mediaId:item['id'], mediaType: item['original_title'] != null ? 'movie' : 'tv',
                                          isFav: false
                                          );
                                        },
                                      );
                                    });
                              }
                              return const SizedBox();
                            });

                        // return Text('Session ID: ${snapshot.data}');
                      }
                    }

                    return const SizedBox();
                  }),

              // const MoviesListWidget(),
            ],
          ),
        ));
  }
}
