import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:untitled/class/class.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';


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
    if(results != null) {
      return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                const SliverAppBar(
                  toolbarHeight: 60,
                  backgroundColor: Colors.blueAccent,
                  floating: true,
                  pinned: false, // 스크롤을 아래로 내릴 때 AppBar를 고정
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)
                      )
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text('결과 확인'),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (BuildContext context, index) {
                          results.sort((a, b) => b.date.compareTo(a.date));
                          return Column(
                            children: [
                              Result(ResultData: results[index]),
                              Divider(color: Colors.grey.withOpacity(0.3)),
                            ],
                          );
                        },
                        childCount: results.length
                    )
                )
              ],
            ),

          )
      );
    } else{
      // results가 null인 경우에 대한 처리
      return const CircularProgressIndicator();
    }
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

    return InkWell(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${ResultData.date.year - 2000}년 ${ResultData.date.month}월 ${ResultData.date.day}일'
                      ' ${ResultData.date.hour}시 ${ResultData.date.minute}분 업로드 결과',
                    style: const TextStyle(
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
            const SizedBox(height: 3,),
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
        ),
        onTap: () {
          Get.to(() => Detail());
        }
    );
  }
}

class Detail extends StatelessWidget {
  Detail({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: <Widget>[
            const SliverAppBar(
              toolbarHeight: 60,
              backgroundColor: Colors.green,
              floating: true,
              pinned: false, // 스크롤을 아래로 내릴 때 AppBar를 고정
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                  )
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('상세 정보'),
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: size.width,
                        height: size.height/2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                          child: BarChart(
                            BarChartData(
                              barTouchData: barTouchData,
                              titlesData: titlesData,
                              borderData: borderData,
                              barGroups: barGroups,
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                getDrawingHorizontalLine: (value) => FlLine(
                                    color: Colors.grey.withOpacity(0.7),
                                    strokeWidth: 0.6
                                ),
                              ),
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 100,
                            ),

                            swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                            swapAnimationCurve: Curves.linear,
                          ),
                        )
                    ),
                    const Placeholder(),
                    const Placeholder(),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

BarTouchData get barTouchData => BarTouchData(
  enabled: false,
  touchTooltipData: BarTouchTooltipData(
    tooltipBgColor: Colors.transparent,
    tooltipPadding: EdgeInsets.zero,
    tooltipMargin: 8,
    getTooltipItem: (
        BarChartGroupData group,
        int groupIndex,
        BarChartRodData rod,
        int rodIndex,
        ) {
      return BarTooltipItem(
        '${rod.toY.toStringAsFixed(1)}%',
        const TextStyle(
          color: Colors.purple,
          fontWeight: FontWeight.bold,
        ),
      );
    },
  ),
);

Widget getTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = '에드워드';
      break;
    case 1:
      text = '비브리오';
      break;
    case 2:
      text = '연쇄구균';
      break;
    case 3:
      text = '활주세균';
      break;
    case 4:
      text = '여윔증';
      break;
    case 5:
      text = '스쿠티카';
      break;
    case 6:
      text = 'VHSV';
      break;
    default:
      text = '';
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(text, style: style),
  );
}

FlTitlesData get titlesData => const FlTitlesData(
  show: true,
  bottomTitles: AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 30,
      getTitlesWidget: getTitles,
    ),
  ),
  leftTitles: AxisTitles(
    sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 35
    ),
  ),
  topTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
  rightTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
);

// 차트 구분선
FlBorderData get borderData => FlBorderData(
  show: false,
);

//차트 그라데이션
LinearGradient get _barsGradient => const LinearGradient(
  colors: [
    Colors.purple,
    Colors.cyan
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

List<BarChartGroupData> get barGroups => [
  BarChartGroupData(
    x: 0,
    barRods: [
      BarChartRodData(
        toY: 100,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 1,
    barRods: [
      BarChartRodData(
        toY: 80,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 2,
    barRods: [
      BarChartRodData(
        toY: 70,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 3,
    barRods: [
      BarChartRodData(
        toY: 55.5,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 4,
    barRods: [
      BarChartRodData(
        toY: 30,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 5,
    barRods: [
      BarChartRodData(
        toY: 20,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
  BarChartGroupData(
    x: 6,
    barRods: [
      BarChartRodData(
        toY: 0,
        gradient: _barsGradient,
      )
    ],
    showingTooltipIndicators: [0],
  ),
];







