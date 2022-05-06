class ArticleModel {
  late String source;
  late String description;
  late String url;
  late String image;
  late String name;

  ArticleModel(Map json) {
    source = json['source'] ?? "Bir sorun oluştu";
    description = json['description'] ?? "Bir sorun oluştu";
    name = json['name'] ?? "Bir sorun oluştu";
    image = json['image'] ?? "Bir sorun oluştu";
    url = json['url'] ?? "Bir sorun oluştu";
  }
}
