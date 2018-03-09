import "package:flutter/material.dart";
import "package:english_words/english_words.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
 
  List suggestions = new List<WordPair>();
  Set saved = new Set<WordPair>();

 Widget buildRow(WordPair pair) {
  final alreadySaved = saved.contains(pair);
  return new ListTile(
    title: new Text(
      pair.asPascalCase,
      style: new TextStyle(fontSize: 20.0)
    ),
    trailing: new Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    ),
    onTap: () {
      setState(() {
        if (alreadySaved) {
          saved.remove(pair);
        } else {
          saved.add(pair);
        }
      });
    },
  );
}

 
  Widget buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;
        if (index >= suggestions.length) {
          suggestions.addAll(generateWordPairs().take(10));
        }
        return buildRow(suggestions[index]);
      },
    );
  }

void pushSaved(){
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (context){
        
        var tiles = saved.map(
          (wordPair){
            return new ListTile(
              title: new Text(
                wordPair.asPascalCase,
                style: new TextStyle(fontSize: 20.0)
            )
          );
          }
        ); 

        var divided = ListTile.divideTiles(
          context: context, 
          tiles: tiles
          ).toList();

        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Saved Suggestions'),
            backgroundColor: Colors.blue
          ),
          body: new ListView(children: divided)
        );    
      }
    )
  );
}

 @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("StartUp Name Generator"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed:pushSaved)
        ],
      ),
      body: buildSuggestions(),
    );
  }
}
