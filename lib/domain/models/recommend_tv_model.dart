import 'package:movie_db/domain/models/tv_series_model.dart';

class RecommendTv {
  int? page;
  List<TvSeriesResults>? results;
  int? totalPages;
  int? totalResults;

  RecommendTv({this.page, this.results, this.totalPages, this.totalResults});

  RecommendTv.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <TvSeriesResults>[];
      json['results'].forEach((v) {
        results!.add(TvSeriesResults.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

// class TvSeriesResults {
//   bool? adult;
//   String? backdropPath;
//   int? id;
//   String? name;
//   String? originalLanguage;
//   String? originalName;
//   String? overview;
//   String? posterPath;
//   String? mediaType;
//   List<int>? genreIds;
//   double? popularity;
//   String? firstAirDate;
//   double? voteAverage;
//   int? voteCount;
//   List<String>? originCountry;
//
//   TvSeriesResults(
//       {this.adult,
//         this.backdropPath,
//         this.id,
//         this.name,
//         this.originalLanguage,
//         this.originalName,
//         this.overview,
//         this.posterPath,
//         this.mediaType,
//         this.genreIds,
//         this.popularity,
//         this.firstAirDate,
//         this.voteAverage,
//         this.voteCount,
//         this.originCountry});
//
//   TvSeriesResults.fromJson(Map<String, dynamic> json) {
//     adult = json['adult'];
//     backdropPath = json['backdrop_path'];
//     id = json['id'];
//     name = json['name'];
//     originalLanguage = json['original_language'];
//     originalName = json['original_name'];
//     overview = json['overview'];
//     posterPath = json['poster_path'];
//     mediaType = json['media_type'];
//     genreIds = json['genre_ids'].cast<int>();
//     popularity = json['popularity'];
//     firstAirDate = json['first_air_date'];
//     voteAverage = json['vote_average'];
//     voteCount = json['vote_count'];
//     originCountry = json['origin_country'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['adult'] = adult;
//     data['backdrop_path'] = backdropPath;
//     data['id'] = id;
//     data['name'] = name;
//     data['original_language'] = originalLanguage;
//     data['original_name'] = originalName;
//     data['overview'] = overview;
//     data['poster_path'] = posterPath;
//     data['media_type'] = mediaType;
//     data['genre_ids'] = genreIds;
//     data['popularity'] = popularity;
//     data['first_air_date'] = firstAirDate;
//     data['vote_average'] = voteAverage;
//     data['vote_count'] = voteCount;
//     data['origin_country'] = originCountry;
//     return data;
//   }
// }
