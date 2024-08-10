import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper{
  List<String> text=[];
  List<String> isAns=[];
  Map<String,List<String>> all={"text":[],"isAns":[]};
  static SharedHelper sharedHelper=SharedHelper._();
  SharedHelper._();
  Future<void> setData({required List<String> textList,required List<String> isAnsList})
  async {
    SharedPreferences shr=await SharedPreferences.getInstance();
    shr.setStringList("text", textList);
    shr.setStringList("isAns", isAnsList);
  }
  Future<Map<String, List<String>>> getData()
  async {
    SharedPreferences shr=await SharedPreferences.getInstance();
    if(shr.getStringList("text")!=null)
      {
        text=shr.getStringList("text")!;
        isAns=shr.getStringList("isAns")!;
      }
    else{
      text=[];
      isAns=[];
    }
    all={"text":text,"isAns":isAns};
    return all;
  }
}