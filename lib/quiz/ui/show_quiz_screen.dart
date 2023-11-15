import 'package:codexia_e_learning/quiz/model/quiz_model.dart';
import 'package:codexia_e_learning/quiz/provider/quiz_provider.dart';
import 'package:codexia_e_learning/shared/colors_const.dart';
import 'package:codexia_e_learning/shared/string_const.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class ShowQuizScreen extends StatefulWidget {
  final String chapterId;

  const ShowQuizScreen({
    required this.chapterId,
    super.key,
  });

  @override
  State<ShowQuizScreen> createState() => _ShowQuizScreenState();
}

class _ShowQuizScreenState extends State<ShowQuizScreen> {
  late QuizProvider quizProvider;
  List<String> selectedOption = [];

  @override
  void initState() {
    quizProvider = Provider.of<QuizProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Show Quiz',
          style: TextStyle(
            color: ColorsConst.whiteColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsConst.whiteColor,
          ),
        ),
        backgroundColor: ColorsConst.blueColor,
      ),
      body: Consumer<QuizProvider>(builder: (create, provider, widgets) {
        return StreamBuilder(
          stream: quizProvider.quizService.getQuestionStream(widget.chapterId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Quiz> quizList = [];
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              if (dataSnapshot.exists) {
                final map = dataSnapshot.value as Map<dynamic, dynamic>;

                map.forEach((key, value) {
                  Quiz quiz = fromMap(value);
                  quizList.add(quiz);
                });
              }
              return ListView.builder(
                itemCount: quizList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Que.  ${quizList[index].question}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        RadioListTile<String>(
                          title: Text(quizList[index].optionA),
                          value: 'A',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text(quizList[index].optionB),
                          value: 'B',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text(quizList[index].optionC),
                          value: 'C',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text(quizList[index].optionD),
                          value: 'D',
                          groupValue: quizList[index].correctOption,
                          onChanged: (value) {},
                        ),
                        Text(
                          'Correct Option:  ${quizList[index].correctOption}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        );
      }),
    );
  }

  Quiz fromMap(value) {
    var quiz = Quiz(
      chapterId: value[StringConst.chapterId] ?? '',
      questionId: value[StringConst.questionId] ?? '',
      optionA: value[StringConst.optionA] ?? '',
      optionB: value[StringConst.optionB] ?? '',
      optionC: value[StringConst.optionC] ?? '',
      optionD: value[StringConst.optionD] ?? '',
      question: value[StringConst.question] ?? '',
      correctOption: value[StringConst.correctOption] ?? '',
    );
    return quiz;
  }
}
