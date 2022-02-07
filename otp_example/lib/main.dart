import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:otp_fields_simple/otp_fields_simple.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Form(
          key: formKey,
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 80),
              child: OtpCodeTextField(
                backgroundColor: Colors.grey.withOpacity(.1),
                cursorStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                appContext: context,
                onSubmitted: (value) {
                  print(value);
                },
                length: 4,
                //  obscureText: true,
                onTap: () {
                },
                otpTheme: OtpTheme(
                  borderRadius: BorderRadius.circular(2),
                  borderWidth: 1,
                  fieldHeight: 50,
                  fieldWidth: 50,
                ),
                cursorColor: Colors.black,
                controller: textEditingController,
                keyboardType: TextInputType.number,

                onCompleted: (v) {
                  print(v);
                },
                onChanged: (value) {
                  print(value);
                },
              )),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
