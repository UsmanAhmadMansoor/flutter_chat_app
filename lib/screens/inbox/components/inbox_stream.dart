import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/inbox/components/chat_tile.dart';

class InboxStream extends StatefulWidget {
  final String email;
  const InboxStream(this.email, {Key? key}) : super(key: key);

  @override
  State<InboxStream> createState() => _InboxStreamState();
}

class _InboxStreamState extends State<InboxStream> {
  final _firestore = FirebaseFirestore.instance;
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').orderBy('dateTime').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data!.docs.reversed;

        // List<MessageBox> messageBoxes = [];
        List<String> emailAddress = [];
        List<String> names = [];

        for (var message in messages) {
          final msg = message.data() as Map<String, dynamic>;
          final sender = msg['email'];
          if(sender != widget.email){
            String userName = sender.toString();
            // this will remove email format from user name.
            userName = userName.substring(0,userName.indexOf('@'));
            names.add(userName);
            emailAddress.add(sender);
          }
          // final text = msg['text'];
        }
        return ListView.separated(
        itemCount: names.length,
        itemBuilder: (context, index) => ChatTile(
          names[index],
          onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen(widget.email,emailAddress[index]),
                ),
             );
          },
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        padding: const EdgeInsets.all(8.0),
      );
        // return ListView(
        //   reverse: true,
        //   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        //   children: messageBoxes,
        // );
      },
    );
  }
}
