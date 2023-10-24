import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screen/disease/disease_guide.dart';

class DiseasePage extends StatelessWidget {
  const DiseasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          slivers: <Widget> [
            const SliverAppBar(
              toolbarHeight: 60,
              backgroundColor: Colors.blue,
              floating: true,
              pinned: false,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)
                )
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('질병 정보'),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  diseaseList('에드워드병', 'Edwardsiella piscicida', '', 'edward'),
                  diseaseList('비브리오병', 'Vibrio harveyi', '', 'edward'),
                  diseaseList('연쇄구균병', 'Streptococcus', '', 'edward'),
                  diseaseList('활주세균병', 'Tenacibaculum maritimum', '', 'edward'),
                  diseaseList('여윔증', 'Enteromyxum leei', '', 'edward'),
                  diseaseList('스쿠티카병', 'Miamiensis avidus', '', 'edward'),
                  diseaseList('바이러스성출혈성패혈증', 'VHSV', '', 'edward'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget diseaseList(String title, String engName,String imagePath, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Card(
          child: ListTile(
            onTap: () {
              Get.to(() => DiseaseGuide());
            },
            leading: Image.asset('imgs/sampleFish.png'),
            title: Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            subtitle: Text(engName,
              style: const TextStyle(
                  fontSize: 18
              ),),
          ),
        ),
    );
  }
}
