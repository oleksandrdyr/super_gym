// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class Exercises {
//   String name = '';
//   int sets = 0;
//   int reps = 0;
//   String video = '';
//   String weight = '';
//   Exercises({
//     required this.name,
//     required this.sets,
//     required this.reps,
//     required this.video,
//     required this.weight,
//   });

//   Exercises copyWith({
//     String? name,
//     int? sets,
//     int? reps,
//     String? video,
//     String? weight,
//   }) {
//     return Exercises(
//       name: name ?? this.name,
//       sets: sets ?? this.sets,
//       reps: reps ?? this.reps,
//       video: video ?? this.video,
//       weight: weight ?? this.weight,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'sets': sets,
//       'reps': reps,
//       'video': video,
//       'weight': weight,
//     };
//   }

//   factory Exercises.fromMap(Map<String, dynamic> map) {
//     return Exercises(
//       name: map['name'] as String,
//       sets: map['sets'] as int,
//       reps: map['reps'] as int,
//       video: map['video'] as String,
//       weight: map['weight'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Exercises.fromJson(String source) =>
//       Exercises.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'Exercises(name: $name, sets: $sets, reps: $reps, video: $video, weight: $weight)';
//   }

//   @override
//   bool operator ==(covariant Exercises other) {
//     if (identical(this, other)) return true;

//     return other.name == name &&
//         other.sets == sets &&
//         other.reps == reps &&
//         other.video == video &&
//         other.weight == weight;
//   }

//   @override
//   int get hashCode {
//     return name.hashCode ^
//         sets.hashCode ^
//         reps.hashCode ^
//         video.hashCode ^
//         weight.hashCode;
//   }
// }
