class SeriesDataModel {
  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHTML;
  String etag;
  Data data;

  SeriesDataModel(
      {this.code,
      this.status,
      this.copyright,
      this.attributionText,
      this.attributionHTML,
      this.etag,
      this.data});

  SeriesDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    copyright = json['copyright'];
    attributionText = json['attributionText'];
    attributionHTML = json['attributionHTML'];
    etag = json['etag'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['copyright'] = this.copyright;
    data['attributionText'] = this.attributionText;
    data['attributionHTML'] = this.attributionHTML;
    data['etag'] = this.etag;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<Results> results;

  Data({this.offset, this.limit, this.total, this.count, this.results});

  Data.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['count'] = this.count;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int id;
  String title;
  String description;
  String resourceURI;
  List<Urls> urls;
  int startYear;
  int endYear;
  String rating;
  String type;
  String modified;
  Thumbnail thumbnail;
  Creators creators;
  Creators characters;
  Creators stories;
  Creators comics;
  Events events;
  CreatorItems next;
  dynamic previous;

  Results(
      {this.id,
      this.title,
      this.description,
      this.resourceURI,
      this.urls,
      this.startYear,
      this.endYear,
      this.rating,
      this.type,
      this.modified,
      this.thumbnail,
      this.creators,
      this.characters,
      this.stories,
      this.comics,
      this.events,
      this.next,
      this.previous});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    resourceURI = json['resourceURI'];
    if (json['urls'] != null) {
      urls = new List<Urls>();
      json['urls'].forEach((v) {
        urls.add(new Urls.fromJson(v));
      });
    }
    startYear = json['startYear'];
    endYear = json['endYear'];
    rating = json['rating'];
    type = json['type'];
    modified = json['modified'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    creators = json['creators'] != null
        ? new Creators.fromJson(json['creators'])
        : null;
    characters = json['characters'] != null
        ? new Creators.fromJson(json['characters'])
        : null;
    stories =
        json['stories'] != null ? new Creators.fromJson(json['stories']) : null;
    comics =
        json['comics'] != null ? new Creators.fromJson(json['comics']) : null;
    events =
        json['events'] != null ? new Events.fromJson(json['events']) : null;
    next =
        json['next'] != null ? new CreatorItems.fromJson(json['next']) : null;
    previous = json['previous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['resourceURI'] = this.resourceURI;
    if (this.urls != null) {
      data['urls'] = this.urls.map((v) => v.toJson()).toList();
    }
    data['startYear'] = this.startYear;
    data['endYear'] = this.endYear;
    data['rating'] = this.rating;
    data['type'] = this.type;
    data['modified'] = this.modified;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    if (this.creators != null) {
      data['creators'] = this.creators.toJson();
    }
    if (this.characters != null) {
      data['characters'] = this.characters.toJson();
    }
    if (this.stories != null) {
      data['stories'] = this.stories.toJson();
    }
    if (this.comics != null) {
      data['comics'] = this.comics.toJson();
    }
    if (this.events != null) {
      data['events'] = this.events.toJson();
    }
    if (this.next != null) {
      data['next'] = this.next.toJson();
    }
    data['previous'] = this.previous;
    return data;
  }
}

class Urls {
  String type;
  String url;

  Urls({this.type, this.url});

  Urls.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

class Thumbnail {
  String path;
  String extension;

  Thumbnail({this.path, this.extension});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['extension'] = this.extension;
    return data;
  }
}

class Creators {
  int available;
  String collectionURI;
  List<CreatorItems> items;
  int returned;

  Creators({this.available, this.collectionURI, this.items, this.returned});

  Creators.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    collectionURI = json['collectionURI'];
    if (json['items'] != null) {
      items = new List<CreatorItems>();
      json['items'].forEach((v) {
        items.add(new CreatorItems.fromJson(v));
      });
    }
    returned = json['returned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['collectionURI'] = this.collectionURI;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['returned'] = this.returned;
    return data;
  }
}

class CreatorItems {
  String resourceURI;
  String name;
  String role;

  CreatorItems({this.resourceURI, this.name, this.role});

  CreatorItems.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceURI'] = this.resourceURI;
    data['name'] = this.name;
    data['role'] = this.role;
    return data;
  }
}

class ComicsItem {
  String resourceURI;
  String name;

  ComicsItem({this.resourceURI, this.name});

  ComicsItem.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceURI'] = this.resourceURI;
    data['name'] = this.name;
    return data;
  }
}

class Items {
  String resourceURI;
  String name;
  String types;

  Items({this.resourceURI, this.name, this.types});

  Items.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
    types = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceURI'] = this.resourceURI;
    data['name'] = this.name;
    data['type'] = this.types;
    return data;
  }
}

class Events {
  int available;
  String collectionURI;
  List<Null> items;
  int returned;

  Events({this.available, this.collectionURI, this.items, this.returned});

  Events.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    collectionURI = json['collectionURI'];
    if (json['items'] != null) {
      items = new List<Null>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['collectionURI'] = this.collectionURI;
    if (this.items != null) {
      data['items'] = [];
    }
    data['returned'] = this.returned;
    return data;
  }
}
