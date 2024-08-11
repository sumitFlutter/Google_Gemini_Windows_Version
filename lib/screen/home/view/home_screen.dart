import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../provider/gemini_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GeminiProvider? readObject;
  GeminiProvider? watchObject;
  TextEditingController textEditingController = TextEditingController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GeminiProvider>().onChangedConnectivity();
    context.read<GeminiProvider>().readList();

  }
  @override
  Widget build(BuildContext context) {
    readObject = context.read<GeminiProvider>();
    watchObject =context.watch<GeminiProvider>();
    Future.delayed(
      const Duration(seconds: 2),
          () {
        if (readObject!.qnaList.length >= 9) {
          itemScrollController.scrollTo(
              index: readObject!.qnaList.length - 1,
              duration: const Duration(seconds: 1));
        }
      },
    );
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1e1e1e),
        surfaceTintColor: const Color(0xff1e1e1e),
        title: const Text("Gemini Ai"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text("How to Delete a Specific Chat?"),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("How to Delete Chat?"),
                          content: const Text(
                            "On Double Tap you can delete the Specific Chat",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK!"))
                          ],
                        );
                      },
                    );
                  },
                ),
                PopupMenuItem(
                  child: const Text("How to All Delete Chat?"),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("How to All Delete Chat?"),
                          content: const Text(
                            "On App info of gemini You have to press  Clear all Data ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK!"))
                          ],
                        );
                      },
                    );
                  },
                ),
                PopupMenuItem(
                  child: const Text("How to use (copy) Ai Generated Answer?"),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("How to use (copy) Ai Generated Answer?"),
                          content: const Text(
                            "On Long Press of Text you can Select the Specific Chat or word or else Sentence",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK!"))
                          ],
                        );
                      },
                    );
                  },
                )
              ];
            },
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/background/whatsApp_chat_bg.jpeg",
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.8,
                width: MediaQuery.sizeOf(context).width,
                child: ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  scrollOffsetController: scrollOffsetController,
                  itemPositionsListener: itemPositionsListener,
                  scrollOffsetListener: scrollOffsetListener,
                  itemCount: watchObject!.qnaList.length,
                  padding: EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    return Align(
                        alignment: watchObject!.isAnsList[index] == 0.toString()
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: InkWell(
                          onDoubleTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Are You Sure?"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        watchObject!.qnaList[index],
                                        style: const TextStyle(
                                            overflow:
                                            TextOverflow.ellipsis),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text("Will be deleted."),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No!")),
                                    ElevatedButton(
                                        onPressed: () {
                                          watchObject!.deleteData(index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Yes!"))
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: watchObject!.qnaList[index].length>=200?
                            MediaQuery.sizeOf(context).width * 0.50:
                            watchObject!.qnaList[index].length>=100?
                            MediaQuery.sizeOf(context).width * 0.40:
                            watchObject!
                                .qnaList[index].length >=
                                60
                                ? MediaQuery.sizeOf(context).width * 0.30
                                : watchObject!
                                .qnaList[index].length >=
                                15
                                ? 220
                                : 150,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: watchObject!.isAnsList[index] == 0.toString()
                                    ? const Color(0xff452473)
                                    : const Color(0xff1F2C33),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: SelectableText(
                                    watchObject!.qnaList[index],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                watchObject!.isAnsList[index]==0.toString()?Container():
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: watchObject!.dateList[index]==
                                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                                      ? Text(
                                      watchObject!.timeList[index])
                                      : Text(
                                      "${watchObject!.dateList[index]}  ${watchObject!.timeList[index]}"),
                                )
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              ),
              watchObject!.isConnected
                  ? SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.08,
                  width: MediaQuery.sizeOf(context).width,
                  child: watchObject!.geminiModel != null
                      ?TextField(
                    controller: textEditingController,
                    minLines: 1,
                    maxLines: 5,
                    onSubmitted: (value) => onSubmit,
                    decoration: InputDecoration(
                        hintText: "Ask me Questions",
                        suffixIcon:  IconButton(
                            onPressed: () async {
                              FocusScope.of(context)
                                  .requestFocus(FocusNode());
                              readObject!
                                  .getQ(textEditingController.text);
                              if (readObject!.qnaList.length >= 5) {
                                itemScrollController.jumpTo(
                                    index:
                                    readObject!.qnaList.length -
                                        1);
                              }
                              textEditingController.clear();
                              readObject!.postAPICall();
                              if (readObject!.qnaList.length >= 5) {
                                itemScrollController.jumpTo(
                                    index:
                                    readObject!.qnaList.length -
                                        1);
                              }
                            },
                            icon: const Icon(Icons.send))
                    ),
                  ):
                  Center(
                    child: const SpinKitFadingCircle(
                      size: 30,
                      color: Colors.white,
                    ),
                  )
              )
                  : Container(
                height: MediaQuery.sizeOf(context).height * 0.08,
                width: MediaQuery.sizeOf(context).width,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all()),
                child: const Center(
                  child: Text(
                    "Kindly Please Check Your Network Connection",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
        ),
    );
  }
  void onSubmit()
  async{
    FocusScope.of(context)
        .requestFocus(FocusNode());
    readObject!
        .getQ(textEditingController.text);
    if (readObject!.qnaList.length >= 5) {
      itemScrollController.jumpTo(
          index:
          readObject!.qnaList.length -
              1);
    }
    textEditingController.clear();
    readObject!.postAPICall();
    if (readObject!.qnaList.length >= 5) {
      itemScrollController.jumpTo(
          index:
          readObject!.qnaList.length -
              1);
    }
  }
}
