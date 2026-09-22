import 'package:http/http.dart' as http;
import 'package:youtube/model/video.dart';
import 'dart:convert';

const CHAVE_YT_API = "";
const ID_CANAL = "UCNMmnBOprYAMrU63m9urBQw";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {

    Uri url = Uri.parse(
        "${URL_BASE}search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_YT_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisa"
    );

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Video> videos = dadosJson["items"].map<Video>(
          (map){
            return Video.fromJson(map);
          }
      ).toList();
      return videos;
    } else {
      return [];
    }
  }
}