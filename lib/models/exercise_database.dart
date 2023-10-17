import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ExerciseDatabase {
  late Database _database;

  Future<void> deleteExercise(String exerciseId) async {
    await _database.delete(
      'exercises',
      where: 'id = ?',
      whereArgs: [exerciseId],
    );
  }

  Future<void> initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'exercises.db');
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE exercises(id INTEGER PRIMARY KEY, name TEXT, isCompleted INTEGER)");
    });
  }

  Future<void> insertExercise(String name, bool isCompleted) async {
    await _database.insert(
        'exercises', {'name': name, 'isCompleted': isCompleted ? 1 : 0});
  }

  Future<List<Map<String, dynamic>>> getExercises() async {
    final List<Map<String, dynamic>> exercises =
        await _database.query('exercises');
    return exercises;
  }
}
