
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_gemini_window_version/utils/helpers/shared_helper.dart';

import '../../../utils/helpers/api_helper.dart';
import '../../../utils/helpers/connectivity_helper.dart';
import '../model/gemini_model.dart';

class GeminiProvider with ChangeNotifier{
  List<String> qnaList=[];
  List<String> isAnsList=[],timeList=[],dateList=[];
  Map<String,List<String>> allMap={};
  GeminiModel? geminiModel=GeminiModel();
  ConnectivityHelper helper=ConnectivityHelper();
  bool isConnected=true;

  String text="Who is PM of INDIA?";
  APIHelper apiHelper=APIHelper();
  Future<void> getDataFromSharedHelper()
  async {
      allMap=await SharedHelper.sharedHelper.getData();
      qnaList=allMap["text"]!;
      isAnsList=allMap["isAns"]!;
      timeList=allMap["time"]!;
      dateList=allMap["date"]!;
  }
  void setDataFor()
  async {
    await SharedHelper.sharedHelper.setData(textList: qnaList,isAnsList: isAnsList,timeList: timeList,dateList: dateList);
  }
  void postAPICall()
  async {
    if(await apiHelper.apiCall(text)!=null)
      {
        geminiModel=(await apiHelper.apiCall(text));
         getDataFromSharedHelper();
        qnaList.add(geminiModel!.candidatesModelList![0].contentModel!.parts![0].text!);
        isAnsList.add(0.toString());
        timeList.add("${DateTime.now().hour}:${DateTime.now().minute}");
        dateList.add("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
        setDataFor();
         getDataFromSharedHelper();
        //await HiveHelper.hiveHelper.addChat(GeminiDBModel(text:,time: "${DateTime.now().hour}:${DateTime.now().minute}",date: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",isQ: 1));
      }
    else{
      geminiModel=GeminiModel();
      //await HiveHelper.hiveHelper.addChat(GeminiDBModel(text: "SomeThing Went Wrong",time: "${DateTime.now().hour}:${DateTime.now().minute}",date: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",isQ: 1));
       getDataFromSharedHelper();
      qnaList.add("SomeThing Went Wrong");
      isAnsList.add(0.toString());
      timeList.add("${DateTime.now().hour}:${DateTime.now().minute}");
      dateList.add("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
      setDataFor();
      getDataFromSharedHelper();

    }
    notifyListeners();
  }
  void getQ(String q)
  async {
    text=q;
    geminiModel=null;
    getDataFromSharedHelper();
    qnaList.add(q);
    isAnsList.add(1.toString());
    timeList.add("${DateTime.now().hour}:${DateTime.now().minute}");
    dateList.add("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    setDataFor();
    getDataFromSharedHelper();
    notifyListeners();
  }
  void readList()
  async {
    getDataFromSharedHelper();
    notifyListeners();
  }
 /* Future<void> checkConnectivity()
  async {
   isConnected=await helper.checkConnectivity();
    if(isConnected==true)
      {
        geminiModel=GeminiModel();
      }
    notifyListeners();
  }*/
  void first()
  async {
    ConnectivityResult firstTime = await Connectivity().checkConnectivity();
    if(firstTime==ConnectivityResult.none)
    {
      isConnected=false;
    }
    else {
      isConnected = true;
      geminiModel=GeminiModel();
    }
    notifyListeners();
  }
  void onChangedConnectivity()
  {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result==ConnectivityResult.none)
      {
        isConnected=false;
      }
      else{
        isConnected=true;
        geminiModel=GeminiModel();
      }
      notifyListeners();
    });


  }
  void deleteData(int index)
  async {
    getDataFromSharedHelper();
    qnaList.removeAt(index);
    isAnsList.removeAt(index);
    dateList.removeAt(index);
    timeList.removeAt(index);
    setDataFor();
    getDataFromSharedHelper();
    notifyListeners();
  }

}