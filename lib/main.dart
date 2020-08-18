import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'QuizBrain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreChecker = [];
  QuizBrain quizBrain = QuizBrain();

  resultChecker({String valueSelected}) {
    if (valueSelected == quizBrain.getAnswer()) {
      scoreChecker.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      scoreChecker.add(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
  }

  void resetApp() {
    setState(() {
      scoreChecker = [];
    });
    quizBrain.resetQuestionNumber();
    Navigator.pop(context);
  }

  void nextQuestion() {
    if (quizBrain.checkQuestionrange()) {
      Alert(
        context: context,
        type: AlertType.info,
        title: "Quizzler",
        desc: "Thanks for playing. Click to play again ",
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => resetApp(),
            width: 120,
          )
        ],
      ).show();
    } else {
      quizBrain.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  resultChecker(valueSelected: 'true');
                  nextQuestion();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                setState(() {
                  resultChecker(valueSelected: 'false');
                  nextQuestion();
                });
              },
            ),
          ),
        ),
        Row(
          children: scoreChecker,
        )
      ],
    );
  }
}
