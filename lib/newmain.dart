import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
      ),
      home: new HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Song extends StatelessWidget {
  const Song({this.title, this.album, this.author, this.likes});

  final String title;
  final String album;
  final String author;
  final int likes;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.3),
        borderRadius: new BorderRadius.circular(5.0),
      ),
      child: new IntrinsicHeight(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 10.0),
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'http://thecatapi.com/api/images/get?format=src'
                    '&size=small&type=jpg#${title.hashCode}'),
                radius: 20.0,
              ),
            ),
            new Expanded(
              child: new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(title, style: textTheme.title),
                    new Text(
                      album,
                      style: textTheme.subhead,
                    ),
                    new Text(author, style: textTheme.caption),
                  ],
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 5.0),
              child: new InkWell(
                child: new Icon(Icons.play_arrow, size: 40.0),
                onTap: () {
                  // TODO(implement)
                },
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 5.0),
              child: new InkWell(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.favorite, size: 20.0),
                    new Text('${likes ?? ''}'),
                  ],
                ),
                onTap: () {
                  // TODO(implement)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: [
        new Song(
            title: 'Heaven\'s Gate',
            album: 'Outside',
            author: 'Burna Boy',
            likes: 4),
        new Song(
            title: 'Like to Party',
            album: 'L.I.F.E',
            author: 'Burna Boy',
            likes: 23),
        new Song(
            title: 'Soke',
            album: 'On A Spaceship',
            author: 'Burna Boy',
            likes: 2),
        new Song(title: 'Ye', album: 'Outside', author: 'Burna Boy', likes: 13),
        new Song(title: 'Sekkle Down', album: 'Outside', author: 'Burna Boy'),
        new Song(title: 'On The Low', album: '2018', author: 'Burna Boy'),
        new Song(title: 'Rizzla', album: 'On A Spaceship', author: 'Burna Boy'),
      ],
    );
  }
}

class MyMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new Song(
            title: 'Heaven\'s Gate',
            album: 'Outside',
            author: 'Burna Boy',
            likes: 4),
        new Song(
            title: 'Like to Party',
            album: 'L.I.F.E',
            author: 'Burna Boy',
            likes: 23),
        new Song(
            title: 'Soke',
            album: 'On A Spaceship',
            author: 'Burna Boy',
            likes: 2),
      ],
    );
  }
}

class Shared extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        new Song(
          title: 'Sekkle Down',
          album: 'Outside',
          author: 'Burna Boy',
          likes: 15,
        ),
        new Song(
          title: 'On The Low',
          album: '2018',
          author: 'Burna Boy',
          likes: 4,
        ),
        new Song(
          title: 'Rizzla',
          album: 'On A Spaceship',
          author: 'Burna Boy',
          likes: 4,
        ),
      ],
    );
  }
}

class CustomTabBar extends AnimatedWidget implements PreferredSizeWidget {
  CustomTabBar({this.pageController, this.pageNames})
      : super(listenable: pageController);

  final PageController pageController;
  final List<String> pageNames;

  @override
  final Size preferredSize = new Size(0.0, 40.0);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return new Container(
      height: 40.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: new BoxDecoration(
        color: Colors.grey.shade800.withOpacity(0.6),
        borderRadius: new BorderRadius.circular(20.0),
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: new List.generate(pageNames.length, (int index) {
          return new InkWell(
              child: new Text(pageNames[index],
                  style: textTheme.subhead.copyWith(
                    color: Colors.white.withOpacity(
                      index == pageController.page ? 1.0 : 0.2,
                    ),
                  )),
              onTap: () {
                pageController.animateToPage(
                  index,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );
              });
        }).toList(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = new PageController(initialPage: 2);

  @override
  build(BuildContext context) {
    final Map<String, Widget> pages = <String, Widget>{
      'My Music': new MyMusic(),
      'Shared': new Shared(),
      'Feed': new Feed(),
    };
    TextTheme textTheme = Theme.of(context).textTheme;
    return new Stack(
      children: [
        new Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                const Color.fromARGB(255, 253, 72, 72),
                const Color.fromARGB(255, 87, 97, 249),
              ],
              stops: [0.0, 1.0],
            )),
            child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    'T I Z E',
                    style: textTheme.headline.copyWith(
                      color: Colors.grey.shade800.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))),
        new Scaffold(
          backgroundColor: const Color(0x00000000),
          appBar: new AppBar(
            backgroundColor: const Color(0x00000000),
            elevation: 0.0,
            leading: new Center(
              child: new ClipOval(
                child: new Image.network(
                  'http://i.imgur.com/TtNPTe0.jpg',
                ),
              ),
            ),
            actions: [
              new IconButton(
                icon: new Icon(Icons.add),
                onPressed: () {
                  //TODO: Debug this function
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text("Not Implemented Yet"),
                    action: new SnackBarAction(label: null, onPressed: null),
                    duration: Duration(minutes: 1),
                  ));
                },
              ),
            ],
            title: const Text('Sample Music'),
            bottom: new CustomTabBar(
              pageController: _pageController,
              pageNames: pages.keys.toList(),
            ),
          ),
          body: new PageView(
            controller: _pageController,
            children: pages.values.toList(),
          ),
        ),
      ],
    );
  }
}
