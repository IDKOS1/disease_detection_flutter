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
              centerTitle: true,
              title: Text(krName,
                style: TextStyle(color: Colors.white),
              ),
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                  )
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Image.asset(imgPath[0], width: size.width / 2.4)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(krName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26
                                    ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(enName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16,
                                    ))
                              ],),
                          )
                        ],
                      ),
                    ),
                    const Text('발병 사진',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (String img in imgPath)
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      onTap: (){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Scaffold(
                                              appBar: AppBar(
                                                backgroundColor: Colors.transparent,
                                                centerTitle: true,
                                                title: const Text('사진',
                                                  style: TextStyle(color: Colors.white,
                                                  ),
                                                ),
                                                iconTheme: const IconThemeData(color: Colors.white),
                                              ),
                                              backgroundColor: Colors.black,
                                              body: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Center(
                                                  child: SizedBox(
                                                    height: size.height,
                                                    child: InteractiveViewer(
                                                        child: Image.asset(img)
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Image.asset(img),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                    ),
                    const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('감염원',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text(infectionSrc,
                              style: const TextStyle(
                                  fontSize: 15
                              ),),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('증상',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text(symptom,
                              style: const TextStyle(
                                  fontSize: 15
                              ),),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('시기',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text(period,
                              style: const TextStyle(
                                  fontSize: 15
                              ),),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(krName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                            Text(description,
                                style: const TextStyle(
                                    fontSize: 15
                                ))
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
