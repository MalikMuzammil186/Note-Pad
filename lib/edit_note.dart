import 'package:flutter/material.dart';
import 'package:flutter_note_pad_throuhg_hive_data_base/connstent.dart';
import 'package:flutter_note_pad_throuhg_hive_data_base/note_model.dart';
import 'package:hive/hive.dart';

class UpdateNotes extends StatefulWidget {
  MyNotes notes;
   UpdateNotes({Key? key, required this.notes}):super(key: key);

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
final TextEditingController _title = TextEditingController();
  final TextEditingController _detail = TextEditingController();
   final myBox = Hive.box('Notes');
   
   @override
   void initState(){
    super.initState();

    _title.text=widget.notes.title;
   _detail.text=widget.notes.content;

   }
   void _updateNotes(context){

    widget.notes.title=_title.text;
    widget.notes.content=_detail.text;
    widget.notes.save();
    Navigator.of(context).pop();
   }






   showToOast(context, message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const  Text("UPDATE NOTES") ,centerTitle:true,backgroundColor: Colors.blueAccent,),
body: Padding(padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
child: Column(children: [
    TextField(cursorColor: const Color(0xff262fcd7),
            
              controller: _title,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Title',
                  labelStyle:const TextStyle(color: kPrimaryColor),
                border: buildBorder(),
                focusedBorder: buildBorder(kPrimaryColor),
                enabledBorder: buildBorder(kPrimaryColor),
              ),
            ),
         const   SizedBox(
              height: 20,
            ),
            TextField(cursorColor: kPrimaryColor,
              controller: _detail,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle:const TextStyle(color: kPrimaryColor),
                border: borderBuild(),
                  focusedBorder: buildBorder(kPrimaryColor),
                enabledBorder: buildBorder(kPrimaryColor),
              ),
            ),

],),
),
 floatingActionButton: FloatingActionButton.extended(onPressed:() => _updateNotes(context) , 
 label:const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
  Text("Update Notes"),
  Icon(Icons.update_outlined)
 ],)),
    );
  }

   OutlineInputBorder borderBuild([Color]) {
    return OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              );
  }
}