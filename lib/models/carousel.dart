class Carousel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int displayOrder;

  Carousel({
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
  factory Carousel.fromJson(Map<String, dynamic> map) {
    return Carousel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      displayOrder: map['displayOrder'],
    );
  }
}
