import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            //     .orderBy(
            //   'createdAt',
            //   descending: true,
            // )
            .snapshots(),
        builder: (ctx, chatsnapshot) {
          if (!chatsnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> chatDocs = chatsnapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => MessageBubble(
              chatDocs[index]['text'],
              chatDocs[index]['username'],
              chatDocs[index]['userimage'],
              chatDocs[index]['userId'] ==
                  FirebaseAuth.instance.currentUser!.uid,
              key: ValueKey(chatDocs[index].id),
            ),
          );
        });
  }
}
