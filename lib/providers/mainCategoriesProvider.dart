import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainCategories {
  String id;
  String title;
  String imageUrl;
  MainCategories({this.id, this.title, this.imageUrl});
}

class MainCategoriesProvider with ChangeNotifier {
  List<MainCategories> _categoriesList = [];

  List<MainCategories> get categoriesList {
    return [..._categoriesList];
  }

  /*void appendList(List<String> list) {
    _productsList.addAll(list);
    notifyListeners();
  }*/

  Future<void> fetchMainCategories() async {
    const url = 'site url/api/main_categories/';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      _categoriesList.clear();
      data.forEach((key, value) {
        _categoriesList.add(MainCategories(
          id: value['id'],
          title: value['title'],
          imageUrl:
              'site url/${value["image"]}',
        ));
      });
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }
}
