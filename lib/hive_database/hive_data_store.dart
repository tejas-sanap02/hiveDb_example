import 'package:hive/hive.dart';
import 'package:hive_example/model/user_model.dart';

class HiveDataStore {
  static const boxName = "userBox";
  static Box<UserModel> box = Hive.box<UserModel>(boxName);

  Future addUser({required UserModel userModel}) async {
    await box.add(userModel);
  }

  Future getUser({required String id}) async {
    await box.get(id);
  }

  Future updateUser({required int index, required UserModel userModel}) async {
    await box.putAt(index, userModel);
  }

  Future deleteUser({required int index}) async {
    await box.deleteAt(index);
  }
}
