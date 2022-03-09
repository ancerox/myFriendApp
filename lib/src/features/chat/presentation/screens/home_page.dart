import 'package:flutter/material.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';
import 'package:my_friend/src/features/chat/presentation/components/componets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final List<User> fakeListUser = const [
    User(name: 'Winston', email: 'WinstonF@Outlook.es', uid: '123'),
    User(name: 'Samuel', email: 'Samuel@Outlook.es', uid: '1223'),
    User(name: 'Garcia', email: 'Garcia@Outlook.es', uid: '12w3'),
    User(name: 'Manuel', email: 'Manuel@Outlook.es', uid: '1233'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.exit_to_app_outlined, color: Colors.black),
        key: const Key('appbar'),
        title: const TextHomePage(text: 'name'),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.check_circle, color: Colors.green[400]),
          )
        ],
      ),
      body: userListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[200],
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget userListView() {
    return ListView.separated(
        separatorBuilder: (_, __) {
          return const Divider();
        },
        itemCount: fakeListUser.length,
        key: const Key('listviewbuilder'),
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              // Todo open Message Screen
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              // padding: EdgeInsets.symmetric(vertical: 10),
              height: 50,
              child: ListTile(
                  leading: CircleAvatar(
                    maxRadius: 35.0,
                    backgroundColor: Colors.purple[200],
                    child: Text(fakeListUser[i].name.substring(0, 2),
                        style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(fakeListUser[i].name),
                  trailing: const Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 11.0,
                  )),
            ),
          );
        });
  }
}
