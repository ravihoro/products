import 'package:flutter/material.dart';
import 'package:products/views/home_view.dart';
import 'package:provider/provider.dart';
import './app/locator.dart';
import './viewmodel/base_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BaseModel(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        title: "Product Listing",
        home: HomeView(),
      ),
    );
  }
}
