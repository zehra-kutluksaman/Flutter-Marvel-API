import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_project/controller/controller.dart';
import 'package:marvel_project/view/character_detail_screen.dart';
import 'package:marvel_project/view_model/custom_appbar.dart';
import 'package:marvel_project/view_model/custom_drawer.dart';

class Home extends StatelessWidget {
  final CharactersController charactersController =
      Get.put(CharactersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 242, 242),
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Center(
        child: Obx(() {
          if (charactersController.characters.isEmpty) {
            return const CircularProgressIndicator();
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: charactersController.characters.length + 1,
                    itemBuilder: (context, index) {
                      if (index == charactersController.characters.length) {
                        // Eğer sona gelindiğinde Load More butonu göster
                        return ElevatedButton(
                          onPressed: () {
                            charactersController.loadNextPage();
                          },
                          child: const Text('Load More'),
                        );
                      }

                      final character = charactersController.characters[index];
                      return Container(
                        height: 120,
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 238, 217, 238),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(3, 5),
                                color: Color.fromARGB(255, 217, 168, 225),
                                blurRadius: 4),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            if (character.id != null) {
                              navigateToCharacterDetails(character.id!);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: character.thumbnail != null
                                    ? Image.network(
                                        '${character.thumbnail!.path}.${character.thumbnail!.extension}',
                                        height: 150,
                                        width: 120,
                                      )
                                    : const Text('No Image Available'),
                              ),
                              const Spacer(),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  character.name ?? '',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  void navigateToCharacterDetails(int characterId) {
    Get.to(() => CharacterDetailScreen(characterId: characterId));
  }
}
