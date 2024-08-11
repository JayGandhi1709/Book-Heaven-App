class Book {
  final String id;
  final String title;
  final String authors;
  final String description;
  final String imageUrl;
  final String category;
  final String language;
  final String isbn;
  final String page;
  final String publicationYear;
  final String publisher;

  // Fields for handling physical and digital versions
  final int physicalPrice;
  final int digitalPrice;
  final bool hasPhysicalCopy;
  final bool hasDigitalCopy;
  final String? fileUrl; // File URL for the digital version (E-Book)

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.language,
    required this.isbn,
    required this.page,
    required this.publicationYear,
    required this.publisher,
    required this.physicalPrice,
    required this.digitalPrice,
    required this.hasPhysicalCopy,
    required this.hasDigitalCopy,
    this.fileUrl, // This can be null if there is no digital version
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      authors: json['authors'],
      description: json['desc'],
      imageUrl: json['img'],
      category: json['genre'],
      language: json['language'],
      isbn: json['isbn'],
      page: json['page'].toString(),
      publicationYear: json['publicationYear'],
      publisher: json['publisher'],
      physicalPrice: json['physicalPrice'],
      digitalPrice: json['digitalPrice'],
      hasPhysicalCopy: json['hasPhysicalCopy'],
      hasDigitalCopy: json['hasDigitalCopy'],
      fileUrl: json['pdfUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'language': language,
      'isbn': isbn,
      'page': page,
      'publicationYear': publicationYear,
      'publisher': publisher,
      'physicalPrice': physicalPrice,
      'digitalPrice': digitalPrice,
      'hasPhysicalCopy': hasPhysicalCopy,
      'hasDigitalCopy': hasDigitalCopy,
      'fileUrl': fileUrl,
    };
  }

  Book copyWith({
    String? id,
    String? title,
    String? authors,
    String? description,
    String? imageUrl,
    String? category,
    int? physicalPrice,
    int? digitalPrice,
    bool? hasPhysicalCopy,
    bool? hasDigitalCopy,
    String? language,
    String? isbn,
    String? page,
    String? publicationYear,
    String? publisher,
    String? fileUrl,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      physicalPrice: physicalPrice ?? this.physicalPrice,
      digitalPrice: digitalPrice ?? this.digitalPrice,
      hasPhysicalCopy: hasPhysicalCopy ?? this.hasPhysicalCopy,
      hasDigitalCopy: hasDigitalCopy ?? this.hasDigitalCopy,
      language: language ?? this.language,
      isbn: isbn ?? this.isbn,
      page: page ?? this.page,
      publicationYear: publicationYear ?? this.publicationYear,
      publisher: publisher ?? this.publisher,
      fileUrl: fileUrl ?? this.fileUrl,
    );
  }
}
