
import 'package:demo/project2/loginpage.dart';
import 'package:demo/sharedpref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';




void main()async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'first',
      routes: {
   
        
      },
      title: 'Flutter Demo',
 
 home:Loginpageee(),



    
    
    
    );
  }
}




