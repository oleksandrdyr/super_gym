class Checked {
  String exercisesId = '';
  final String title;
  bool isCompleted;

  Checked(
      {required this.exercisesId,
      required this.title,
      this.isCompleted = false});
}
