import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local file read/write Demo',
      home: ReadWriteFileExample(),
    );
  }
}

class ReadWriteFileExample extends StatefulWidget {
  @override
  _ReadWriteFileExampleState createState() => _ReadWriteFileExampleState();
}

class _ReadWriteFileExampleState extends State<ReadWriteFileExample> {
  final TextEditingController _textController = TextEditingController();

  static const String localFileName = 'demo_localfile.txt';
  String _localFileContent = '';
  String _localFilePath = localFileName;

  @override
  void initState() {
    super.initState();
    _readTextFromLocalFile();
    _getLocalFile.then((file) => setState(() => _localFilePath = file.path));
  }

  @override
  Widget build(BuildContext context) {
    FocusNode textFieldFocusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: Text('Local file read/write Demo'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Text('Write to local file:', style: TextStyle(fontSize: 20)),
          TextField(
              focusNode: textFieldFocusNode,
              controller: _textController,
              maxLines: null,
              style: TextStyle(fontSize: 20)),
          ButtonBar(
            children: <Widget>[
              MaterialButton(
                child: Text('Load', style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  await _readTextFromLocalFile();
                  _textController.text = _localFileContent;
                  FocusScope.of(context).requestFocus(textFieldFocusNode);
                  log('Данные подгуржены');
                },
              ),
              MaterialButton(
                child: Text('Save', style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  await _writeTextLocalFile(_textController.text);
                  _textController.clear();
                  await _readTextFromLocalFile();
                  log('Файл записан');
                },
              ),
            ],
          ),
          Divider(height: 20.0),
          Text('Local file path:',
              style: Theme.of(context).textTheme.titleLarge),
          Text(_localFilePath, style: Theme.of(context).textTheme.titleMedium),
          Divider(height: 20.0),
          Text('Local file content:',
              style: Theme.of(context).textTheme.titleLarge),
          Text(_localFileContent,
              style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Future<String> get _getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _getLocalFile async {
    final path = await _getLocalPath;
    return File('$path/$localFileName');
  }

  Future<File> _writeTextLocalFile(String text) async {
    final file = await _getLocalFile;
    return file.writeAsString(text);
  }

  Future _readTextFromLocalFile() async {
    String content;
    try {
      final file = await _getLocalFile;
      content = await file.readAsString();
    } catch (e) {
      content = 'Error loading local file^ $e';
    }
    setState(() {
      _localFileContent = content;
    });
  }
}
