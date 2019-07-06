import 'package:flutter/material.dart';

void main() => runApp(RootApp());

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyApp();
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int questionIndex = 0;

  final List<Map> questionsWithAnswers = [
    {
      'questionText': 'What\'s your favorite color ?',
      'answers': ['Black', 'White', 'Red', 'Pink']
    },
    {
      'questionText': 'What\'s your favorite animal ?',
      'answers': ['Rabbit', 'Dog', 'Cat', 'Rat']
    }
  ];

  onChangedBtnPress() {
    if (questionIndex == questionsWithAnswers.length - 1) {
      setState(() {
        questionIndex = 0;
      });
    } else {
      setState(() {
        questionIndex = questionIndex + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.amberAccent),
        home: Scaffold(
          appBar: AppBar(title: Text('Hello world')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Question(
                    questionText: questionsWithAnswers[questionIndex]
                        ['questionText']),
                ...(questionsWithAnswers[questionIndex]['answers']
                        as List<String>)
                    .map((answer) => Answer(
                          questionText: answer,
                          onPressed: onChangedBtnPress,
                        ))
                    .toList()
              ],
              // map will generate the new List
              // Column can not accept the List inside the children<List>
              // or said: nested List
              // so add the spread operator in front of the answer<List>
              // It's pull the item in the answer<List> out and add to the
              // Column( children: <Widget>[ .... ] );
            ),
          ),
        ));
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question({@required this.questionText});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final String questionText;
  final Function onPressed;
  Answer({this.questionText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      child: RaisedButton(
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        child: Text(
          questionText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
