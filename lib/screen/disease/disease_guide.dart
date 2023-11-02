import 'package:flutter/material.dart';

class DiseaseGuide extends StatelessWidget {
  final String krName;
  final String enName;
  final List<String> imgPath;
  final String infectionSrc;
  final String symptom;
  final String period;
  final String description;

  const DiseaseGuide({
    Key? key,
    required this.krName,
    required this.enName,
    required this.imgPath,
    required this.infectionSrc,
    required this.symptom,
    required this.period
    , required this.description,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Color> colors = [Colors.blue, Colors.red, Colors.yellow,
      Colors.green, Colors.purple, Colors.pink, Colors.orange];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
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
                title: Text(krName),
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(imgPath[0], width: size.width / 2.4),
                          Expanded(
                            child: Column(
                              children: [
                                Text(krName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23
                                    ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(enName)
                              ],),
                          )
                        ],
                      ),
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
                            Text(infectionSrc,
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
                            Text(symptom,
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
                            Text(period,
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
                            Text(krName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text(description)
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
