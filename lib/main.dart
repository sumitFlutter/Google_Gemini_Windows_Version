import 'package:flutter/material.dart';
import 'package:google_gemini_window_version/screen/home/model/db_model.dart';
import 'package:google_gemini_window_version/screen/home/provider/gemini_provider.dart';
import 'package:google_gemini_window_version/utils/helpers/hive_helper.dart';
import 'package:google_gemini_window_version/utils/routes/my_routes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
void main()
async {
  await hiveInit();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GeminiProvider())
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        routes: appRoutes,
      ),
    );
  }
}
Future<void> hiveInit()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GeminiDBModelAdapter());
  HiveHelper.hiveHelper.openBox();
}
