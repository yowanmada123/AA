import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  Future<File> getFileFromUrl(String url, String name) async {
    final response = await http.get(Uri.parse(url));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, name));
    file.writeAsBytesSync(response.bodyBytes);
    return file;
  }
}
