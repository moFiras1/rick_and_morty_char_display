class CharactersDataModel {
  Info? info;
  List<Results>? results;

  CharactersDataModel({this.info, this.results});

  CharactersDataModel.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

}

class Info {
  int? count;
  int? pages;


  Info({this.count, this.pages});

  Info.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'];
  }

}

class Results {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  String? image;

  Results(
      {this.id,
        this.name,
        this.status,
        this.species,
        this.type,
        this.gender,
        this.image,
       });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    image = json['image'];
  }

}

