class UserModel {
  String surname;
  String name;
  String patronymic;
  String address;
  String phone;
  String uid;
  List projectIdList;

  UserModel({
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.address,
    required this.phone,
    required this.uid,
    required this.projectIdList,
  });
}