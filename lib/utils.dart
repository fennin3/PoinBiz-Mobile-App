import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class MyUtils{
  static downloadAndSaveImage(String imgUrl, imageName)async{
    var response = await http.get(Uri.parse(imgUrl));
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file = new File(join(documentDirectory.path, '$imageName.png'));
    file.writeAsBytesSync(response.bodyBytes);
  }
}