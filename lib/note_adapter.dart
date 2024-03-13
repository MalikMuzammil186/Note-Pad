import 'package:flutter_note_pad_throuhg_hive_data_base/note_model.dart';
import 'package:hive/hive.dart';

class NoteAdapter extends TypeAdapter<MyNotes> {
  final int typeid=0;
  @override
  MyNotes read(BinaryReader reader) {
    final numofFields=reader.readByte();
    final fields=<int,dynamic>{
      for(int i=0;i<numofFields;i++) reader.readByte():reader.read(),
    };
    return MyNotes(
      title: fields[0]as String,
       content: fields[1] as String);
  }

  @override
  
  int get typeId => typeid.hashCode;

  @override
  void write(BinaryWriter writer, MyNotes obj) {
    writer..
      writeByte(2)
    ..writeByte(0)
    ..write(obj.title)
    ..writeByte(1)
    ..write(obj.content);
   
  }

  @override
  bool operator == (Object other)=>
  identical(this, other) ||
  other is NoteAdapter && runtimeType==other.runtimeType&&
  typeid==other.typeid;
  
  @override
  
  int get hashCode => typeId.hashCode;
  
  
}