class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final String category;
  final String rating;
  final String price;
  final String language;
  final String isbn;
  final String pages;
  final String year;
  final String publisher;
  final String fileUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.price,
    required this.language,
    required this.isbn,
    required this.pages,
    required this.year,
    required this.publisher,
    required this.fileUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      rating: json['rating'],
      price: json['price'],
      language: json['language'],
      isbn: json['isbn'],
      pages: json['pages'],
      year: json['year'],
      publisher: json['publisher'],
      fileUrl: json['fileUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'rating': rating,
      'price': price,
      'language': language,
      'isbn': isbn,
      'pages': pages,
      'year': year,
      'publisher': publisher,
      'fileUrl': fileUrl,
    };
  }

  @override
  String toString() {
    return 'Book{id: $id, title: $title, author: $author, description: $description, imageUrl: $imageUrl, category: $category, rating: $rating, price: $price, language: $language, isbn: $isbn, pages: $pages, year: $year, publisher: $publisher, fileUrl: $fileUrl}';
  }

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? description,
    String? imageUrl,
    String? category,
    String? rating,
    String? price,
    String? language,
    String? isbn,
    String? pages,
    String? year,
    String? publisher,
    String? fileUrl,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      language: language ?? this.language,
      isbn: isbn ?? this.isbn,
      pages: pages ?? this.pages,
      year: year ?? this.year,
      publisher: publisher ?? this.publisher,
      fileUrl: fileUrl ?? this.fileUrl,
    );
  }
}
