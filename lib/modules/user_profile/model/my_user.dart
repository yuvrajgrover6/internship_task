import 'package:hive/hive.dart';
part 'my_user.g.dart';

@HiveType(typeId: 0)
class MyUserModel extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String atype;
  @HiveField(3)
  String age;
  @HiveField(4)
  String gender;
  MyUserModel({
    required this.id,
    required this.name,
    required this.atype,
    required this.age,
    required this.gender,
  });
}
