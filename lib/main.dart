import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
  List <Widget> score = [

  ];
  // List <String> questions = [
  // 'You can lead a cow down stairs but not up stairs.',
  // 'Approximately one quarter of human bones are in the feet.',
  // 'A slug\'s blood is green.',
  // ];
  // List <bool> answers = [
  //   false,
  //   true,
  //   true,
  // ];
  void cheackAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    if (userAnswer == correctAnswer){
      score.add(const Icon(Icons.check , color: Colors.green));
    }
    else{
      score.add(const Icon(Icons.close , color: Colors.red));
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
            padding:const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style:const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  cheackAnswer(true);
                  quizBrain.nextQuestion();
                  if (quizBrain.isFinished()) {
                    Alert(
                      context: context,
                      title: "Quiz finished",
                      desc: "You have Reached the end of the quiz",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Restart the quiz",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              quizBrain.reset();
                              score.clear();
                              Navigator.pop(context);
                            });
                          },
                          width: 160,
                        )
                      ],
                    ).show();
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  cheackAnswer(false);
                  quizBrain.nextQuestion();
                  if (quizBrain.isFinished()) {
                    Alert(
                      context: context,
                      title: "Quiz finished",
                      desc: "You have Reached the end of the quiz",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Restart the quiz",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              quizBrain.reset();
                              score.clear();
                              Navigator.pop(context);
                            });
                          },
                          width: 160,
                        )
                      ],
                    ).show();
                  }
                });
              },
            ),
          ),
        ),
        Row(
          children: score,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
