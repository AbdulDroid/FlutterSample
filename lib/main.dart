import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/cupertino.dart";
/*import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';*/

void main() => runApp(Chatty());

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch:  Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.orangeAccent[400],
);

class Chatty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Chatty",
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      home: new Chat(),
    );
  }
}

class Chat extends StatefulWidget {
  @override
  State createState() => new ChatState();
}

class ChatState extends State<Chat> with TickerProviderStateMixin {
  final List<ChatMessage> _message = <ChatMessage>[];
  final TextEditingController _tController = new TextEditingController();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Chatty"),
      elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _message[index],
                itemCount: _message.length,
              ),
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTComposer(),
            )
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS  ?
        new BoxDecoration(
          border: new Border(
            top: new BorderSide(color: Colors.green[200]),
          )
        ) : null,
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _message)
      message.animationController.dispose();
    super.dispose();
  }

  Widget _buildTComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                      controller: _tController,
                      onChanged: (String text) {
                        setState(() {
                          _isComposing = text.length > 0;
                        });
                      },
                      maxLines: null,
                      onSubmitted: _handleSubmitted,
                      decoration: new InputDecoration.collapsed(
                          hintText: "Send a message")),
                ),
                new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 4.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS ?
                  new CupertinoButton(child: new Text("Send"),
                      onPressed: _isComposing ? () => _handleSubmitted(_tController.text) : null,) :
                  new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: _isComposing ? () => _handleSubmitted(_tController.text) : null,),
                )
              ],
            )));
  }

  void _handleSubmitted(String text) {
    _tController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _message.insert(0, message);
    });
    message.animationController.forward();
  }
}

const String _name = "Abdul";

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(child: new Text(_name[0])),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(_name, style: Theme.of(context).textTheme.subhead),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(text),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}

/*
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Chatty"),
        ),
        body: new Container(
          child: new FutureBuilder<List<User>>(
            future: fetchUsers(),
              builder: (context, snapshot) {
              if(snapshot.hasData) {
                return new ListView.builder(
                  itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                    return new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(snapshot.data[index].name,
                        style: new TextStyle(fontWeight: FontWeight.bold),),
                        new Divider()
                      ],
                    );
                    });
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }

              return new CircularProgressIndicator();
              }),
        ),
      ),
    );
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get('https://api.github.com/users');
    print(response.body);
    List responseJson = json.decode(response.body.toString());
    List<User> userList = createUserList(responseJson);
    return userList;
  }

  List<User> createUserList(List data) {
    List<User> list = new List();
    for (int i = 0; i < data.length; i++) {
      String title = data[i]["login"];
      int id = data[i]["id"];
      User user = new User(
        name: title,
        id: id
      );
      list.add(user);
    }
    return list;
  }
}

class User {
  String name;
  int id;

  User ({this.name, this.id});
}
*/
