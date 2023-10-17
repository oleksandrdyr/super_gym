// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExerciseToSqlite {
  String? id;
  String? name;
  String? video;
  int? reps;
  int? sets;
  double? weight;
  ExerciseToSqlite({
    this.id,
    this.name,
    this.video,
    this.reps,
    this.sets,
    this.weight,
  });

  ExerciseToSqlite copyWith({
    String? id,
    String? name,
    String? video,
    int? reps,
    int? sets,
    double? weight,
  }) {
    return ExerciseToSqlite(
      id: id ?? this.id,
      name: name ?? this.name,
      video: video ?? this.video,
      reps: reps ?? this.reps,
      sets: sets ?? this.sets,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'video': video,
      'reps': reps,
      'sets': sets,
      'weight': weight,
    };
  }

  factory ExerciseToSqlite.fromMap(Map<String, dynamic> map) {
    return ExerciseToSqlite(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      video: map['video'] != null ? map['video'] as String : null,
      reps: map['reps'] != null ? map['reps'] as int : null,
      sets: map['sets'] != null ? map['sets'] as int : null,
      weight: map['weight'] != null ? map['weight'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseToSqlite.fromJson(String source) =>
      ExerciseToSqlite.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExerciseToSqlite(id: $id, name: $name, video: $video, reps: $reps, sets: $sets, weight: $weight)';
  }

  @override
  bool operator ==(covariant ExerciseToSqlite other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.video == video &&
        other.reps == reps &&
        other.sets == sets &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        video.hashCode ^
        reps.hashCode ^
        sets.hashCode ^
        weight.hashCode;
  }
}
