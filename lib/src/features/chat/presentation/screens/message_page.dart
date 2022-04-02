import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_friend/src/config/utils/socket_conection.dart';
import 'package:my_friend/src/features/chat/domain/entities/message.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';
import 'package:my_friend/src/features/chat/presentation/components/componets.dart';
import 'package:my_friend/src/features/chat/presentation/provider/auth_provider.dart';
import 'package:my_friend/src/features/chat/presentation/provider/message_provider.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

List<BubbleMessage> userMessages = [];

class _MessagePageState extends State<MessagePage>
    with TickerProviderStateMixin {
  late AuthProvider authProvider;
  late MessageProvider messageProvider;

  late SocketService socketService;
  late AnimationController _controller;

  final _textEdittindCtrl = TextEditingController();

  final _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    socketService = Provider.of<SocketService>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    messageProvider = Provider.of<MessageProvider>(context, listen: false);
    socketService.socket.on('direct-message', listenMessages);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    loadHistory(authProvider.friend!.uid);
    _controller.forward();
  }

  loadHistory(String userId) async {
    List<Message> messages = await messageProvider.getMessages(userId);

    final history = messages
        .map((e) => BubbleMessage(
              message: e.message,
              animationController: _controller,
              uid: e.of,
            ))
        .toList();

    setState(() {
      userMessages = history;
    });
  }

  listenMessages(payload) {
    final message = BubbleMessage(
      message: payload['message'],
      uid: payload['of'],
      animationController: _controller,
    );
    setState(() {
      userMessages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final friend = Provider.of<AuthProvider>(context).friend!;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
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
    return Container(
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: userMessages.length,
                reverse: true,
                itemBuilder: (context, i) {
                  return userMessages[i];
                }),
          ),
          const Divider(),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10),
              // color: Colors.white,
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
      ),
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
      message: text,
      uid: authProvider.user!.uid,
      animationController: _controller,
    );

    socketService.emit('direct-message', {
      "of": authProvider.user!.uid,
      "to": authProvider.friend!.uid,
      "message": text
    });

    userMessages.insert(0, message);
    message.animationController.forward();

    _textEdittindCtrl.clear();
  }

  @override
  void dispose() {
    // _controller.dispose();//
    socketService.socket.off('direct-message');
    super.dispose();
  }
}
