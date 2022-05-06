import 'package:http/http.dart' as http;

String tag = "general";

class ApiService {
  static Future getNews(String tag) async {
    return await http.get(
        Uri.parse(
            "https://api.collectapi.com/news/getNews?country=tr&tag=$tag"),
        headers: {
          "authorization":
              'apikey 03HxBK31P3nYgcGmR7g3XI:7IGGkWWHcALJoZKs8TiY3D',
          "content": 'application/json'
        });
  }
}
