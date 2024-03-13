import 'package:flutter/material.dart';
import 'package:flutter_note_pad_throuhg_hive_data_base/add_notes.dart';
import 'package:flutter_note_pad_throuhg_hive_data_base/edit_note.dart';
import 'package:flutter_note_pad_throuhg_hive_data_base/note_adapter.dart';
import 'package:flutter_note_pad_throuhg_hive_data_base/note_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main()async {
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox("Notes");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOTE PAD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'NOTE PAD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 final myBox=Hive.box('Notes');

 void editNote(context,MyNotes myNotes){
  Navigator.push(context, MaterialPageRoute(builder:(context) =>
   UpdateNotes(notes: myNotes),));
 }

 void deleteNotes(MyNotes myNotes)async{
 await myNotes.delete();
 }
 void  _addNotes(){
  Navigator.push(context, MaterialPageRoute(builder:(context) => InsertNotes(),));
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),centerTitle: true,
      ),
      body: ValueListenableBuilder
      (valueListenable:myBox.listenable(),

       builder:(context, box, child) {
        final data=box.values.toList().cast<MyNotes>();
        return ListView.separated( itemCount: box.length,
        separatorBuilder:(context, index) {
          return 
          const SizedBox(height: 20,);
        },
          itemBuilder:(context, index) {
          return Container(
            padding: const EdgeInsets.only(left: 10,top: 10,bottom: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(colors: [Color.fromARGB(162, 40, 199, 130),Color.fromARGB(214, 199, 170, 40)])),
         child:Column(crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text(data[index].title),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed:() {
                     deleteNotes(data[index]);
                  },  icon:const Icon(Icons.delete)),
                  IconButton(onPressed:() =>editNote(context, data[index]) , icon:const  Icon(Icons.create))
                ],)
              ],),
              subtitle:Padding(padding:const EdgeInsets.only(top: 10,bottom: 10),
              child: Text(data[index].content),) ,
              
            )
            
          ],
         ) , );
        }, 
        
        );
         
       },)
      
      ,
      floatingActionButton: FloatingActionButton(
        onPressed:_addNotes,
        tooltip: 'create Note',
        child: const Icon(Icons.create_outlined),
      ),
    );
  }
}
