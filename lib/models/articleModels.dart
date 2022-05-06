class ArticleModel {
  late String source;
  late String description;
  late String url;
  late String image;
  late String name;

  ArticleModel(Map json) {
    source = json['source'] ?? "Something's went wrong";
    description = json['description'] ?? "Something's went wrong";
    name = json['name'] ?? "Something's went wrong";
    image = json['image'] ?? "Something's went wrong";
    url = json['url'] ?? "Something's went wrong";
  }
}
