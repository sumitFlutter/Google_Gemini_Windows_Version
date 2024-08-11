import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper{
  List<String> text=[];
  List<String> isAns=[],date=[],time=[];
  Map<String,List<String>> all={"text":[],"isAns":[],"date":[],"time":[]};
  static SharedHelper sharedHelper=SharedHelper._();
  SharedHelper._();
  Future<void> setData({required List<String> textList,required List<String> isAnsList,required List<String> timeList,required List<String> dateList})
  async {
    SharedPreferences shr=await SharedPreferences.getInstance();
    shr.setStringList("text", textList);
    shr.setStringList("isAns", isAnsList);
    shr.setStringList("time", timeList);
    shr.setStringList("date", dateList);
  }
  Future<Map<String, List<String>>> getData()
  async {
    SharedPreferences shr=await SharedPreferences.getInstance();
    if(shr.getStringList("text")!=null)
      {
        text=shr.getStringList("text")!;
        isAns=shr.getStringList("isAns")!;
        time=shr.getStringList("time")!;
        date=shr.getStringList("date")!;
      }
    else{
      text=[];
      isAns=[];
      date=[];
      time=[];
    }
    all={"text":text,"isAns":isAns,"date":date,"time":time};
    return all;
  }
}