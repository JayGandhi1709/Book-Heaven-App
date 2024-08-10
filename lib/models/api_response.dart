class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({required this.success, required this.message, this.data});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(T? json)? fromJsonT,
  ) =>
      ApiResponse(
        success: json['success'] as bool,
        message: json['message'] as String,
        data: json['data'] != null ? fromJsonT!(json['data']) : null,
      );

  factory ApiResponse.fromJsonList(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json.containsKey('data')
          ? (json['data'] as List).map(fromJsonT).toList() as T
          : null,
    );
  }
}
