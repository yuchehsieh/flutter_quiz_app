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
  int _questionIndex = 0;

  final List<Map> _questionsWithAnswers = const [
    {
      'questionText': 'What\'s your favorite color ?',
      'answers': ['Black', 'White', 'Red', 'Pink']
    },
    {
      'questionText': 'What\'s your favorite animal ?',
      'answers': ['Rabbit', 'Dog', 'Cat', 'Rat']
    }
  ];

  _onChangedBtnPress() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  _onResetIndex() {
    setState(() {
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.amberAccent),
      home: Scaffold(
        appBar: AppBar(title: Text('Hello world')),
        body: Center(
          child: (_questionIndex < _questionsWithAnswers.length)
              ? Quiz(
                  questionsWithAnswers: _questionsWithAnswers,
                  questionIndex: _questionIndex,
                  onChangedBtnPress: _onChangedBtnPress)
              : Result(_onResetIndex),
        ),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map> questionsWithAnswers;
  final int questionIndex;
  final Function onChangedBtnPress;

  Quiz(
      {@required this.questionsWithAnswers,
      @required this.questionIndex,
      @required this.onChangedBtnPress});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Question(
            questionText: questionsWithAnswers[questionIndex]['questionText']),
        ...(questionsWithAnswers[questionIndex]['answers'] as List<String>)
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
    );
  }
}

class Result extends StatelessWidget {
  final Function onResetIndex;

  Result(this.onResetIndex);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'You did great',
          textAlign: TextAlign.center,
        ),
        RaisedButton(
            onPressed: onResetIndex,
            color: Theme.of(context).primaryColor,
            child: Text('Back to question 1'))
      ],
    );
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
