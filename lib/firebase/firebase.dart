import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monprof/models/user.dart';

class DBservice {
  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection("users");
  final box = GetStorage();

  Future saveUser(UserModel user) async {
    try {
      box.write("user", user.toJson());
      await usercollection.doc(user.numero).set(user.toJson());
      return true;
    } catch (e) {
      Logger().d(e);
      return false;
    }
  }

  Future<bool> verifyIfPhoneExist(String numero) async {
    bool exist = false;
    try {
      //vérification du numéro
      final result = await usercollection.get();
      for (var i = 0; i < result.docs.length; i++) {
        Logger().d(result.docs[i].get("telephone") + "--" + numero);
        if (result.docs[i].get("telephone") == numero) {
          exist = true;
          break;
        }
      }
      Logger().d("Existe " + exist.toString());
      return exist;
    } catch (e) {
      return exist;
    }
  }

  Future<UserModel?> loginWithFirestore(String numero, String password) async {
    UserModel? user;
    try {
      if (await verifyIfPhoneExist(numero)) {
        await usercollection.get().then((value) {
          value.docs.forEach((element) {
            if (element.get("telephone") == numero &&
                element.get("password") == password) {
              user = UserModel.fromJson(element.data() as Map<String, dynamic>);
              Logger().d(user);
              if (user != null) {
                saveUser(user!);
              }
              return;
            }
          });
        });
        Logger().d(user!.toJson());
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
