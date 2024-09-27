import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube/model/video.dart';

const String ChaveAPI = "AIzaSyBHCv43vBNOr4rjTeuzKVo2gpLyZ-F8Ovw";
const String URL_BASE = "https://www.googleapis.com/youtube/v3";
const String CHANNEL_URL = "UCuxfOdbKQy0tgGXcm9sjHiw";

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {
    // Construindo a URL da requisição
    final String url = "$URL_BASE/search"
        "?part=snippet"
        "&type=video"
        "&maxResults=10"
        "&order=date"
        "&key=$ChaveAPI"
        "&channelId=$CHANNEL_URL"
        "&q=${Uri.encodeQueryComponent(pesquisa)}";

    print("URL da requisição: $url"); // Imprimindo a URL para debug

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decodificar o JSON e mapear para uma lista de vídeos
        Map<String, dynamic> dadosJson = json.decode(response.body);
        List<Video> videos = (dadosJson["items"] as List).map((item) {
          return Video.fromJson(item);
        }).toList();
        return videos; // Retorna a lista de vídeos
      } else {
        print("Resposta da API: ${response.body}"); // Imprime a resposta da API para debug
        throw Exception("Erro ao carregar vídeos: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao chamar a API: $e"); // Imprime erros ocorridos durante a chamada da API
      throw Exception("Erro ao carregar vídeos: $e");
    }
  }
}
