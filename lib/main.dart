import "package:flutter/material.dart";
import "package:english_words/english_words.dart";

void main(){
  runApp(
    new MaterialApp(
      title: "StartUp Namer App",
      color: Colors.blue,
      home:  new StartUpNamer()  
    )
  );
}

class StartUpNamer extends StatelessWidget{
  @override
  Widget build(BuildContext content){
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Let's Name Your StartUp"),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.blue,
        body: new Container(
          child: new Center(
            child: new RandomWords()
          )
        )
      );
  }
}

class RandomWords extends StatefulWidget{
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  @override
  Widget build(BuildContext context){

    List suggestions = new List<Widget>();

    Widget buildRow(WordPair wordPair){
      return new ListTile(
        title: new  Text(wordPair.asPascalCase, style:  new TextStyle(fontSize: 20.0)),
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
        title: new Text("StatrUp Namer"),
        backgroundColor: Colors.blue,
      ),
      body: buildSuggestions(),
    );
  }
}