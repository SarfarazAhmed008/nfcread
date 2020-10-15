import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: NfcScan(),
    );
  }
}

class NfcScan extends StatefulWidget {
  NfcScan({Key key}) : super(key: key);

  @override
  _NfcScanState createState() => _NfcScanState();
}

class _NfcScanState extends State<NfcScan> {
  TextEditingController writerController = TextEditingController();
  String nfcId = "";

  @override
  initState() {
    super.initState();
    writerController.text = 'Flutter NFC Scan';
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);
      print(onData.content);
      setState(() {
        writerController.text = "ID (hex): " + onData.id;
        nfcId = "ID (hex): " + onData.id;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    writerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87.withOpacity(0.8),
        title: Text("NFC Scan"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // TextField(
          //   controller: writerController,
          // ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "$nfcId",
                style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 1
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
              FlutterNfcReader.read().then((value) => {
                print(value.id),
                setState(() {
                  nfcId = "ID (hex): " + value.id;
                }),
              });
            },
          label: Text("Read"),
          icon: Icon(Icons.credit_card_outlined),
          backgroundColor: Colors.black87,
      ),
    );
  }
}