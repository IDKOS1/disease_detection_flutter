import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:untitled/class/class.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:untitled/get_controller/url_controller.dart';


class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          fetchData();
        });
      },
      child: FutureBuilder<List<Results>?>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('데이터를 가져오는 동안 오류가 발생했습니다.'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            if (data != null && data.isNotEmpty) {
              data.sort((a, b) => b.uploadDate.compareTo(a.uploadDate));
              return SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    body: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: <Widget>[
                        const SliverAppBar(
                          toolbarHeight: 60,
                          backgroundColor: Colors.blueAccent,
                          floating: true,
                          pinned: false,
                          // 스크롤을 아래로 내릴 때 AppBar를 고정
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
                                  data!.sort((a, b) =>
                                      b.uploadDate.compareTo(a.uploadDate));
                                  return Column(
                                    children: [
                                      Result(ResultData: data![index]),
                                      Divider(
                                          color: Colors.grey.withOpacity(0.3)),
                                    ],
                                  );
                                },
                                childCount: data!.length
                            )
                        )
                      ],
                    ),

                  )
              );
            } else {
              return Center(
                child: Text('업로드 기록이 없습니다.'),
              );
            }
          } else {
            return Center(
              child: Text('데이터를 불러오는중...'),
            );
          }
        },
      ),
    );
  }

  Future<List<Results>?> fetchData() async {
    final controller = UrlController();
    return await controller.loadResult();
  }
}

class Result extends StatelessWidget {
  final Results ResultData;
  const Result({required this.ResultData,super.key});
  @override
  Widget build(BuildContext context) {
    late String result;
    late Color resultColor;
    String maxValue  = '확인중';
    double maxScore = 0.00;

    if (ResultData.Edwardsiella > maxScore) {
      maxScore = ResultData.Edwardsiella;
      maxValue = '에드워드병';
    }
    if (ResultData.Vibrio > maxScore) {
      maxScore = ResultData.Vibrio;
      maxValue = '비브리오병';
    }
    if (ResultData.Streptococcus > maxScore) {
      maxScore = ResultData.Streptococcus;
      maxValue = '연쇄구균병';
    }
    if (ResultData.Tenacibaculumn > maxScore) {
      maxScore = ResultData.Tenacibaculumn;
      maxValue = '활주세균병';
    }
    if (ResultData.Enteromyxum > maxScore) {
      maxScore = ResultData.Enteromyxum;
      maxValue = '여윔증';
    }
    if (ResultData.Miamiensis > maxScore) {
      maxScore = ResultData.Miamiensis;
      maxValue = '스쿠티카병';
    }
    if (ResultData.VHSV > maxScore) {
      maxScore = ResultData.VHSV;
      maxValue = 'VHSV';
    }

    if(ResultData.isDone == false) {
      result = '결과 확인중';
      resultColor = Colors.grey;
    } else if (maxScore < 0.3) {
      result = '안전';
      resultColor = Colors.green;
    } else if (maxScore < 0.7) {
      result = '보통';
      resultColor = Colors.orange;
    } else if (maxScore <= 1){
      result = '위험';
      resultColor = Colors.red;
    } else{
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
                  Text('${ResultData.uploadDate.year - 2000}년 ${ResultData.uploadDate.month}월 ${ResultData.uploadDate.day}일'
                      ' ${ResultData.uploadDate.hour}시 ${ResultData.uploadDate.minute}분 업로드 결과',
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
              ratio: maxScore,
              direction: Axis.horizontal,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(seconds: 3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('병명: ${maxValue}'),
                  Text('${(maxScore * 100).toStringAsFixed(1)} %',
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
          Get.to(() => Detail(data: ResultData));
        }
    );
  }
}

class Detail extends StatelessWidget {
  final Results data;
  Detail({required this.data,super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
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
                              barGroups: getBarGroups(data.Edwardsiella, data.Vibrio, data.Streptococcus, data.Tenacibaculumn,
                              data.Enteromyxum, data.Miamiensis, data.VHSV),
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

List<BarChartGroupData> getBarGroups(double ed, double vi, double st, double te, double en, double mi, double vh) {
  return [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: ed*100,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: vi*100,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: st*100,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: te*100,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(
          toY: en*100,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 5,
      barRods: [
        BarChartRodData(
          toY: mi*100,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 6,
      barRods: [
        BarChartRodData(
          toY: vh*100,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
  ];
}







