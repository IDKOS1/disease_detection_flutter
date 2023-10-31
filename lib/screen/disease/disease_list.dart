import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/class/class.dart';
import 'package:untitled/screen/disease/disease_guide.dart';

class DiseasePage extends StatefulWidget {
  const DiseasePage({super.key});

  @override
  State<DiseasePage> createState() => _DiseasePageState();
}

class _DiseasePageState extends State<DiseasePage> {

  List<Disease> diseaseData = [];
  @override
  void initState(){
    super.initState();
    _fetchData();

  }

  void _fetchData() async {
    diseaseData = [
      Disease('에드워드병', 'Edwardsiella piscicida',
          ['imgs/disease_images/Edward/image_00.png', 'imgs/disease_images/Edward/01.PNG', 'imgs/disease_images/Edward/02.PNG'],
          '수인성 감염',
          '복수, 간염증, 신장비대, 체색흑화',
          '여름철 고수온기에 주로 발생하며 치어기에 치명적인 질병',
          '병의 진행이 비교적 늦기 때문에 외관적으로 어느 정도의 특징적인 증상을 관찰할 수 있다. 본 질병이 발생되는 수조를 잘 관찰해 보면 이들 개체는 체색이 흑화되고 중앙 배수 파이프근처에서 수류를 따라 빙빙 돌거나 배수 파이프에 붙어서 죽어 있기도 한다. 외부증상으로는 지느러미 및 복부 발적 및 충혈, 복부팽만, 탈장을 보인다. 해부소견으로는 간장, 장, 복부 궤양과 악취가 나며 농이 나온다. 양어지의 보균어, 사육수 및 저질에 생존해 있는 병원균이 어류에 경구적 또는 피부나 아가미의 손상부위를 통해 감염되어 발병된다. 본 질병은 연중 발생하는 경향을 보이나 수온이 20∼30℃가 유지되는 여름철에 발생이 현저하다.\n\n에드워드병의 발생은 25℃를 넘으면 급격하게 발생율, 피해율도 함께 증가하게 됨으로 고수온기에는 저밀도로 사육하는 것과, 사육어에 가능한 물리적 스트레스를 적게 주어야 한다. 사육밀도가 낮으면 에드와드병의 발생 및 피해는 극히 적다. 고수온기에 어류의 이동을 금하고 수용 밀도를 낮게 사육하는 것이 본 병의 예방대책으로서 가장 효과적인 대처 방안이다. 치료법으로서는 분리균에 감수성 있는 약제를 선택해서 5-7일간 경구투여한다.'),
      Disease('비브리오병', 'Vibrio harveyi',
          ['imgs/disease_images/Vibrio/image_00.PNG'],
          '피부에 생긴 상처를 통해 감염',
          '탈장, 복부팽만, 출혈성 복수, 간ㆍ장 출혈, 비장위축 등',
          '여름철 고수온기에 주로 발생',
          '비브리오병은 넙치의 연령에 관계없이 발생되며, 주로 6월부터 10월사이에 발병하는 경향을 보이고 동절기에는 비교적 발생이 적다. 이 질병은 육상수조와 해상 가두리 양식장 어느 쪽에나 발생한다. 비브리오병에 감염된 넙치는 체색이 흑화되어 힘없이 떠다니거나 수조바닥에 가만히 붙어 정지해 있는 개체도 볼 수 있다. 외부증상을 살펴보면 병어는 등 부위의 부분적 발적과 궤양 형성, 복부 측면 충혈증상, 지느러미의 출혈, 결손, 붕괴 및 기저부의 궤양이 보인다. 궤양의 형태는 불규칙적이며 궤양부위는 표피에 출혈이 나타나면서 서서히 그 면적이 커지고 중심부는 진피가 붕괴되어 근육이 노출된다. 그 진행이 빠를 경우에는 궤양이 깊게 나타난다. 해부해 보면 간의 충혈과 퇴색, 복수의 고임 및 장의 점상출혈이 관찰된다. 넙치의 비브리오병은 그다지 많이 발생되지는 않는 편이나 주로 넙치가 스트레스를 받거나 다른 세균성, 기생충성 및 영양성 질병이 발생하게 되면 쉽게 감염증을 일으키는 2차 세균성 질병이다. 원인균은 Vibrio anguillarum이다.\n\n비브리오균은 해수중에 상존해 있는 세균이지만 단독으로는 질병을 일으키지 않는 기회 감염적 병원세균으로서, 주로 선별이나 이동할 경우 취급 부주의로 인하여 상처가 생기면 그 곳을 통하여 감염이 일어나거나, 다른 질병에 의한 2차 감염으로 피해가 발생한다. 따라서 이 병을 예방하기 위해서는 사육관리시 넙치에 물리적인 스트레스 요인을 주지 않도록 주의해야 한다. 또한 사육수조 내 환경을 청결하게 유지하고 비타민이나 면역증강제 등을 투여하여 항병력을 강화시켜야 한다. 발병시에는 약제감수성 시험을 하여 효과가 있는 약제를 경구 및 약욕으로 처리하면 치료가 가능하다.'),
      Disease('연쇄구균병', 'Streptococcus parauberis',
          ['imgs/disease_images/Streptococcus/image_00.PNG'],
          '간, 신장, 생식소, 아가미, 안구에 감염',
          '간울혈, 체색흑화, 신장비대, 아가미괴사, 안구 괴사',
          '연중 지속적으로 감염',
          'description'),
      Disease('활주세균병', 'Tenacibaculum maritimum',
          ['imgs/disease_images/Tenacibaculum/image_00.PNG'],
          '체표ㆍ아가미에 주로 감염되며 세균ㆍ기생충의 2차 감염유발',
          '체표ㆍ아가미ㆍ입술 부식, 지느러미 괴사',
          '여름철 고수온기, 겨울철 저수온기 모두 발생',
          'description'),
      Disease('여윔증', 'Enteromyxum leei',
          ['imgs/disease_images/Enteromyxum/image_00.PNG'],
          '장을 통한 감염',
          '여윔증, 숙주의 체중 감소 및 섭이 저하',
          '7-9월 중 발생(수옥 특이성 질병)',
          'description'),
      Disease('스쿠티카병', 'Miamiensis avidus',
          ['imgs/disease_images/Miamiensis/image_00.PNG'],
          '안구ㆍ체표ㆍ아가미에 주로 기생, 체내로 침투로 최종적 뇌 도달',
          '두부 퇴색, 안구 백탁 및 돌출, 주둥이 부식, 체표 궤양, 복수',
          '치어기에 많이 감염',
          'description'),
      Disease('바이러스성출혈성패혈증', 'VHSV',
          ['imgs/disease_images/VHSV/image_00.PNG'],
          '체표, 아가미, 지느러미를 통한 감염',
          '아가미 빈혈, 복수, 체색흑화, 간울혈, 신장 비대, 비장 비대 등',
          '저수온기에 주로 발생',
          'description'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: diseaseData.length,
                      (BuildContext context, index) {
                    final disease = diseaseData[index];
                    return diseaseList(
                        disease.krName,
                        disease.enName,
                        disease.imgPath,
                        disease.infectionSrc,
                        disease.symptom,
                        disease.period,
                        disease.description
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget diseaseList(String krName, String enName, List<String> imgPath,
      String infectionSrc, String symptom, String period, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Card(
        child: ListTile(
          onTap: () {
            Get.to(() => DiseaseGuide(krName: krName, enName: enName, imgPath: imgPath,
              infectionSrc: infectionSrc, symptom: symptom,
              period: period, description: description,));
          },
          leading: Image.asset(imgPath[0], width: 100, height: 80,),
          title: Text(krName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
          subtitle: Text(enName,
            style: const TextStyle(
                fontSize: 18
            ),),
        ),
      ),
    );
  }
}
