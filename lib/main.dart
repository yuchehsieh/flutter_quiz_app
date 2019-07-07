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
  int _userScore = 0;

  final List<Map> _questionsWithAnswers = const [
    {
      'questionText': 'What\'s your favorite color ?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'White', 'score': 10},
        {'text': 'Red', 'score': 15},
        {'text': 'Pink', 'score': 8},
      ]
    },
    {
      'questionText': 'What\'s your favorite animal ?',
      'answers': [
        {'text': 'Rabbit', 'score': 15},
        {'text': 'Dog', 'score': 10},
        {'text': 'Cat', 'score': 10},
        {'text': 'Rat', 'score': 40},
      ]
    }
  ];

  void _onAnswerBtnPressed({@required int score}) {
    setState(() {
      _userScore = _userScore + score;
      _questionIndex = _questionIndex + 1;
    });
  }

  void _onResetIndex() {
    setState(() {
      _questionIndex = 0;
      _userScore = 0;
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
                  onAnswerBtnPress: _onAnswerBtnPressed)
              : Result(_onResetIndex, _userScore),
        ),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map> questionsWithAnswers;
  final int questionIndex;
  final Function onAnswerBtnPress;

  Quiz(
      {@required this.questionsWithAnswers,
      @required this.questionIndex,
      @required this.onAnswerBtnPress});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Question(
            questionText: questionsWithAnswers[questionIndex]['questionText']),
        ...(questionsWithAnswers[questionIndex]['answers'] as List<Map>)
            .map((answer) => Answer(
                questionText: answer['text'],
                onPressed: () {
                  onAnswerBtnPress(score: answer['score']);
                }))
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
  final int userScore;

  Result(this.onResetIndex, this.userScore);

  String get scoreDesc {
    String desc;
    if (userScore <= 30) {
      desc = 'You are a normal guy, you got $userScore';
    } else {
      desc = 'You ar kind of a strange person, you got $userScore';
    }
    return desc;
  }

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
        Text(scoreDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.deepOrange)),
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
