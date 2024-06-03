import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPI QR Code Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QRCodeGeneratorScreen(),
    );
  }
}

class QRCodeGeneratorScreen extends StatefulWidget {
  @override
  _QRCodeGeneratorScreenState createState() => _QRCodeGeneratorScreenState();
}

class _QRCodeGeneratorScreenState extends State<QRCodeGeneratorScreen> {
  final TextEditingController _upiController = TextEditingController();
  final Set<String> _upiIds = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPI QR Code Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _upiController,
              decoration: InputDecoration(
                labelText: 'Enter UPI ID',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_upiController.text.isNotEmpty) {
                    _upiIds.add(_upiController.text);
                    _upiController.clear();
                  }
                });
              },
              child: Text('Add UPI ID and Generate QR Code'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _upiIds.map((upiId) {
                  return Column(
                    children: [
                      QrImageView(
                        data: upiId,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                      SizedBox(height: 10),
                      Text(upiId),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
