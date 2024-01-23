import 'dart:convert';

import 'package:get/get.dart';
import 'package:marvel_project/api/character_api.dart';
import 'package:marvel_project/model/character.dart';

class CharactersController extends GetxController {
  final CharactersApi _charactersApi = CharactersApi();
  RxList<Results> characters = <Results>[].obs;
  int currentPage = 0;
  int pageSize = 30;
  //bool hasMorePages = true;

  @override
  void onInit() {
    super.onInit();
    getAllCharacters();
  }

  Future getAllCharacters() async {
    try {
      final response =
          await _charactersApi.getCharactersByPage(currentPage, pageSize);
      final Map<String, dynamic> responseData = json.decode(response.body);

      print('Marvel API Response: $responseData');

      if (responseData['code'] == 200) {
        final characterData = Character.fromJson(responseData);
        characters.addAll(characterData.data!.results!);
        currentPage++;
      } else {
        print('Marvel API Error: ${responseData['message']}');
      }
    } catch (e) {
      print('Error fetching characters: $e');
    }
  }

  void loadNextPage() async {
    await getAllCharacters();
  }
}
