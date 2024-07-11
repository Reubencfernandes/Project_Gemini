import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  final id = Isar.autoIncrement;
  late String name;
  late String birthday;
}
