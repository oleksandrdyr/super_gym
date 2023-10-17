import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gym/models/users.dart';

// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';

class KeeperChat {
  String userEmail = '';
  String password = '';
  String displayName = '';
  bool rememberMe = true;

  Users users = Users.empty();
}

class DataCubitChat extends Cubit<KeeperChat> {
  String get getUserEmail => state.userEmail;

  setUserEmail(String newUserEmail) {
    state.userEmail = newUserEmail;
  }

  String get getPassword => state.password;

  setPassword(String newPassword) {
    state.password = newPassword;
  }

  setDiasplayName(String newDisplayName) {
    state.displayName = newDisplayName;
  }

  bool get getRememberMe => state.rememberMe;

  setRememberMe(bool newRememberMe) {
    state.rememberMe = newRememberMe;
  }

  Users get getUser => state.users;

  setCurrentUser(Users NewUser) {
    state.users = NewUser;
    print('NewUser = $NewUser');
  }

  DataCubitChat(KeeperChat initState) : super(initState);
}
