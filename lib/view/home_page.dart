import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart' as yaru;
import 'package:yaru_icons/widgets/yaru_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.themeChanged}) : super(key: key);

  final void Function(String themeName) themeChanged;

  @override
  // ignore: no_logic_in_create_state
  _HomePageState createState() => _HomePageState(themeChanged);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this.themeChanged);

  var themeName = 'Yaru-light';
  final void Function(String themeName) themeChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextButton(
            child: Icon(themeName.contains('-light')
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () => {
              setState(() {
                if (themeName.contains('-light')) {
                  themeName = 'Yaru-dark';
                } else if (themeName.contains('-dark')) {
                  themeName = 'Yaru-light';
                }
                themeChanged(themeName);
              })
            },
          ),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          closeIcon: const Icon(YaruIcons.window_close),
          image: const Icon(YaruIcons.ok_filled)
        ).show();
        quizBrain.reset();
        scoreKeeper = [];
      }
      else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(const Icon(
            YaruIcons.checkbox_button_checked,
            color: yaru.Colors.green,
          ));
        } else {
          scoreKeeper.add(const Icon(
            YaruIcons.window_close,
            color: yaru.Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
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
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: yaru.Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: yaru.Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
