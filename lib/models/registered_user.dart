class RegisteredUser {
  String Name = '';
  String Sex = '';
  String Age = '';
  RegisteredUser(this.Name, this.Sex, this.Age);
  RegisteredUser.emty() {
    Name = 'Alex';
    Sex = 'Male';
    Age = '38';
  }
  @override
  String toString() {
    return 'name=$Name, Sex=$Sex, Age=$Age';
  }
}
