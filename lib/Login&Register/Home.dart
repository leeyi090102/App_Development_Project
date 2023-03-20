import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'ChatMessage.dart';
import 'threedots.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  OpenAI? chatGPT;
  StreamSubscription? _subscription;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    chatGPT= OpenAI.instance;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  // Link for api - https://beta.openai.com/account/api-keys

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(
      text: _controller.text,
      sender: "User",
    );

    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });

    _controller.clear();

    final request = CompleteText(
      prompt: message.text,model: kTranslateModelV3,maxTokens: 200
    );

    _subscription = chatGPT!
        .build(token: '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'
          ).onCompleteStream(request: request).listen((response){
          Vx.log(response!.choices[0].text);
          ChatMessage botMessage = 
              ChatMessage(text: response.choices[0].text, sender: "AI");

          setState(() {
            _isTyping = false;
            _messages.insertT(0, botMessage);
          });
    });



  }



  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration: const InputDecoration.collapsed(
                hintText: "Please Type anything"),
          ),
        ),
        ButtonBar(
          children: [
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _sendMessage(),
            ),
          ],
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "AI Chatting",
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                    reverse: true,
                    padding: Vx.m8,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _messages[index];
                    },
                  )),

              if(_isTyping) const ThreeDots(),

              const Divider(height: 1.0,),

              Container(
                decoration: BoxDecoration(
                  color: context.cardColor,
                ),
                child: _buildTextComposer(),
              )
            ],
          ),
        )
    );
  }
}
