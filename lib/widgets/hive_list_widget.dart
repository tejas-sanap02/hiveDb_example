import 'package:flutter/material.dart';
import 'package:hive_example/model/user_model.dart';

class HiveWidget{

  Widget hiveListWidget({required UserModel userData,required VoidCallback onEditTap,required VoidCallback onDeleteTap}){
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        border: Border.all(color: Colors.blue.shade900),
        borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customKeyValueTxt("NAME", userData.name),
              customKeyValueTxt("MOBILE NO", userData.mobile),
              customKeyValueTxt("DESCRIPTION", userData.description),
            ],
          ),

          Row(
            children: [
              InkWell(
                onTap: onEditTap,
                  child: Icon(Icons.edit,)),
              SizedBox(width: 12,),
              InkWell(
                onTap: onDeleteTap,
                  child: Icon(Icons.delete,)),
            ],
          )
        ],
      ),
    );
  }
  Widget customTextField(String label,TextEditingController controller){
    return    TextField(
      controller: controller,
      decoration:  InputDecoration(labelText: label,hintText: label),
    );
  }
  Widget customKeyValueTxt(String keyTxt,String valueTxt){
    return    Row(
      children: [
        Text("$keyTxt:  ",style: TextStyle( fontSize: 18),),
        Text("$valueTxt",style: TextStyle( fontSize: 18),),
      ],
    );
  }

  
  
}