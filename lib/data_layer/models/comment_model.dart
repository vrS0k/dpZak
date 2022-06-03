class CommentModel {
  String comment;
  String grade;
  String projectId;
  String authorSurname;
  String authorName;
  String authorUid;

  CommentModel({
    required this.comment, // конструктор модели
    required this.grade,
    required this.projectId,
    required this.authorSurname,
    required this.authorName,
    required this.authorUid,
  });
}
