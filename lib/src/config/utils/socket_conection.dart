import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_friend/src/config/helpers/save_token.dart';
import 'package:my_friend/src/config/utils/constants.dart';
import 'package:my_friend/src/config/utils/friends_service.dart';
import 'package:my_friend/src/features/chat/data/model/login_model.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;
  // List friendsList = [];

  ServerStatus get serverStatus => _serverStatus;

  final _socketResponse = StreamController<List>.broadcast();
  void Function(List) get addResponse => _socketResponse.sink.add;

  Stream<List> get getResponse => _socketResponse.stream;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() async {
    final token = await getToken();

    // Dart client
    _socket = IO.io('https://my-friend-ancerox.herokuapp.com/', {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;

      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    _socket.on('friends', (payload) {
      List friendsList = payload.map((data) {
        return UserResponse.fromJson(data);
      }).toList();

      addResponse(friendsList);

      notifyListeners();
    });
  }

  void disconnect() {
    // _socketResponse.close();

    _socket.disconnect();
  }
}
