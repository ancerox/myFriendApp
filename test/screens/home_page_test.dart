import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_friend/src/config/helpers/fake_user_service.dart';
import 'package:my_friend/src/features/chat/domain/entities/user.dart';
import 'package:my_friend/src/features/chat/presentation/screens/screens.dart';

class MockUserSerivce extends Mock implements FakeUserService {}

void main() {
  late MockUserSerivce mockUserSerivce;

  setUp(() {
    mockUserSerivce = MockUserSerivce();
  });

  group('HomePage tests', () {
    testWidgets('AppBar HomePage', (WidgetTester tester) async {
      final appBar = find.byKey(const Key('appbar'));
      final text = find.text('Nombre');
      final icon = find.byIcon(Icons.exit_to_app_outlined);
      final isConected = find.byIcon(Icons.check_circle);

      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(appBar, findsOneWidget);
      expect(text, findsOneWidget);
      expect(icon, findsOneWidget);
      expect(isConected, findsOneWidget);
    });

    testWidgets('ShowListView with Users', (WidgetTester tester) async {
      List<User> users = const [
        User(name: 'winston', email: 'winston@outlook.es', uid: 'ase'),
        User(name: 'manuel', email: 'winston@asdoutlook.es', uid: 'ase'),
      ];

      final userList = find.byKey(const Key('listviewbuilder'));
      final count = tester.widgetList<ListView>(userList).length;

      when(() => mockUserSerivce.getUsers()).thenAnswer(
        (_) async => users,
      );
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(count, 2);
    });
  });
}
