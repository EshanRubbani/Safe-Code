
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:safes_code/helper/auth_binding.dart';
import 'package:safes_code/views/SplashServices/splashScreen.dart';
import 'package:safes_code/helper/page_navigation.dart';
import 'package:safes_code/views/auth/login_page.dart';
import 'package:safes_code/views/auth/register_page.dart';
import 'package:safes_code/views/profile/edit_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Hive.initFlutter();
  // final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);
  // Hive.registerAdapter(ProfileAdapter());
  // await Hive.openBox<Profile>('profile');

  runApp(MyApp()
  );
}
  class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => (PageNavigator()), binding: AuthBinding()),
      ],
    );
  }
}

