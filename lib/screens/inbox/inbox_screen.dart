import 'package:chat_app/screens/inbox/components/inbox_stream.dart';
import 'package:chat_app/screens/inbox/components/logout_button.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  final String email;
  const InboxScreen(this.email,{Key? key}) : super(key: key);

  // final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: const [LogoutButton()],
      ),
      body:SafeArea(child: InboxStream(email)),
      // ListView.separated(
      //   itemCount: 3,
      //   itemBuilder: (context, index) => ChatTile(
      //     'Name',
      //     onTap: () {
      //       //   Navigator.push(
      //       //   context,
      //       //   MaterialPageRoute(builder: (context) => const ChatScreen()),
      //       // );
      //     },
      //   ),
      //   separatorBuilder: (context, index) => const SizedBox(height: 10),
      //   padding: const EdgeInsets.all(8.0),
      // ),
    );
  }
}
