import 'package:flutter/material.dart';
import 'pages/categories/mainsubcategory.dart';
import 'package:provider/provider.dart';
import 'pages/product/product.dart';
import 'providers/mainCategoriesProvider.dart';
import 'providers/mainSubCategoriesProvider.dart';
import 'providers/subCategoriesProvider.dart';

import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsSearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainSubCategoriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SubCategoriesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
          primarySwatch: Colors.pink,
        ),
        initialRoute: MainSubCategory.routname,
        routes: <String, WidgetBuilder>{
          MainSubCategory.routname: (context) =>
              MainSubCategory(id: "", title: "", image: ""),
          Product.routname: (contaxt) => Product(),
        },
      ),
    );
  }
}
