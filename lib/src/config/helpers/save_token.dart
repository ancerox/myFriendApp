import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

void saveToken(String token) async {
  await storage.write(key: 'token', value: token);
}

void deleteToken() async {
  await storage.delete(key: 'token');
}

Future getToken() async {
  final token = await storage.read(key: 'token');
  return token;
}
