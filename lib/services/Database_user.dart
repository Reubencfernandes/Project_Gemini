import 'package:ayumi/entities/user.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class UserDatabase{
  static late Isar isar;

  static Future<void> init() async{
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open([UserSchema], directory: dir.path);
  }
  Future<void> StoreUser(String hisName, String hisBirthday)
  async {
      final newData = User()..name = hisName..birthday = hisBirthday;
      await isar.writeTxn(()=>isar.users.put(newData));
  }
  Future<void> GetUser() async
  {
      print(await isar.users.where().findFirst());
  }



}