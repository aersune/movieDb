

class UserData {
  Avatar? avatar;
  int? id;
  String? iso6391;
  String? iso31661;
  String? name;
  bool? includeAdult;
  String? username;

  UserData(
      {this.avatar,
        this.id,
        this.iso6391,
        this.iso31661,
        this.name,
        this.includeAdult,
        this.username});


  UserData.fromJson(Map<String, dynamic> json) {
    avatar =
    json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null;
    id = json['id'];
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    name = json['name'];
    includeAdult = json['include_adult'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    data['id'] = id;
    data['iso_639_1'] = iso6391;
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    data['include_adult'] = includeAdult;
    data['username'] = username;
    return data;
  }
}

class Avatar {
  Gravatar? gravatar;
  Tmdb? tmdb;

  Avatar({this.gravatar, this.tmdb});

  Avatar.fromJson(Map<String, dynamic> json) {
    gravatar = json['gravatar'] != null
        ? Gravatar.fromJson(json['gravatar'])
        : null;
    tmdb = json['tmdb'] != null ? Tmdb.fromJson(json['tmdb']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gravatar != null) {
      data['gravatar'] = gravatar!.toJson();
    }
    if (tmdb != null) {
      data['tmdb'] = tmdb!.toJson();
    }
    return data;
  }
}

class Gravatar {
  String? hash;

  Gravatar({this.hash});

  Gravatar.fromJson(Map<String, dynamic> json) {
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hash'] = hash;
    return data;
  }
}

class Tmdb {
  dynamic avatarPath;

  Tmdb({this.avatarPath});

  Tmdb.fromJson(Map<String, dynamic> json) {
    avatarPath = json['avatar_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar_path'] = avatarPath;
    return data;
  }
}
