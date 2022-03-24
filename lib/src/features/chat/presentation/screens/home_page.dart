import 'package:flutter/material.dart';
import 'package:my_friend/src/config/utils/friends_service.dart';
import 'package:my_friend/src/config/utils/socket_conection.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';
import 'package:my_friend/src/features/chat/presentation/components/componets.dart';
import 'package:my_friend/src/features/chat/presentation/provider/providers.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<User> friends = [];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    final socketprovider = Provider.of<SocketService>(context);

    final user = provider.user;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
              socketprovider.disconnect();
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
      body: userListView(socketprovider),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[200],
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget userListView(socketprovider) {
    return ListView.separated(
        separatorBuilder: (_, __) {
          return const Divider();
        },
        itemCount: socketprovider.friendsList.length,
        key: const Key('listviewbuilder'),
        itemBuilder: (context, i) {
          final friend = socketprovider.friendsList[i];

          return GestureDetector(
            onTap: () {
              final provider =
                  Provider.of<AuthProvider>(context, listen: false);

              Navigator.pushNamed(context, '/chat', arguments: friend);
              provider.friend = friend;
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              // padding: EdgeInsets.symmetric(vertical: 10),
              height: 50,
              child: ListTile(
                subtitle: Text('Hey how u doing?'),
                leading: CircleAvatar(
                  maxRadius: 35.0,
                  backgroundColor: Colors.purple[200],
                  child: Text(friend.name.substring(0, 2),
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
          );
        });
  }
}
