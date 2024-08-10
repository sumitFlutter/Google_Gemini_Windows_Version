import 'package:google_gemini_window_version/screen/home/model/db_model.dart';
import 'package:hive/hive.dart';
class HiveHelper{
  static HiveHelper hiveHelper =HiveHelper._();
  HiveHelper._();
  Box<GeminiDBModel>? geminiChatBox;
  void openBox()
  {
    Hive.openBox<GeminiDBModel>('geminiChatBox');
    geminiChatBox=Hive.box('geminiChatBox');
    //call this method in main.dart
  }
  Future<void> addChat(GeminiDBModel geminiDBModel)
  async {
    await geminiChatBox!.add(geminiDBModel);
  }
  List<GeminiDBModel> getChat()
  {
    List<GeminiDBModel> chatList=geminiChatBox!.values.toList();
    return chatList;
  }
  Future<void> deleteChat(int index)
  async {
   await geminiChatBox!.deleteAt(index);
  }
}