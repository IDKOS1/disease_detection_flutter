import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:untitled/class/class.dart';
import 'dart:math';


class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Results> results = [];
    List<String> diseaseName = ['확인중','에드워드병', '비브리오병', '연쇄구균병', '활주세균병',
      '여윔증', '스쿠티카병', 'VHSV'];

      final random = Random();
      late String disease;

      // 테스트 Result 값 랜덤 생성
      for(int i = 0; i < 25; i++) {
        int randomInt = random.nextInt(1000);
        double randomDouble = randomInt / 1000;
        DateTime start = DateTime(2022, 1, 1);
        DateTime end = DateTime.now();
        Duration difference = end.difference(start);

        Duration randomDuration = Duration(seconds: random.nextInt(difference.inSeconds));
        DateTime randomDate = start.add(randomDuration);

        bool result;
        if(randomInt%5 != 0){
          result = true;
          disease = diseaseName[randomInt%7+1];
        } else{
          result = false;
          randomDouble = 0;
          disease = diseaseName[0];
        }

        results.add(Results(date:randomDate, result:result, percent:randomDouble, disease: disease));
      }



    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('결과 확인'),
            centerTitle: true,
            backgroundColor: Colors.blue.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
            ),
          ),
          body: ListView.builder(
            itemCount: results.length,
              itemBuilder: (BuildContext context, int index) {
                results.sort((a, b) => b.date.compareTo(a.date)); // 날자순 정리
                return Column(
                    children: [
                      Result(ResultData: results[index]),
                      Divider(color: Colors.grey.withOpacity(0.3)),
                    ]
                );
              }
          ),
        )
    );
  }

}

class Result extends StatelessWidget {
  final Results ResultData;
  const Result({required this.ResultData,super.key});
  @override
  Widget build(BuildContext context) {
    late String result;
    late Color resultColor;
    late double value;

    if(ResultData.percent == 0) {
      value = 0;
      result = '결과 확인중';
      resultColor = Colors.grey;
    } else if (ResultData.percent < 0.3) {
      value = ResultData.percent;
      result = '안전';
      resultColor = Colors.green;
    } else if (ResultData.percent < 0.7) {
      value = ResultData.percent;
      result = '보통';
      resultColor = Colors.orange;
    } else if (ResultData.percent <= 1){
      value = ResultData.percent;
      result = '위험';
      resultColor = Colors.red;
    } else{
      value = 0;
      result = 'error';
      resultColor = Colors.grey;
    }


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${ResultData.date.year - 2000}년 ${ResultData.date.month}월 ${ResultData.date.day}일'
                  ' ${ResultData.date.hour}시 ${ResultData.date.minute}분 업로드 결과',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),),
              Text(result,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: resultColor,
                    //decoration: TextDecoration.underline,
                    decorationColor: resultColor,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: 2
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 3,),
        SimpleAnimationProgressBar(
          height: 4,
          width: 370,
          backgroundColor: Colors.grey.shade300,
          foregrondColor: resultColor,
          ratio: value,
          direction: Axis.horizontal,
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(seconds: 3),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('병명: ${ResultData.disease}'),
              Text('${(value * 100).toStringAsFixed(1)} %',
              style: TextStyle(
                color: resultColor,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ],
          ),
        )
      ],
    );
  }
}

