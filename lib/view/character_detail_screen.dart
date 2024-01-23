import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_project/controller/controller.dart';
import 'package:marvel_project/view_model/custom_drawer.dart';

class CharacterDetailScreen extends StatelessWidget {
  final int characterId;

  CharacterDetailScreen({required this.characterId});

  @override
  Widget build(BuildContext context) {
    final CharactersController charactersController =
        Get.put(CharactersController());

    final character =
        charactersController.characters.firstWhere((c) => c.id == characterId);

    final List<String?> comicsList = character.comics?.items
            ?.where((item) =>
                item.name != null &&
                item.name!.isNotEmpty &&
                item.resourceURI != null &&
                item.resourceURI!.contains(RegExp(r'\d{4}')))
            .map((item) => item.name)
            .toList() ??
        [];

    final int filterYear = 2005;

    final List<String?> filteredComicsList = comicsList.where((comic) {
      if (comic == null) return false;

      final RegExp regex = RegExp(r'\b(\d{4})\b');
      final String? yearMatch = regex.firstMatch(comic)?.group(1);

      return yearMatch != null && int.parse(yearMatch) >= filterYear;
    }).toList();

    final List<String?> last10Comics = filteredComicsList.take(10).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 246, 246),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Center(
          child: Text(
            character.name ?? 'Marvel Character Detail',
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16),
              character.thumbnail != null
                  ? Image.network(
                      '${character.thumbnail!.path}.${character.thumbnail!.extension}',
                      height: 150,
                      width: 120,
                    )
                  : const Text('No Image Available'),
              const SizedBox(height: 16),
              Text(
                character.description ?? 'No description available.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Comics:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              if (last10Comics.isNotEmpty)
                SingleChildScrollView(
                  child: SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: last10Comics.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(last10Comics[index] ?? ''),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
