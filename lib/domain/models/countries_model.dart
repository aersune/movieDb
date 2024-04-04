class Countries {
  String? countryCode;
  String? englishName;
  String? nativeName;

  Countries({this.countryCode, this.englishName, this.nativeName});

  Countries.fromJson(Map<String, dynamic> json) {
    countryCode = json['iso_3166_1'];
    englishName = json['english_name'];
    nativeName = json['native_name'];
  }


}
