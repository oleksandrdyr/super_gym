import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class FirestoreCrud {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static createUser(
    String id,
    String displayName,
    String Age,
    String Sex,
  ) async {
    try {
      // Создаем новый документ в коллекции "users" с данными пользователя.
      await _firestore
          .collection('users')
          .add({'id': id, 'displayName': displayName, 'Age': Age, 'Sex': Sex});

      // Выводим сообщение об успешном создании пользователя.
      print('Пользователь успешно создан в Firestore.');
    } catch (e) {
      // Выводим сообщение об ошибке, если что-то пошло не так.
      print('Ошибка при создании пользователя: $e');
    }
  }
}
