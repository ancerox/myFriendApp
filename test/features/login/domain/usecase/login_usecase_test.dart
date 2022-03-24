import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_friend/src/features/chat/domain/entities/login.dart';
import 'package:my_friend/src/features/chat/domain/repository/login_repository.dart';
import 'package:my_friend/src/features/chat/domain/usecase/login_usecase.dart';

class MockLoginRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase usecase;
  late MockLoginRepository mockLoginRepository;
  const tloginresponse =
      LoginResponse(email: 'Wins@test.com', password: '1231233');
  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = LoginUseCase(mockLoginRepository);
    registerFallbackValue(tloginresponse);
  });

  test(('Should get loginResponse from the repository'), () async {
    when(() => mockLoginRepository.login(any()))
        .thenAnswer((_) async => const Right(true));

    final result = await usecase(const Params(login: tloginresponse));

    expect(result, const Right(true));
    verify(() => mockLoginRepository.login(tloginresponse));
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
