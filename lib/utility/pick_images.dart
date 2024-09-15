import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<List<File>> pickMultipleImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (var file in files.files) {
        images.add(File(file.path!));
      }
    }
  } catch (e) {
    print(e);
  }
  return images;
}

// for single image
Future<File?> pickImage() async {
  File? image;
  try {
    var file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (file != null) {
      image = File(file.files.single.path!);
    }
  } catch (e) {
    print(e);
  }
  return image;
}

// for single pdf
Future<File?> pickPdf() async {
  File? pdf;
  try {
    var file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (file != null) {
      pdf = File(file.files.single.path!);
    }
  } catch (e) {
    print(e);
  }
  return pdf;
}
