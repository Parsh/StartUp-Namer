import "package:flutter/material.dart";
import "package:english_words/english_words.dart";

void main(){
  runApp(
    new MaterialApp(
      title: "StartUp Namer App",
      color: Colors.blue,
      home: new StartUpNamer()  
    )
  );
}

class StartUpNamer extends StatelessWidget{
  @override
  Widget build(BuildContext content){
      return new RandomWords();
  }
}

class RandomWords extends StatefulWidget{
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  @override
  Widget build(BuildContext context){

    List suggestions = new List<WordPair>();
    Set saved = new Set<WordPair>();

    Widget buildRow(WordPair wordPair){
      bool alreadySaved = saved.contains(wordPair);
      return new ListTile(
        title: new  Text(wordPair.asPascalCase, style:  new TextStyle(fontSize: 20.0)),
        trailing: new Icon(alreadySaved ? Icons.favorite: Icons.favorite_border, color: alreadySaved? Colors.red: null),
      );
    }

    Widget buildSuggestions(){
      return new ListView.builder(
        padding: new EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int i){
          if (i.isOdd) return new Divider();
          int index = i~/2;
          if (index >= suggestions.length){
            suggestions.addAll(generateWordPairs().take(10));
          }
          return buildRow(suggestions[index]);
        }
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Lets Name Your StartUp"),
        backgroundColor: Colors.blue,
      ),
      body: buildSuggestions(),
    );
  }
}