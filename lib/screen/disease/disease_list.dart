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
          ['imgs/disease_images/Edward/image_00.png', 'imgs/disease_images/Edward/image_01.png', 'imgs/disease_images/Edward/image_02.png'],
          '수인성 감염',
          '복수, 간염증, 신장비대, 체색흑화',
          '여름철 고수온기에 주로 발생하며 치어기에 치명적인 질병',
          '병의 진행이 비교적 늦기 때문에 외관적으로 어느 정도의 특징적인 증상을 관찰할 수 있다. 본 질병이 발생되는 수조를 잘 관찰해 보면 이들 개체는 체색이 흑화되고 중앙 배수 파이프근처에서 수류를 따라 빙빙 돌거나 배수 파이프에 붙어서 죽어 있기도 한다. 외부증상으로는 지느러미 및 복부 발적 및 충혈, 복부팽만, 탈장을 보인다. 해부소견으로는 간장, 장, 복부 궤양과 악취가 나며 농이 나온다. 양어지의 보균어, 사육수 및 저질에 생존해 있는 병원균이 어류에 경구적 또는 피부나 아가미의 손상부위를 통해 감염되어 발병된다. 본 질병은 연중 발생하는 경향을 보이나 수온이 20∼30℃가 유지되는 여름철에 발생이 현저하다.\n\n에드워드병의 발생은 25℃를 넘으면 급격하게 발생율, 피해율도 함께 증가하게 됨으로 고수온기에는 저밀도로 사육하는 것과, 사육어에 가능한 물리적 스트레스를 적게 주어야 한다. 사육밀도가 낮으면 에드와드병의 발생 및 피해는 극히 적다. 고수온기에 어류의 이동을 금하고 수용 밀도를 낮게 사육하는 것이 본 병의 예방대책으로서 가장 효과적인 대처 방안이다. 치료법으로서는 분리균에 감수성 있는 약제를 선택해서 5-7일간 경구투여한다.\n\n출처: 국가수산생물질병정보(ifs.og.kr)'),
      Disease('비브리오병', 'Vibrio harveyi',
          ['imgs/disease_images/Vibrio/image_00.PNG', 'imgs/disease_images/Vibrio/image_01.PNG', 'imgs/disease_images/Vibrio/image_02.PNG', 'imgs/disease_images/Vibrio/image_03.PNG', 'imgs/disease_images/Vibrio/image_04.PNG', 'imgs/disease_images/Vibrio/image_05.PNG', 'imgs/disease_images/Vibrio/image_06.PNG'],
          '피부에 생긴 상처를 통해 감염',
          '탈장, 복부팽만, 출혈성 복수, 간ㆍ장 출혈, 비장위축 등',
          '여름철 고수온기에 주로 발생',
          '비브리오병은 넙치의 연령에 관계없이 발생되며, 주로 6월부터 10월사이에 발병하는 경향을 보이고 동절기에는 비교적 발생이 적다. 이 질병은 육상수조와 해상 가두리 양식장 어느 쪽에나 발생한다. 비브리오병에 감염된 넙치는 체색이 흑화되어 힘없이 떠다니거나 수조바닥에 가만히 붙어 정지해 있는 개체도 볼 수 있다. 외부증상을 살펴보면 병어는 등 부위의 부분적 발적과 궤양 형성, 복부 측면 충혈증상, 지느러미의 출혈, 결손, 붕괴 및 기저부의 궤양이 보인다. 궤양의 형태는 불규칙적이며 궤양부위는 표피에 출혈이 나타나면서 서서히 그 면적이 커지고 중심부는 진피가 붕괴되어 근육이 노출된다. 그 진행이 빠를 경우에는 궤양이 깊게 나타난다. 해부해 보면 간의 충혈과 퇴색, 복수의 고임 및 장의 점상출혈이 관찰된다. 넙치의 비브리오병은 그다지 많이 발생되지는 않는 편이나 주로 넙치가 스트레스를 받거나 다른 세균성, 기생충성 및 영양성 질병이 발생하게 되면 쉽게 감염증을 일으키는 2차 세균성 질병이다. 원인균은 Vibrio anguillarum이다.\n\n비브리오균은 해수중에 상존해 있는 세균이지만 단독으로는 질병을 일으키지 않는 기회 감염적 병원세균으로서, 주로 선별이나 이동할 경우 취급 부주의로 인하여 상처가 생기면 그 곳을 통하여 감염이 일어나거나, 다른 질병에 의한 2차 감염으로 피해가 발생한다. 따라서 이 병을 예방하기 위해서는 사육관리시 넙치에 물리적인 스트레스 요인을 주지 않도록 주의해야 한다. 또한 사육수조 내 환경을 청결하게 유지하고 비타민이나 면역증강제 등을 투여하여 항병력을 강화시켜야 한다. 발병시에는 약제감수성 시험을 하여 효과가 있는 약제를 경구 및 약욕으로 처리하면 치료가 가능하다.\n\n출처: 국가수산생물질병정보(ifs.og.kr)'),
      Disease('연쇄구균병', 'Streptococcus parauberis',
          ['imgs/disease_images/Streptococcus/image_00.PNG', 'imgs/disease_images/Streptococcus/image_01.PNG', 'imgs/disease_images/Streptococcus/image_02.PNG', 'imgs/disease_images/Streptococcus/image_03.PNG', 'imgs/disease_images/Streptococcus/image_04.PNG'],
          '간, 신장, 생식소, 아가미, 안구에 감염',
          '간울혈, 체색흑화, 신장비대, 아가미괴사, 안구 괴사',
          '연중 지속적으로 감염',
          '연쇄상구균 가운데 Lactococcus garvieae에 의한 감염으로 발병하는 연쇄구균병이다. 안구염 혹은 백탁, 내부장기 염증 혹은 출혈, 급성뇌수막염의 증상이 나타난다고 알려져 있다.\n\n선별, 이동, 운반 때에는 반드시 약욕해야 하며 감염균이 확인되면 약제test를 실시하여 감수성이 있는 광범위 항생제 혹은 그람양성균에 효과적인 수산용항생제를 용법과 용량에 따라 사용한다.\n\n출처: 국가수산생물질병정보(ifs.og.kr)'),
      Disease('활주세균병', 'Tenacibaculum maritimum',
          ['imgs/disease_images/Tenacibaculum/image_00.PNG', 'imgs/disease_images/Tenacibaculum/image_01.PNG', 'imgs/disease_images/Tenacibaculum/image_02.PNG', 'imgs/disease_images/Tenacibaculum/image_03.PNG', 'imgs/disease_images/Tenacibaculum/image_04.PNG'],
          '체표ㆍ아가미에 주로 감염되며 세균ㆍ기생충의 2차 감염유발',
          '체표ㆍ아가미ㆍ입술 부식, 지느러미 괴사',
          '여름철 고수온기, 겨울철 저수온기 모두 발생',
          '감염어는 체색흑화가 특징적이며 주둥이나 지느러미가 부식되고 결손 된다. 두부, 몸 및 지느러미가 붉어지고 출혈과 궤양이 생긴다. 어체의 아가미나 피부의 상처를 통해 병원균이 감염되어 발병된다. 본 감염증은 연령에 관계없이 발생되며, 연중 발생하는 경향을 보인다. 특히, 수온변화가 심한 봄과 가을에 질병 발생이 현저해진다. 양식 넙치에서는 활주세균만 단독 검출되는 경우보다 활주세균과 비브리오균, 활주세균과 트리코디나, 활주세균 및 비브리오균과 트리코디나, 활주세균 및 비브리오균과 스쿠티카충의 혼합감염 같이 활주세균감염 상태에서 그 외 세균 또는 기생충이 혼합 감염되어 있는 경우가 많다.\n\n어체에 물리적인 스트레스를 줄 경우 질병이 발생한다는 것을 예상하여, 예방대책으로서 종묘 도입 시 항생제에 의한 약욕이 일반적이다. 치료대책으로서는 항생제 약욕과 경구투여를 병용하는 것이 효과가 높다. 그리고 기생충과 혼합감염의 경우에는 우선 기생충 구제를 한 후 치료하는 것이 바람직하다. 활주세균증은 밀식을 억제하고 사육관리를 철저히 하면 피해를 줄일 수 있다.\n\n출처: 국가수산생물질병정보(ifs.og.kr)'),
      Disease('여윔증', 'Enteromyxum leei',
          ['imgs/disease_images/Enteromyxum/image_00.PNG', 'imgs/disease_images/Enteromyxum/image_01.PNG'],
          '장을 통한 감염',
          '여윔증, 숙주의 체중 감소 및 섭이 저하',
          '7-9월 중 발생(수옥 특이성 질병)',
          '여윔증은 1990년 일본의 자주복(Takifugu rubripes) 양식장에서 처음 발견되었으나, 최근에는 해산 양식 어류인 참돔(Pagrus major), 돌돔(Oplegnathus fasciatus), 넙치(Paralichthys olivaceus)등에서도 여윔 증상을 보이는 질병이 확인되어, 양식어민들에게 많은 피해가 발생하고 있다. 이 질병에 감염된 어류는 안구함몰, 두부돌출 및 어체중 감소 등의 증상을 나타내다가 폐사에 이르게 된다고 보고하였다(Tun et al., 2000). Tun et al. (2002)의 연구에 따르면, 이러한 여윔 증상을 나타내는 어류의 장에서 3종의 점액포자충이 발견되었으며, Enteromyxum fugu, Enteromyxum leei 및 Leptotheca fugu인 것으로 보고하였다. 여윔 질병의 원인은 명확하게 밝혀지지 않았지만, 앞서 동정된 점액포자충들이 한 종 또는 두 종 이상이 감염되었을 때 동일한 증상이 나타나는 것으로 확인되었다(Ogawa and Yokoyama, 2001). Yasuda et al. (2005)은 조직병리학적 분석을 통해 장 상피세포에서 다량의 포자를 관찰하였고, 상피의 탈락 및 파괴를 초래한다고 조사하였으며, 3종의 점액포자충에 대한 primers를 제작하여 PCR 방법을 사용하여 원인체를 진단하였다.\n\n제주 양식산업의 대표적 품종인 넙치는 전국 양식넙치 생산량의 50% 이상을 차지하고 국내 전체 넙치 수출량의 95% 를 점유하고 있는 실정이다. 그러나 제주 양식 넙치의 질병에 의한 연간 피해액이 700억원대에 이르며 해마다 급증하고 있다. 대표적인 폐사 원인으로는 바이러스성 질병인 viral hemorrhagic septicemia (VHS)와 기생충성 질병인 Scuticocilate가 높은 비율을 차지하고 있으며, 세균성 질병인 연쇄구균병과 에드워드병 외에도, 원인불명으로 인한 폐사가 심각한 수준인 것으로 밝혀졌다.\n\n국내의 여윔증은 2007년부터 제주도 넙치 양식장에서 약 20cm전후 크기의 넙치에서 발생하고 있으며, 1-3주 동안 발병하여 폐사를 야기시키고 있다. 일본의 자주복과는 달리, 국내 넙치의 여윔증 발병에 대한 원인은 아직 보고되어 있지 않은 상황이며, 원인불명 질병에 의한 피해를 최소화 하기 위해 신속한 진단법을 마련하여 질병이 확산되는 것을 미연에 방지하는 것은 매우 중요한 점이라 할 수 있다.\n\n출처: OAK국가리포지터리(oak.go.kr)'),
      Disease('스쿠티카병', 'Miamiensis avidus',
          ['imgs/disease_images/Miamiensis/image_00.PNG', 'imgs/disease_images/Miamiensis/image_01.PNG', 'imgs/disease_images/Miamiensis/image_02.PNG', 'imgs/disease_images/Miamiensis/image_03.PNG', 'imgs/disease_images/Miamiensis/image_04.PNG'],
          '안구ㆍ체표ㆍ아가미에 주로 기생, 체내로 침투로 최종적 뇌 도달',
          '두부 퇴색, 안구 백탁 및 돌출, 주둥이 부식, 체표 궤양, 복수',
          '치어기에 많이 감염',
          '우리나라 전 연안에서 양식되고 있는 넙치에서 대부분 표피가 박리되고 근육층이 노출되는 궤양증이 만연하고 있으며 종묘를 생산하는 종묘장에서는 두부나 체표가 하얗게 변하면서 치어가 대량폐사되는 경우가 많다. 병든 넙치는 다양한 증상을 나타내며 체표 염증, 지느러미 연조 및 꼬리자루 노출, 두부손상 (주둥이 출혈, 안구 백탁 및 돌출, 구강점막 울혈) 등이 특징적이다. 병든 넙치의 해부소견으로는 감염 부위에 따라 뇌조직의 액화성 괴사, 결합조직의 융해 및 괴사를 나타낸다. 넙치의 체표나 아가미뿐만 아니라 뇌에도 침입하여 감염을 일으키는 이 기생충은 섬모충류의 하나로 스쿠티카충목 (Scuticociliatida)에 속하는 Uronema marinum의 일종이다. 이 기생충은 방추형 또는 오이씨 모양으로 성충의 크기는 30∼45 ㎛, 자충의 크기는 18∼25 ㎛이며 번식은 단순한 2분열에 의한다. 충체의 전신에 섬모를 지녀 활발한 운동을 하며 앞측면에 세포구를 가져 이것으로 숙주세포를 활발히 섭취한다.\n\n스쿠티카병은 감염종묘를 비롯하여 환수가 좋지 못한 사육수조에 상존하는 스쿠티카충이 감염원으로 작용하여 발생한다. 예방을 위해서는 종묘장의 경우 먹이생물 배양조 내 스쿠티카충의 밀도를 낮추는 것이 중요하며 이를 위해서는 사육지 시설의 철저한 소독과 정기적인 청소를 해야하며 로티퍼를 세척 후 공급하고 착저기 이후에는 환수량의 증대 및 자치어의 주기적 검사가 필요하다. 양성장의 경우 감염 종묘의 입식을 방지하고 사육수가 정체되지 않도록 만전을 기해야 하며 중감염어는 발견 즉시 수거하도록 해야한다. 경감염어 (체표 또는 아가미에 기생된 상태)는 감염정도에 따라 기생충 구제제를 처리해야 하며 처리효과를 높이기 위해서는 약욕 후 수조를 청소하고 맑은 해수를 공급해야 한다. 그러나 뇌를 비롯한 내부기관에 기생한 스쿠티카충은 유효한 치료방법이 없다. 따라서 조기진단에 따른 조기치료로 뇌나 내부기관에 이 기생충이 감염되지 않도록 하는 것이 무엇보다 중요하다. 초기감염시 기생충 구제제 처리로 대량확산을 방지할 수 있다.\n\n출처: 국가수산생물질병정보(ifs.og.kr)'),
      Disease('바이러스성출혈성패혈증', 'VHSV',
          ['imgs/disease_images/VHSV/image_00.PNG', 'imgs/disease_images/VHSV/image_01.PNG', 'imgs/disease_images/VHSV/image_02.PNG'],
          '체표, 아가미, 지느러미를 통한 감염',
          '아가미 빈혈, 복수, 체색흑화, 간울혈, 신장 비대, 비장 비대 등',
          '저수온기에 주로 발생',
          'VHSV는 담수 연어과 어류뿐만 아니라 유럽과 북미 지역의 다양한 해산어류에서 분리되고 있다. 우리나라의 경우 2001년 이후, 겨울과 봄의 저수온기에 양식 넙치에서 VHSV에의한 피해사례가 증가하고 있다. VHSV 감염증은 체색흑화, 복수저류로 인한 복부팽만과 탈장(그림. 1), 아가미 퇴색 등이 관찰되며, 병어를 해부해 보면 복강에 맑은 복수가 차 있고 간의 충혈 현상이 나타난다(그림. 1). 개체에 따라 신장이 종대되어 있거나 회백색으로 퇴색되어 있으며, 비장은 비정상적으로 종대 되어있다. 발병 수온은 10～13℃로 넙치의 크기에 상관없이 폐사가 발생하며, 넙치 VHSV의 크기는 50×180 nm의 총알모양의 랍도바이러스이다(그림. 2). 주 감염 장기는 심장과 신장이며 이외에도 비장, 뇌, 근육, 아가미 등이다.\n\nVHSV는 1～3 × 103 uWs-1 cm-2의 UV radiation 처리에도 불활화 되며 chlorine, hypochlorite, iodophore 등과 같은 소독제에도 쉽게 불활화 되므로 양식장에서 기구와 수조를 소독해 주는 것이 효과적인 것으로 알려져 있다. 그러나 다른 바이러스성 질병과 마찬가지로 VHS를 치료하는 화학요법제는 아직까지 개발되어 있지 않다.\n\n출처: 국가수산생물질병정보(ifs.og.kr)'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: <Widget> [
              const SliverAppBar(
                toolbarHeight: 60,
                backgroundColor: Colors.blue,
                floating: true,
                pinned: false,
              centerTitle: true,
              title: Text('질병 정보',
                style: TextStyle(color: Colors.white),
              ),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)
                    )
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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                fontSize: 19
            ),
          ),
          subtitle: Text(enName,
            style: const TextStyle(
                fontSize: 17,
            ),),
        ),
      ),
    );
  }
}
