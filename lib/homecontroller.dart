import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  File? imageBefore;
  Uint8List? imageAfter;
  final picker = ImagePicker();

  Future getImage() async {
    PickedFile? pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 300, maxWidth: 300);
    imageBefore = File(pickedFile!.path);
    update();
  }

  void uploadImage(File file) async {
    String fileName = file.path.split("/").last;
    print(fileName);
    FormData data = FormData.fromMap({
      "source_image_file":
          await MultipartFile.fromFile(file.path, filename: fileName),
    });
    Dio dio = Dio();
    var response =
        await dio.post("https://api.slazzer.com/v2.0/remove_image_background",
            data: data,
            options: Options(
              headers: {"API-KEY": "a79620467f8d406382d96e06f499d2e4"},
              responseType: ResponseType.bytes,
            ));
    print(response.data);
    print(response.headers);
    print(response.statusCode);
    print(response.runtimeType);
    imageAfter = response.data;
    update();
  }
}
