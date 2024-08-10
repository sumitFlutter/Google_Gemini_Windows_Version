import 'package:hive/hive.dart';
part 'db_model.g.dart';
@HiveType(typeId: 0)
class GeminiDBModel{
  @HiveField(0)
 late final int isQ;
  @HiveField(1)
  late final String text;
  @HiveField(2)
  late final String date;
  @HiveField(3)
  late final String time;

  GeminiDBModel({required this.isQ, required this.text, required this.date,required this.time});
}
//,date,time;