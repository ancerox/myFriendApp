import 'package:my_friend/src/config/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../../config/usecase/usecase.dart';
import '../repository/login_repository.dart';

class ReportMsg extends UseCase<bool, String> {
  ChatRepository chatRepository;

  ReportMsg(this.chatRepository);

  @override
  Future<Either<Failure, bool>> call(String msgId) async {
    return await chatRepository.reportMsg(msgId);
  }
}
