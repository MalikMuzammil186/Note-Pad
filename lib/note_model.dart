// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
@HiveType(typeId: 0)
class MyNotes extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String  content;
  MyNotes({
    required this.title,
    required this.content,
  });
  
}
