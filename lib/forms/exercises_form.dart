import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gym/models/exercise_database.dart';

class ExercisesForm extends StatefulWidget {
  const ExercisesForm({Key? key}) : super(key: key);

  @override
  State<ExercisesForm> createState() => _ExercisesFormState();
}

class _ExercisesFormState extends State<ExercisesForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ExerciseDatabase database = ExerciseDatabase();
  List<Map<String, dynamic>> exercises = [];

  // Функция для выполнения выхода пользователя
  Future<void> _signOut() async {
    await _auth.signOut();
  }

  void deleteExercise(String exerciseId) async {
    await database.deleteExercise(exerciseId);
    loadExercises(); // Обновите список упражнений после удаления.
  }

  void loadExercises() async {
    exercises = await database.getExercises();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    database.initializeDatabase().then((_) {
      loadExercises();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Exercises Form'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _signOut();
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          final exerciseId = exercise[
              'id']; // Предполагается, что у упражнений есть поле 'id'.
          final exerciseName = exercise['name'];

          return ListTile(
            title: Text(exerciseName),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Удалить упражнение?'),
                      content:
                          Text('Вы уверены, что хотите удалить $exerciseName?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            deleteExercise(exerciseId.toString());
                            Navigator.of(context).pop();
                          },
                          child: Text('Удалить'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Отмена'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, '/ExerciseListWidget');
          });
        },
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
