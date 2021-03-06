import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_friend/src/config/utils/socket_conection.dart';
import 'package:my_friend/src/features/chat/domain/entities/message.dart';
import 'package:my_friend/src/features/chat/presentation/components/componets.dart';
import 'package:my_friend/src/features/chat/presentation/provider/auth_provider.dart';
import 'package:my_friend/src/features/chat/presentation/provider/message_provider.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late AuthProvider authProvider;
  late MessageProvider messageProvider;

  late SocketService socketService;

  final _textEdittindCtrl = TextEditingController();

  final _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    socketService = Provider.of<SocketService>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    messageProvider = Provider.of<MessageProvider>(context, listen: false);
    socketService.socket.on('direct-message', listenMessages);
    loadHistory(authProvider.friend!.uid);
  }

  callBack() {
    setState(() {});
  }

  loadHistory(String userId) async {
    List<Message> messages = await messageProvider.getMessages(userId);

    final history = messages
        .map((e) => BubbleMessage(
              setState: callBack,
              id: e.id,
              message: e.message,
              uid: e.of,
            ))
        .toList();

    setState(() {
      messageProvider.userMessages = history;
    });
  }

  listenMessages(payload) {
    final message = BubbleMessage(
      setState: callBack,
      message: payload['message'],
      uid: payload['of'],
    );
    setState(() {
      messageProvider.userMessages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final friend = Provider.of<AuthProvider>(context, listen: true).friend!;
    // print(friend);

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                messageProvider.userMessages.clear();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              TextHomePage(text: friend.name, fontSize: 25),
              Text(
                friend.online ? 'Online' : 'Offline',
                style: TextStyle(color: Colors.grey[400], fontSize: 15),
              ),
            ],
          ),
        ),
        body: _body());
  }

  Widget _body() {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
              itemCount: messageProvider.userMessages.length,
              reverse: true,
              itemBuilder: (context, i) {
                return messageProvider.userMessages[i];
              }),
        ),
        // const Divider(),
        SafeArea(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  spreadRadius: 0.1,
                  offset: Offset(0, 0))
            ]),
            padding: const EdgeInsets.all(10),
            height: 50,
            child: Row(
              children: [
                _textImput(),
                _sendButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Flexible _textImput() {
    return Flexible(
      child: TextField(
        // autofocus: true,
        onChanged: (text) {
          setState(() {});
        },
        controller: _textEdittindCtrl,
        onSubmitted: _handleSummit,
        focusNode: _focusNode,
        decoration:
            const InputDecoration.collapsed(hintText: 'Write a message'),
      ),
    );
  }

  Container _sendButton() {
    return Container(
      child: Platform.isIOS
          ? TextButton(
              onPressed: _textEdittindCtrl.text.isNotEmpty
                  ? () => _handleSummit(_textEdittindCtrl.text)
                  : null,
              child: const Text('Send'),
            )
          : IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: _textEdittindCtrl.text.isNotEmpty
                  ? () => _handleSummit(_textEdittindCtrl.text)
                  : null,
              icon: Icon(
                Icons.send,
                color: _textEdittindCtrl.text.isNotEmpty
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
    );
  }

  _handleSummit(String text) {
    _focusNode.requestFocus();
    setState(() {});
    if (text.isEmpty) return;

    final message = BubbleMessage(
      setState: callBack,
      id: text.hashCode.toString(),
      message: text,
      uid: authProvider.user!.uid,
    );

    socketService.emit('direct-message', {
      "of": authProvider.user!.uid,
      "to": authProvider.friend!.uid,
      "message": text
    });

    loadHistory(authProvider.friend!.uid);

    messageProvider.userMessages.insert(0, message);

    _textEdittindCtrl.clear();
  }

  @override
  void dispose() {
    // _controller.dispose();//
    socketService.socket.off('direct-message');
    super.dispose();
  }
}
