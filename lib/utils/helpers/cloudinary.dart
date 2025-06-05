import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future<String?> uploadImageToCloudinary() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile == null) return null;

  final cloudName = 'dmhh6yhti';
  final uploadPreset = 'user_profile';
  final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = uploadPreset
    ..files.add(await http.MultipartFile.fromPath('file', pickedFile.path));
  final response = await request.send();

  if (response.statusCode != 200) return null;
  final resStr = await response.stream.bytesToString();
  final data = json.decode(resStr);
  return data['secure_url'];
}