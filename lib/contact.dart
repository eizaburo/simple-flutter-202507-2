import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //pubspec.yamlにhttp追加

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  ContactState createState() => ContactState();
}

class ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //データ送信用function
  void sendContactForm(BuildContext context) async {
    final client = http.Client();
    var url = Uri.parse(
      "https://script.google.com/macros/s/AKfycbyzNZmAv5bxnw-_MF_tZ91q8uxs3AT_Uz0Qomf56EyYyLq9Qr7mFjmLPiZM4HpsWjDv/exec",
    );

    try {
      var response = await http.post(
        url,
        headers: {"Content-type": "application/x-www-form-urlencoded"},
        body: {
          "title": _titleController.text,
          "email": _emailController.text,
          "message": _messageController.text,
        },
      );

      //httpでは実行されない（リダイレクトされる）
      if (response.statusCode == 200) {
        var text = response.body;
        debugPrint(text);
      }

      //flutterのhttpはredirectに対応しておらず、独自に実装する必要がある。
      if (response.statusCode == 302) {
        String? location = response.headers['location'];
        if (location != null) {
          var redirectUrl = Uri.parse(location);
          var redirectResponse = await client.get(redirectUrl);
          //コンソールに結果表示
          debugPrint(redirectResponse.body);
          //Snack
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(redirectResponse.body)));
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      //formをクリア
      _titleController.clear();
      _emailController.clear();
      _messageController.clear();
      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            color: Color(0xFFAAAAAA),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text("お問合せフォーム", style: TextStyle(color: Colors.white)),
                Text("お気軽にお問合せ下さい。", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // title
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "お問合せタイトル",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "お問合せタイトルは必須です。";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _titleController,
                    ),
                    SizedBox(height: 30),
                    // email
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Emailは必須です。";
                        }
                        final emailRegexp = RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        );
                        if (!emailRegexp.hasMatch(value)) {
                          return "Emailを正しく入力してください。";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _emailController,
                    ),
                    SizedBox(height: 30),
                    // message
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "お問合せ内容",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "お問合せ内容は必須です。";
                        }
                        if (value.length > 10) {
                          return "10文字以下で入力して下さい。";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _messageController,
                    ),
                    SizedBox(height: 30),
                    // button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF333333),
                          foregroundColor: Color(0xFFFFFFFF),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            sendContactForm(context);
                            debugPrint("send");
                            //reset
                          }
                        },
                        child: Text("送信"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
