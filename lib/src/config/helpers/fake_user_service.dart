import 'package:my_friend/src/features/chat/domain/entities/user.dart';

class FakeUserService {
  // DataBase Simutalion
  final List<User> _users = List.generate(
      5,
      (_) => const User(
            email: 'fakeEmail@outlook.es',
            name: 'fakeName',
            uid: 'fake123',
          ));

  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return _users;
  }
}
