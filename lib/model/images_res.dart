class ImageRes {
  final String filename;
  ImageRes({
    required this.filename,
  });

  Map<String, dynamic> toMap() {
    return {
      'filename': filename,
    };
  }

  factory ImageRes.fromMap(Map<String, dynamic> map) {
    return ImageRes(
      filename: map['filename'] ?? '',
    );
  }

  @override
  String toString() {
    return 'OcrRes(filename: $filename,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageRes;
  }
}
