import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myrecipeapp/models/recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "e5e0962b88mshce8e2745d9a7d43p1b873djsn84e633c70bf3",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body ?? '');
    List _temp = [];

    if (data != null && data['feed'] != null) {
      for (var i in data['feed']) {
        _temp.add(i['content']['details']);
      }
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}