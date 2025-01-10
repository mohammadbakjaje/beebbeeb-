import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Screens/Layout/Profile/update_image_cubit/update_Image_states.dart';
import 'package:untitled1/helper/constants.dart';
import 'package:untitled1/helper/local_network.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit() : super(UploadImageInitial());

  Future<void> uploadImage(File imageFile) async {
    emit(UploadImageLoading());
    try {
      final token = CacheNetwork.getCacheData(key: "token");
      if (token == null) {
        emit(UploadImageFailure("Token is missing"));
        return;
      }
      print(CacheNetwork.getCacheData(key: "token"));
      // إنشاء الطلب
      String base64 = base64Encode(imageFile.readAsBytesSync());
      print(base64);
      String imageName = imageFile.path.split("/").last;
      print("imageName:$imageName");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$BaseUrl/users/upload-image'),
      );

      // إضافة الـ headers
      request.headers['Authorization'] = 'Bearer $token';
      request.headers["request.headers"] = "application/json";
      // إضافة الملف
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );

      // إرسال الطلب
      var response = await request.send();

      // قراءة الاستجابة
      var responseBody = await response.stream.bytesToString();
      print("Response: $responseBody");

      // التحقق من الاستجابة
      if (response.statusCode == 200) {
        emit(UploadImageSuccess("Image uploaded successfully"));
      } else {
        emit(UploadImageFailure("Failed to upload image: $responseBody"));
      }
    } catch (e) {
      emit(UploadImageFailure("Error: $e"));
    }
  }
}
