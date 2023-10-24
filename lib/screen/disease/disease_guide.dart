import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseGuide extends StatelessWidget {
  const DiseaseGuide({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Color> colors = [Colors.blue, Colors.red, Colors.yellow,
      Colors.green, Colors.purple, Colors.pink, Colors.orange];

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            const SliverAppBar(
              toolbarHeight: 60,
              backgroundColor: Colors.blue,
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
                title: Text('에드워드 병'),
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('imgs/sampleFish.png', width: size.width / 2.4),
                        Column(
                          children: [
                            Text('에드워드 병',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25
                                )),
                            Text('Edwardsiella piscicida')
                          ],)
                      ],
                    ),
                    Text('발병 사진',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (Color color in colors)
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: color
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                          ],
                        )
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('감염원',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text('체표, 아가미에 주로 감염되며 세균, 기생충의 2차 감염 유발',
                            style: TextStyle(
                              fontSize: 15
                            ),),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('증상',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text('복수, 간염증, 신장비대, 체색흑화',
                              style: TextStyle(
                                  fontSize: 15
                              ),),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('시기',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text('여름철 고수온기에 주로 발생하며 치어기에 치명적인 질병',
                              style: TextStyle(
                                  fontSize: 15
                              ),),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('에드워드 병',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text('비브리오병은 넙치의 연령에 관계없이 발생되며, 주로 6월부터 '
                                '10월사이에 발병하는 경향을 보이고 동절기에는 비교적 발생이 적다. '
                                '이 질병은 육상수조와 해상 가두리 양식장 어느 쪽에나 발생한다. '
                                '비브리오병에 감염된 넙치는 체색이 흑화되어 힘없이 떠다니거나 '
                                '수조바닥에 가만히 붙어 정지해 있는 개체도 볼 수 있다. 외부증상을'
                                ' 살펴보면 병어는 등 부위의 부분적 발적과 궤양 형성, 복부 측면 '
                                '충혈증상, 지느러미의 출혈, 결손, 붕괴 및 기저부의 궤양이 보인다.'
                                ' 궤양의 형태는 불규칙적이며 궤양부위는 표피에 출혈이 나타나면서 '
                                '서서히 그 면적이 커지고 중심부는 진피가 붕괴되어 근육이 노출된다.'
                                ' 그 진행이 빠를 경우에는 궤양이 깊게 나타난다. 해부해 보면 간의 '
                                '충혈과 퇴색, 복수의 고임 및 장의 점상출혈이 관찰된다. 넙치의 '
                                '비브리오병은 그다지 많이 발생되지는 않는 편이나 주로 넙치가 '
                                '스트레스를 받거나 다른 세균성, 기생충성 및 영양성 질병이 발생하게'
                                ' 되면 쉽게 감염증을 일으키는 2차 세균성 질병이다. 원인균은'
                                ' Vibrio anguillarum이다.'
                                '\n\n비브리오균은 해수중에 상존해 있는 세균이지만 단독으로는 '
                                '질병을 일으키지 않는 기회 감염적 병원세균으로서, 주로 선별이나 '
                                '이동할 경우 취급 부주의로 인하여 상처가 생기면 그 곳을 통하여 '
                                '감염이 일어나거나, 다른 질병에 의한 2차 감염으로 피해가 발생한다.'
                                '따라서 이 병을 예방하기 위해서는 사육관리시 넙치에 물리적인 '
                                '스트레스 요인을 주지 않도록 주의해야 한다. 또한 사육수조 내 '
                                '환경을 청결하게 유지하고 비타민이나 면역증강제 등을 투여하여 '
                                '항병력을 강화시켜야 한다. 발병시에는 약제감수성 시험을 하여 '
                                '효과가 있는 약제를 경구 및 약욕으로 처리하면 치료가 가능하다.')
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
