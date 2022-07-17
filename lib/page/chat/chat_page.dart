import 'package:boilerplate_flutter/widget/base/base.dart';
import 'package:boilerplate_flutter/widget/base/chat/received_message_screen.dart';
import 'package:boilerplate_flutter/widget/base/chat/send_messsage_screen.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "Pusat Bantuan",
      body: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.person),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Selamat Datang di Pusat Bantuan KALGen Innolab').pageTitleText(),
                        Text(
                          "Jam Operasional: Senin - Minggu 07:30 - 21:00",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                      ))
                ],
              ),
              Divider()
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                SentMessageScreen(message: "Hello"),
                ReceivedMessageScreen(message: "Hi, how are you"),
                SentMessageScreen(message: "I am great how are you doing"),
                ReceivedMessageScreen(message: "I am also fine"),
                SentMessageScreen(message: "Can we meet tomorrow?"),
                ReceivedMessageScreen(message: "Yes, of course we will meet tomorrow"),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Tulis Pesan..."),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.telegram),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
