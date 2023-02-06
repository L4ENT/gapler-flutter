class TagModel {
  final String title;
  final String uuid;

  TagModel({required this.title, required this.uuid});

  TagModel copyWith({String? title, String? uuid}) {
    return TagModel(title: title ?? this.title, uuid: uuid ?? this.uuid);
  }
}
