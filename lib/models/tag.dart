class TagModel {
  final String title;
  final String uid;
  final DateTime createdAt;
  final DateTime updatedAt;

  TagModel(
      {required this.title,
      required this.uid,
      required this.createdAt,
      required this.updatedAt});
}
