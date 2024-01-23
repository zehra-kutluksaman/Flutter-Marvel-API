import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class CharactersApi {
  final publicKey = "f1e779205cb18e69ae32bf882b55d045";
  final privateKey = "bd02926a3426603381dfa1ea877db6c2ddb9d007";

//Api çağrıları için Hash üretir
//Marvel API tarafından sağlanan güvenlik önlemleri için kullanılır.
  String _generateHash(String ts) {
    final String toHash = '$ts$privateKey$publicKey';
    return md5.convert(utf8.encode(toHash)).toString();
  }

// Get isteği ile Tüm karakterleri getiren bir Api çağrısı yapar.
  Future getAllCharacters() async {
    final ts = DateTime.now().millisecondsSinceEpoch;
    final hash = _generateHash('$ts');

    final Uri uri = Uri.parse(
        'https://gateway.marvel.com:443/v1/public/characters?ts=$ts&apikey=$publicKey&hash=$hash');

    print('Timestamp: $ts');
    print('Hash: $hash');

    return http.get(uri);
  }

//sonradan eklendi sayfa değişimi için 30 karakter olunca
  Future getCharactersByPage(int page, int pageSize) async {
    final ts = DateTime.now().millisecondsSinceEpoch;
    final hash = _generateHash('$ts');

    final Uri uri = Uri.parse(
      'https://gateway.marvel.com:443/v1/public/characters?ts=$ts&apikey=$publicKey&hash=$hash&offset=${page * pageSize}&limit=$pageSize',
    );

    print('Timestamp: $ts');
    print('Hash: $hash');

    return http.get(uri);
  }
}
