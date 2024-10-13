class BookModel {
  final String id;
  final String title;
  final List<String> authors;
  final String desc;
  final List<String> img;
  final List<String> genre;
  final String language;
  final String isbn;
  final String page;
  final String publicationYear;
  final String publisher;
  final int physicalPrice;
  final int digitalPrice;
  final bool hasPhysicalCopy;
  final bool hasDigitalCopy;
  final String? pdfUrl;

  BookModel({
    required this.id,
    required this.title,
    required this.authors,
    required this.desc,
    required this.img,
    required this.genre,
    required this.language,
    required this.isbn,
    required this.page,
    required this.publicationYear,
    required this.publisher,
    required this.physicalPrice,
    required this.digitalPrice,
    required this.hasPhysicalCopy,
    required this.hasDigitalCopy,
    this.pdfUrl, // This can be null if there is no digital version
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      img: List<String>.from(json['img']),
      authors: List<String>.from(json['authors']),
      genre: List<String>.from(json['genre']),
      language: json['language'],
      isbn: json['isbn'],
      page: json['page'],
      publicationYear: json['publicationYear'].toString(),
      publisher: json['publisher'],
      physicalPrice: json['physicalPrice'],
      digitalPrice: json['digitalPrice'],
      hasPhysicalCopy: json['hasPhysicalCopy'],
      hasDigitalCopy: json['hasDigitalCopy'],
      pdfUrl: json['pdfUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors,
      'desc': desc,
      'img': img,
      'genre': genre,
      'language': language,
      'isbn': isbn,
      'page': page,
      'publicationYear': publicationYear,
      'publisher': publisher,
      'physicalPrice': physicalPrice,
      'digitalPrice': digitalPrice,
      'hasPhysicalCopy': hasPhysicalCopy,
      'hasDigitalCopy': hasDigitalCopy,
      'pdfUrl': pdfUrl,
    };
  }

  BookModel copyWith({
    String? id,
    String? title,
    List<String>? authors,
    String? desc,
    List<String>? img,
    List<String>? genre,
    int? physicalPrice,
    int? digitalPrice,
    bool? hasPhysicalCopy,
    bool? hasDigitalCopy,
    String? language,
    String? isbn,
    String? page,
    String? publicationYear,
    String? publisher,
    String? pdfUrl,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      desc: desc ?? this.desc,
      img: img ?? this.img,
      genre: genre ?? this.genre,
      physicalPrice: physicalPrice ?? this.physicalPrice,
      digitalPrice: digitalPrice ?? this.digitalPrice,
      hasPhysicalCopy: hasPhysicalCopy ?? this.hasPhysicalCopy,
      hasDigitalCopy: hasDigitalCopy ?? this.hasDigitalCopy,
      language: language ?? this.language,
      isbn: isbn ?? this.isbn,
      page: page ?? this.page,
      publicationYear: publicationYear ?? this.publicationYear,
      publisher: publisher ?? this.publisher,
      pdfUrl: pdfUrl ?? this.pdfUrl,
    );
  }
}
