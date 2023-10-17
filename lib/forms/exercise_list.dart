// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gym/models/exercise_database.dart';

class Exercise {
  final String id;
  final String name;
  final String video;

  Exercise({
    required this.id,
    required this.name,
    required this.video,
  });
}

class ExerciseListWidget extends StatefulWidget {
  @override
  State<ExerciseListWidget> createState() => _ExerciseListWidgetState();
}

class _ExerciseListWidgetState extends State<ExerciseListWidget> {
  List<Checked> checks = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('exercises').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No exercises found.');
        }

        List<Exercise> exercises = snapshot.data!.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Exercise(
            id: doc.id,
            name: data['name'] ?? '',
            video: data['video'] ?? '',
          );
        }).toList();

        // Initialize the checks list only once
        if (checks.isEmpty) {
          checks = exercises.map((exercise) {
            return Checked(
              exercisesId: exercise.id,
              title: exercise.name,
              isCompleted: true,
            );
          }).toList();
        }

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: checks.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      value: checks[index].isCompleted,
                      title: Text(checks[index].title),
                      onChanged: (bool? value) {
                        setState(() {
                          checks[index].isCompleted = value ?? false;
                        });
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      ExerciseDatabase database = ExerciseDatabase();
                      await database.initializeDatabase();

                      checks.forEach((check) async {
                        await database.insertExercise(
                            check.title, check.isCompleted);
                      });

                      Navigator.of(context)
                          .pushReplacementNamed('/ExercisesForm');
                    },
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Reset the checkboxes if needed
                        checks.forEach((check) {
                          check.isCompleted = false;
                        });
                      });
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class Checked {
  final String exercisesId;
  final String title;
  bool isCompleted;
  Checked({
    required this.exercisesId,
    required this.title,
    required this.isCompleted,
  });

  Checked copyWith({
    String? exercisesId,
    String? title,
    bool? isCompleted,
  }) {
    return Checked(
      exercisesId: exercisesId ?? this.exercisesId,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exercisesId': exercisesId,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory Checked.fromMap(Map<String, dynamic> map) {
    return Checked(
      exercisesId: map['exercisesId'] as String,
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Checked.fromJson(String source) =>
      Checked.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Checked(exercisesId: $exercisesId, title: $title, isCompleted: $isCompleted)';

  @override
  bool operator ==(covariant Checked other) {
    if (identical(this, other)) return true;

    return other.exercisesId == exercisesId &&
        other.title == title &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode =>
      exercisesId.hashCode ^ title.hashCode ^ isCompleted.hashCode;
}
