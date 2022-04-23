import 'package:flutter/material.dart';
import 'package:my_friend/src/config/helpers/alerts.dart';
import 'package:my_friend/src/config/utils/socket_conection.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';
import 'package:my_friend/src/features/chat/presentation/components/add_friend_alert.dart';
import 'package:my_friend/src/features/chat/presentation/components/componets.dart';
import 'package:my_friend/src/features/chat/presentation/provider/providers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<User> friends = [];

late SocketService socketprovider;
TextEditingController addFriendsController = TextEditingController();
TextEditingController contactUsEditingCtrl = TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    socketprovider = SocketService();
    super.initState();
  }

  @override
  Widget build(BuildContext buildContx) {
    final provider = Provider.of<AuthProvider>(context);
    final socketprovider = Provider.of<SocketService>(context);

    final user = provider.user;

    return StreamBuilder<Object>(
        stream: socketprovider.getResponse,
        builder: (streamBldContext, snapshot) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.5,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                    socketprovider.socket.off('disconnect');
                    provider.logUserOut();
                  },
                  icon: const Icon(Icons.logout_rounded),
                  color: Colors.red[400]),
              key: const Key('appbar'),
              title: TextHomePage(text: user!.name),
              actions: [
                Container(
                    padding: const EdgeInsets.all(10),
                    child: (socketprovider.serverStatus == ServerStatus.online)
                        ? Icon(Icons.check_circle, color: Colors.green[400])
                        : const Icon(Icons.bolt, color: Colors.red))
              ],
            ),
            body: snapshot.data != null
                ? userListView(snapshot.data, streamBldContext)
                : const Center(child: CircularProgressIndicator()),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(streamBldContext, '/contactus');
                        },
                        child: const Text('Contact US'))),
                FloatingActionButton(
                    backgroundColor: Colors.purple[200],
                    child: const Icon(Icons.add),
                    onPressed: () {
                      addFriend(streamBldContext, addFriendsController);
                    }),
              ],
            ),
          );
        });
  }

  Widget userListView(snapshot, contextt) {
    return snapshot.isEmpty
        ? Container()
        : ListView.separated(
            separatorBuilder: (_, __) {
              return const Divider();
            },
            itemCount: snapshot.length,
            key: const Key('listviewbuilder'),
            itemBuilder: (context, i) {
              final friend = snapshot[i];

              return InkWell(
                onTap: () {
                  final provider =
                      Provider.of<AuthProvider>(context, listen: false);
                  provider.friend = friend;
                  Navigator.pushNamed(
                    context,
                    '/chat',
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  // padding: EdgeInsets.symmetric(vertical: 10),
                  height: 90,
                  child: Slidable(
                    startActionPane: ActionPane(
                      dragDismissible: false,
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),
                      // dismissible: DismissiblePane(onDismissed: () {}),

                      // A pane can dismiss the Slidable.
                      children: [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                          onPressed: (_) async {
                            final provider = Provider.of<AuthProvider>(context,
                                listen: false);

                            final isFriendRemoved =
                                await provider.deleteFriend(friend.uid);

                            if (isFriendRemoved) {
                              showCustomAlert(
                                  contextt,
                                  'Friend has been removed',
                                  'You just remove ${friend.name} of your friend list');
                            } else {
                              showCustomAlert(
                                  contextt,
                                  'Theres been an error on the server',
                                  'Pleae try again');
                            }
                            setState(() {});
                          },
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          foregroundColor: Colors.white,
                          icon: Icons.delete_forever_rounded,
                          label: 'Remove',
                        ),
                        SlidableAction(
                          onPressed: (context) async {
                            final provider = Provider.of<AuthProvider>(context,
                                listen: false);

                            final isFriendRemoved =
                                await provider.deleteFriend(friend.uid);

                            if (isFriendRemoved) {
                              showCustomAlert(
                                  contextt,
                                  'This person has been blocked',
                                  'You just blocked ${friend.name} of your friend list');
                            } else {
                              showCustomAlert(
                                  contextt,
                                  'Theres been an error on the server',
                                  'Pleae try again');
                            }
                            setState(() {});
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.block,
                          label: 'Block',
                        ),
                      ],
                    ),
                    key: Key(friend.uid),
                    child: ListTile(
                      subtitle: Text(friend.email),
                      leading: CircleAvatar(
                        maxRadius: 35.0,
                        backgroundColor: Colors.purple[200],
                        child: Text(
                            friend.name.length > 2
                                ? friend.name.substring(0, 2)
                                : "GG",
                            style: const TextStyle(color: Colors.white)),
                      ),
                      title: Text(friend.name),
                      trailing: Icon(
                        Icons.circle,
                        color: friend.online ? Colors.green : Colors.red,
                        size: 11.0,
                      ),
                    ),
                  ),
                ),
              );
            });
  }

  @override
  void dispose() {
    socketprovider.dispose();
    super.dispose();
  }
}
