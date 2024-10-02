class CarouselModel {
  final String id;
  String title;
  String description;
  final String imageUrl;
  final int displayOrder;

  CarouselModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.displayOrder,
  });

  // toMap() method to convert the Carousel object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'displayOrder': displayOrder,
    };
  }

  // fromJson() method to convert the map to a Carousel object
  factory CarouselModel.fromJson(Map<String, dynamic> map) {
    return CarouselModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      displayOrder: map['displayOrder'],
    );
  }
}
