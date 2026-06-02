import 'package:flutter/material.dart';

class SnMessagingPage extends StatefulWidget {
  const SnMessagingPage({super.key});

  @override
  State<SnMessagingPage> createState() => _SnMessagingPageState();
}

class _SnMessagingPageState extends State<SnMessagingPage> {
  final TextEditingController messageController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  List messageList = [
    {
      "message": "Halo, ada yang bisa kami bantu?",
      "isMe": false,
      "time": "09:00",
    },
    {
      "message": "Saya ingin bertanya tentang pelatihan K3 Umum",
      "isMe": true,
      "time": "09:01",
    },
    {"message": "Baik, silakan ditanyakan 😊", "isMe": false, "time": "09:02"},
  ];

  void sendMessage() {
    if (messageController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      messageList.add({
        "message": messageController.text,
        "isMe": true,
        "time": "Now",
      });
    });

    messageController.clear();

    Future.delayed(const Duration(milliseconds: 200), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,

        duration: const Duration(milliseconds: 300),

        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,

        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,

              child: Icon(Icons.support_agent, color: Colors.blue),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text("Customer Service", style: TextStyle(fontSize: 18)),

                Text(
                  "Online",

                  style: TextStyle(fontSize: 12, color: Colors.green.shade100),
                ),
              ],
            ),
          ],
        ),

        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),

          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),

      body: Column(
        children: [
          /// MESSAGE LIST
          Expanded(
            child: ListView.builder(
              controller: scrollController,

              padding: const EdgeInsets.all(16),

              itemCount: messageList.length,

              itemBuilder: (context, index) {
                final item = messageList[index];

                final isMe = item["isMe"] as bool;

                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),

                    padding: const EdgeInsets.all(14),

                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),

                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue : Colors.white,

                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),

                        topRight: const Radius.circular(18),

                        bottomLeft: Radius.circular(isMe ? 18 : 0),

                        bottomRight: Radius.circular(isMe ? 0 : 18),
                      ),

                      boxShadow: [
                        BoxShadow(blurRadius: 5, color: Colors.grey.shade300),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          item["message"],

                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,

                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.bottomRight,

                          child: Text(
                            item["time"],

                            style: TextStyle(
                              fontSize: 11,

                              color: isMe ? Colors.white70 : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// INPUT
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

            decoration: const BoxDecoration(color: Colors.white),

            child: Row(
              children: [
                /// TEXTFIELD
                Expanded(
                  child: TextField(
                    controller: messageController,

                    minLines: 1,
                    maxLines: 5,

                    decoration: InputDecoration(
                      hintText: "Tulis pesan...",

                      filled: true,
                      fillColor: Colors.grey.shade100,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),

                        borderSide: BorderSide.none,
                      ),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                /// SEND BUTTON
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blue,

                  child: IconButton(
                    onPressed: sendMessage,

                    icon: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
