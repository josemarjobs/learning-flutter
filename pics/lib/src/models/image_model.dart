class ImageModel {
  int id;
  String url;
  String title;

  ImageModel({this.id, this.url, this.title});

  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    url = parsedJson['url'];
    title = parsedJson['title'];
  }

  String toString() {
    return 'ImageModel[id: $id, title: $title, url: $url]';
  }
}