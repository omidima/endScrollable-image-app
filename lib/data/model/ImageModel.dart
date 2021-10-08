// ignore_for_file: file_names
class ImageModel {
  String id;
  String author;
  int width;
  int height;
  String url;
  String imageAddress;

  ImageModel(
      {required this.id,
      required this.author,
      required this.width,
      required this.height,
      required this.url,
      required this.imageAddress});

  factory ImageModel.getFromJson(Map json){
    return ImageModel(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      author: json['author'],
      imageAddress: "https://picsum.photos/id/${json['id']}/200/300",
      url: json["download_url"],
    );
  }
}
