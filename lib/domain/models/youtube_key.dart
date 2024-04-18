class YoutubeInfo {
  int? id;
  List<Results>? results;

  YoutubeInfo({this.id, this.results});

  YoutubeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  dynamic keyYt;
  int? size;
  Results({this.keyYt, this.size});

  Results.fromJson(Map<String, dynamic> json) {
    keyYt = json['key'];
    size = json['size'];
  }
}
