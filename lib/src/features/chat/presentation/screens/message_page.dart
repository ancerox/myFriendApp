import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_friend/src/features/chat/presentation/components/componets.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

List<BubbleMessage> userMessages = [
  // BubbleMessage(message: 'Como estas', uid: '123'),
  // BubbleMessage(message: 'hey', uid: '123'),
  // BubbleMessage(message: 'Para donde vas', uid: '1223'),
  // BubbleMessage(message: 'Hoy no voy a ', uid: '123'),
  // BubbleMessage(message: 'ah tato', uid: '1223'),
];

class _MessagePageState extends State<MessagePage>
    with TickerProviderStateMixin {
  final _textEdittindCtrl = TextEditingController();

  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              const TextHomePage(text: 'name', fontSize: 25),
              Text(
                'offline',
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
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
    );
    userMessages.insert(0, message);
    message.animationController.forward();

    _textEdittindCtrl.clear();
  }
}
