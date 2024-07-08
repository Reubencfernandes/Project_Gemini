import 'package:isar/isar.dart';
part 'user.g.dart';

@collection
class User {
  final Id = Isar.autoIncrement;
  late String name;
  late String birthday;

}
