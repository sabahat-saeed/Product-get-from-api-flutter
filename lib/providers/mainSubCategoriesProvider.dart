import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainSubCategories {
  String id;
  String title;
  String imageUrl;
  MainSubCategories({this.id, this.title, this.imageUrl});
}

class MainSubCategoriesProvider with ChangeNotifier {
  List<MainSubCategories> _categoriesList = [];

  List<MainSubCategories> get categoriesList {
    return [..._categoriesList];
  }

  Future<void> fetchMainSubCategories(String id) async {
    final url = 'site url/$id';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      _categoriesList.clear();
      data.forEach((key, value) {
        _categoriesList.add(MainSubCategories(
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
