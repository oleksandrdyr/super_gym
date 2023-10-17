class Users {
  String email = '';
  String password = '';
  String displayName = '';
  String sex = '';
  String age = '';
  String id = '';
  Users(
      this.email, this.password, this.displayName, this.sex, this.age, this.id);

  Users.empty() {
    email = '';
    password = '';
    displayName = '';
    sex = '';
    age = '';
    id = '';
  }

  @override
  String toString() {
    return 'email = $email, password = $password, displayName = $displayName , sex=$sex, age=$age,id=$id';
  }
}
