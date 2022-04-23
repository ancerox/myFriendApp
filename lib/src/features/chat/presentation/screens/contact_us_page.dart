import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_friend/src/config/utils/socket_conection.dart';
import 'package:my_friend/src/features/chat/domain/entities/message.dart';
import 'package:my_friend/src/features/chat/presentation/components/componets.dart';
import 'package:my_friend/src/features/chat/presentation/provider/auth_provider.dart';
import 'package:my_friend/src/features/chat/presentation/provider/message_provider.dart';
import 'package:provider/provider.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage>
    with TickerProviderStateMixin {
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
    loadHistory('624cec81714ee6200250e87c');
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
    // final friend = Provider.of<AuthProvider>(context).friend!;
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
              TextHomePage(text: "MyFriend Contact", fontSize: 25),
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
      // animationController: _controller,
    );

    socketService.emit('direct-message', {
      "of": authProvider.user!.uid,
      "to": '624cec81714ee6200250e87c',
      "message": text
    });
    // message.animationController.forward();

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
