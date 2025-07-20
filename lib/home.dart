import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            color: Color(0xFFAAAAAA),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  "ヒーローエリア",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "ヒーローエリアのキャッチコピー。",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            color: Color(0xFFAAAAAA),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("サービスA",style: TextStyle(fontSize: 16, color: Colors.white)), 
                Text("サービスAの説明。",style: TextStyle(fontSize: 12, color: Colors.white))
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            color: Color(0xFFAAAAAA),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("サービスB",style: TextStyle(fontSize: 16, color: Colors.white)), 
                Text("サービスBの説明。",style: TextStyle(fontSize: 12, color: Colors.white))
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 100,
            color: Color(0xFFAAAAAA),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("サービスC",style: TextStyle(fontSize: 16, color: Colors.white)), 
                Text("サービスCの説明。",style: TextStyle(fontSize: 12, color: Colors.white))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
