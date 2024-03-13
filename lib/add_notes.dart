

import 'package:flutter/material.dart';
import 'package:flutter_note_pad_throuhg_hive_data_base/connstent.dart';
import 'package:flutter_note_pad_throuhg_hive_data_base/note_model.dart';
import 'package:hive/hive.dart';

class InsertNotes extends StatelessWidget {
  InsertNotes({super.key});

  final TextEditingController _title = TextEditingController();
  final TextEditingController _detail = TextEditingController();
   final myBox = Hive.box('Notes');
   
   void _saveNotes(context){
    if(_title.text.isEmpty){
      showTooast(context, "Title is Empty"); 
    }else if(_detail.text.isEmpty){
      showTooast(context, 'Content is empty');
    } else{
      final  myObj=MyNotes(title: _title.text, content:_detail.text);
      myBox.add(myObj);

      myObj.save();
      Navigator.of(context).pop();
    }

   }

   showTooast(context,message){
    final snackBar=SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.cyanAccent,title: const Text("MY NOTES"),centerTitle: true
       ,),
       body: Padding(padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20.0),
       child: Column(children: [
          TextField(
            controller: _title,
            cursorColor: kPrimaryColor,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Title:',labelStyle: const TextStyle(color: kPrimaryColor),
              border: buildingBorder(),
               focusedBorder: buildingBorder(kPrimaryColor),
                enabledBorder: buildingBorder(kPrimaryColor),

            ),

          ),const SizedBox(height: 20,),
          TextField(
            cursorColor: kPrimaryColor,
            controller: _detail,
            maxLines: 5,
            decoration: InputDecoration(
               labelText: 'Detail:',labelStyle: const TextStyle(color: kPrimaryColor),
              border: buildingBorder(),
               focusedBorder: buildingBorder(kPrimaryColor),
                enabledBorder: buildingBorder(kPrimaryColor),
            ),
          )
       ],

       )

    ,),floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    floatingActionButton: FloatingActionButton(onPressed:()=> _saveNotes(context),tooltip: "Save Notes",hoverColor:Colors.green ,
    child: const Center(child:  Text("Save")), ),

    );
  }

OutlineInputBorder borderBuilding([Color]) {
    return OutlineInputBorder(
      borderSide:const  BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              );
  }

  OutlineInputBorder buildingBorder([Color]) {
    return OutlineInputBorder(
    borderSide:const  BorderSide(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              );
  }



}



