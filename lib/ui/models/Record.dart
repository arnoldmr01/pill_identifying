class Record {
  String name;
  String introduction;
  String notice;
  String photo;
  

  Record({this.name, this.introduction, this.notice, this.photo});

  factory Record.fromJson(Map<String, dynamic> json) {
    return new Record(
        name: json['name'],
        introduction: json['introduction'],
        notice: json['notice'],
        photo: json['photo']
        );
  }
}
