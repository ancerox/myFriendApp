import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_friend/src/config/helpers/alerts.dart';
import 'package:my_friend/src/config/utils/screen_size.dart';
import 'package:my_friend/src/features/chat/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../provider/message_provider.dart';

class BubbleMessage extends StatefulWidget {
  final String? id;
  final String message;
  final String uid;
  final Function setState;

  const BubbleMessage({
    Key? key,
    this.id,
    required this.setState,
    required this.message,
    required this.uid,
  }) : super(key: key);

  @override
  State<BubbleMessage> createState() => _BubbleMessageState();
}

class _BubbleMessageState extends State<BubbleMessage>
    with TickerProviderStateMixin {
  @override
  Widget build(contextet) {
//     late AnimationController _controller;
//  _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     )..forward();

    final messagePrvider =
        Provider.of<MessageProvider>(contextet, listen: true);

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        alignment: Alignment.centerRight,
        customButton: _myMessage(contextet),
        customItemsIndexes: const [2],
        customItemsHeight: 8,
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) async {
          onChanged(contextet, value as MenuItem, widget.id!, messagePrvider);
        },
        itemHeight: 48,
        itemPadding: const EdgeInsets.only(left: 16, right: 16),
        dropdownWidth: 160,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.redAccent,
        ),
        openWithLongPress: true,
        dropdownElevation: 8,
        offset: const Offset(0, 8),
      ),
    );
  }

  Widget _myMessage(buildcontext) {
    final authProvider = Provider.of<AuthProvider>(buildcontext, listen: false);

    return Align(
      alignment: widget.uid == authProvider.user!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(11),
        margin: EdgeInsets.only(
          right: widget.uid == authProvider.user!.uid
              ? 10
              : SizeConfig.widthSize(buildcontext, 20),
          bottom: 10,
          left: widget.uid == authProvider.user!.uid
              ? SizeConfig.widthSize(buildcontext, 29)
              : 20,
        ),
        decoration: BoxDecoration(
          gradient: widget.uid == authProvider.user!.uid
              ? const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffff512f),
                    Color(0xffdd2476),
                  ],
                )
              : null,
          color:
              widget.uid == authProvider.user!.uid ? Colors.red : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget.message,
          style: GoogleFonts.openSans(
              color: Colors.white, textStyle: const TextStyle(fontSize: 17)),
        ),
      ),
    );
  }

  Future<void> onChanged(BuildContext buildcontext, MenuItem item,
      String messageId, messagePrvider) async {
    switch (item) {
      case MenuItems.remove:
        await messagePrvider.deleteMessage(messageId);
        messagePrvider.userMessages
            .removeWhere((message) => message.id == messageId);
        widget.setState();
        break;
      case MenuItems.report:
        final data = await messagePrvider.reportMsg(messageId);
        if (data) {
          showCustomAlert(buildcontext, 'You just report a message',
              'Within 24 hours the content will be reviewed and action will be taken');
        } else {
          showCustomAlert(
              buildcontext, 'Error in the server', 'Please try Again');
        }
        break;
    }
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [remove, report];

  static const remove =
      MenuItem(text: 'Remove', icon: Icons.remove_circle_outline);
  static const report = MenuItem(text: 'report', icon: Icons.report);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
