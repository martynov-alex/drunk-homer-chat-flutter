import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drunk_homer_chat/constants.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // messageTextController используется для очистки строки ввода сообщения
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText = '';

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    try {
      loggedInUser = _auth.currentUser!;
    } catch (e) {
      print(e);
    }
  }

  // Так выглядет получение данных по запросу
  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  // Так выглядет подписка на обновления
  // void messagesStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('🥴📯  Drunk homer Chat'),
        backgroundColor: Color(0xFF3E9AAA),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      // Актвируем контроллер по этому полю
                      controller: messageTextController,
                      minLines: 1,
                      maxLines: 5,
                      cursorColor: Color(0xFF3E9BAA),
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Очищаем поле после отправки текста
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'time': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  MessagesStream({Key? key}) : super(key: key);

  final currentUser = loggedInUser.email;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          //.where('sender', isEqualTo: 'test@test.ru') - параметр с выборкой
          .orderBy('time', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0xFF3E9AAA),
            ),
          );
        } else if (snapshot.data != null) {
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages) {
            final messageText = message['text'];
            // Имя формирутся из почтового адреса
            final messageSender = message['sender'].split('@')[0];
            //final Timestamp messageTime = message['time'];
            final messageWidget = MessageBubble(
              sender: messageSender,
              text: messageText,
              //time: messageTime,
              isMe: currentUser == message['sender'],
            );

            messageWidgets.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              reverse: true,
              children: messageWidgets,
            ),
          );
        } else {
          return Text('Error');
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({
    required this.sender,
    required this.text,
    //required this.time,
    required this.isMe,
  });

  final String sender;
  final String text;
  //final Timestamp time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0.5),
      child: Row(
        children: [
          Chip(
            label: Text(
                '$sender', // ${DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000)}
                style: TextStyle(fontSize: 12)),
            backgroundColor: Colors.white,
            side: BorderSide(width: 1.0, color: Color(0xFFD0EDF2)),
            avatar: CircleAvatar(
              // Цвет аватара формируется из почтового адреса
              backgroundColor: Color(
                      (sender.hashCode.toInt() / 1000000000 * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
              // Буква аватара из пеовой буквы почтового адреса
              child: Text(sender.toUpperCase().substring(0, 1),
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Material(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              // Если отправитель сообщеия текущий залогиненный пользователь,
              // то его сообшения меняют цвет
              color: isMe
                  ? Color(0xFF3E9AAA).withOpacity(0.25)
                  : Color(0xFFC3B47A).withOpacity(0.25),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text('$text', style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
