import 'DetailsDataModel.dart';

class DetailsResult {
  int id;
  String firstName;
  String middleName;
  String lastName;
  String suffix;
  String fullName;
  String modified;
  Thumbnail thumbnail;
  String resourceURI;

  List<Urls> urls;

  DetailsResult(
      {this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.suffix,
        this.fullName,
        this.modified,
        this.thumbnail,
        this.resourceURI,
        this.urls});

  DetailsResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    suffix = json['suffix'];
    fullName = json['fullName'];
    modified = json['modified'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    resourceURI = json['resourceURI'];
    if (json['urls'] != null) {
      urls = new List<Urls>();
      json['urls'].forEach((v) {
        urls.add(new Urls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['suffix'] = this.suffix;
    data['fullName'] = this.fullName;
    data['modified'] = this.modified;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }

    if (this.urls != null) {
      data['urls'] = this.urls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}