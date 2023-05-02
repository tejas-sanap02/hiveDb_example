import 'package:flutter/material.dart';
import 'package:hive_example/hive_database/hive_data_store.dart';
import 'package:hive_example/model/user_model.dart';
import 'package:hive_example/widgets/hive_list_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveScreen extends StatefulWidget {
  const HiveScreen({Key? key}) : super(key: key);

  @override
  State<HiveScreen> createState() => _HiveScreenState();
}

class _HiveScreenState extends State<HiveScreen> {
  HiveWidget hiveCustomWidget = HiveWidget();
  final HiveDataStore hiveDataStore = HiveDataStore();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ValueNotifier<bool> isUpdate = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: HiveDataStore.box.listenable(),
        builder: (context, Box box, widget) {

          return (box.length > 0 && box != null)? ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              UserModel userData = box.getAt(index);
              return hiveCustomWidget.hiveListWidget(
                userData: userData,
                onEditTap: () {
                  isUpdate.value = true;
                  _customShowDialog(index: index,userData: userData);
                },
                onDeleteTap: () {
                  hiveDataStore.deleteUser(index: index);
                },
              );

            },
          ):Text("No Data Found");
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            isUpdate.value = false;
            //_customShowDialog();
            hiveDataStore.deleteUser(index: 0);

          },
          child: const Icon(
            Icons.add,
            size: 34,
          )),
    );
  }

  _customShowDialog({int? index,UserModel? userData}) {
    if (isUpdate.value){
      nameController.text = userData!.name;
      mobileController.text = userData!.mobile;
      descriptionController.text = userData!.description;
    }else{
      nameController.clear();
      mobileController.clear();
      descriptionController.clear();
    }
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              hiveCustomWidget.customTextField("Name", nameController),
              hiveCustomWidget.customTextField("Mobile No", mobileController),
              hiveCustomWidget.customTextField(
                  "Description", descriptionController),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    if (isUpdate.value) {
                      final user = UserModel(
                          name: nameController.text,
                          mobile: mobileController.text,
                          description: descriptionController.text);
                      hiveDataStore.updateUser(index: index!, userModel: user).then((value) {
                        // nameController.clear();
                        // mobileController.clear();
                        // descriptionController.clear();
                      });
                      Navigator.pop(context);
                    } else {
                      final user = UserModel(
                          name: nameController.text,
                          mobile: mobileController.text,
                          description: descriptionController.text);
                      hiveDataStore.addUser(userModel: user).then((value) {
                        // nameController.clear();
                        // mobileController.clear();
                        // descriptionController.clear();
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (isUpdate.value) ? "update" : "Add",
                      style: const TextStyle(fontSize: 22),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
