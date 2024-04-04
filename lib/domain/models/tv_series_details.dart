class TvSeriesDetails {
  bool? adult;
  String? backdropPath;
  List<CreatedBy>? createdBy;
  String? firstAirDate;
  List<Genres>? genres;
  String? homepage;
  int? id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  LastEpisodeToAir? nextEpisodeToAir;
  List<Networks>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  List<Seasons>? seasons;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  TvSeriesDetails(
      {this.adult,
        this.backdropPath,
        this.createdBy,
        this.firstAirDate,
        this.genres,
        this.homepage,
        this.id,
        this.inProduction,
        this.languages,
        this.lastAirDate,
        this.lastEpisodeToAir,
        this.name,
        this.nextEpisodeToAir,
        this.networks,
        this.numberOfEpisodes,
        this.numberOfSeasons,
        this.originCountry,
        this.originalLanguage,
        this.originalName,
        this.overview,
        this.popularity,
        this.posterPath,
        this.productionCompanies,
        this.productionCountries,
        this.seasons,
        this.spokenLanguages,
        this.status,
        this.tagline,
        this.type,
        this.voteAverage,
        this.voteCount});

  TvSeriesDetails.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] ?? false;
    backdropPath = json['backdrop_path'] ?? '';
    if (json['created_by'] != null) {
      createdBy = <CreatedBy>[];
      json['created_by'].forEach((v) {
        createdBy!.add(CreatedBy.fromJson(v));
      });
    }

    firstAirDate = json['first_air_date'] ?? '';
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(Genres.fromJson(v));
      });
    }
    homepage = json['homepage'] ?? '';
    id = json['id'] ?? 0;
    inProduction = json['in_production'] ?? true;
    languages = json['languages'].cast<String>();
    lastAirDate = json['last_air_date'] ?? '';
    lastEpisodeToAir = json['last_episode_to_air'] != null
        ? LastEpisodeToAir.fromJson(json['last_episode_to_air'])
        : null;
    name = json['name'] ?? '';
    nextEpisodeToAir = json['next_episode_to_air'] != null
        ? LastEpisodeToAir.fromJson(json['next_episode_to_air'])
        : null;
    if (json['networks'] != null) {
      networks = <Networks>[];
      json['networks'].forEach((v) {
        networks!.add(Networks.fromJson(v));
      });
    }
    numberOfEpisodes = json['number_of_episodes'] ?? 1;
    numberOfSeasons = json['number_of_seasons'] ?? 1;
    originCountry = json['origin_country'].cast<String>();
    originalLanguage = json['original_language'] ?? '';
    originalName = json['original_name'] ?? '';
    overview = json['overview'] ?? '';
    popularity = json['popularity'] ?? 0;
    posterPath = json['poster_path'] ?? '';
    if (json['production_companies'] != null) {
      productionCompanies = <ProductionCompanies>[];
      json['production_companies'].forEach((v) {
        productionCompanies!.add(ProductionCompanies.fromJson(v));
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = <ProductionCountries>[];
      json['production_countries'].forEach((v) {
        productionCountries!.add(ProductionCountries.fromJson(v));
      });
    }
    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(Seasons.fromJson(v));
      });
    }
    if (json['spoken_languages'] != null) {
      spokenLanguages = <SpokenLanguages>[];
      json['spoken_languages'].forEach((v) {
        spokenLanguages!.add(SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'] ?? '';
    tagline = json['tagline'] ?? '';
    type = json['type'] ?? '';
    voteAverage = json['vote_average'] ?? 0.0;
    voteCount = json['vote_count'] ?? 0;
  }


}

class CreatedBy {
  int? id;
  String? creditId;
  String? name;
  int? gender;
  String? profilePath;

  CreatedBy({this.id, this.creditId, this.name, this.gender, this.profilePath});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0.0;
    creditId = json['credit_id'] ?? '';
    name = json['name'] ?? '';
    gender = json['gender'] ?? 0;
    profilePath = json['profile_path'] ?? '';
  }


}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
  }


}
class LastEpisodeToAir {
  int? id;
  String? name;
  String? overview;
  double? voteAverage;
  int? voteCount;
  String? airDate;
  int? episodeNumber;
  String? episodeType;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;

  LastEpisodeToAir(
      {this.id,
        this.name,
        this.overview,
        this.voteAverage,
        this.voteCount,
        this.airDate,
        this.episodeNumber,
        this.episodeType,
        this.productionCode,
        this.runtime,
        this.seasonNumber,
        this.showId,
        this.stillPath});

  LastEpisodeToAir.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    overview = json['overview'] ?? '';
    voteAverage = json['vote_average'] ?? 0.0;
    voteCount = json['vote_count'] ?? 0;
    airDate = json['air_date'] ?? '';
    episodeNumber = json['episode_number'] ?? 0;
    episodeType = json['episode_type'] ?? '';
    productionCode = json['production_code'] ?? '';
    runtime = json['runtime'] ?? 0;
    seasonNumber = json['season_number'] ?? 0;
    showId = json['show_id'] ?? 0;
    stillPath = json['still_path'] ?? '';
  }


}

class Networks {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  Networks({this.id, this.logoPath, this.name, this.originCountry});

  Networks.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    logoPath = json['logo_path'] ?? '';
    name = json['name'] ?? '';
    originCountry = json['origin_country'] ?? '';
  }

}

class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    logoPath = json['logo_path'] ?? '';
    name = json['name'] ?? '';
    originCountry = json['origin_country'] ?? '';
  }


}

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'] ?? '';
    name = json['name'] ?? '';
  }


}

class Seasons {
  String? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  Seasons(
      {this.airDate,
        this.episodeCount,
        this.id,
        this.name,
        this.overview,
        this.posterPath,
        this.seasonNumber,
        this.voteAverage});

  Seasons.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'] ?? '';
    episodeCount = json['episode_count'] ?? 0;
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    overview = json['overview'] ?? '';
    posterPath = json['poster_path'] ?? '';
    seasonNumber = json['season_number'] ?? 0;
    voteAverage = json['vote_average'] ?? 0.0;
  }


}

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'] ?? '';
    iso6391 = json['iso_639_1'] ?? '';
    name = json['name'] ?? '';
  }

}
