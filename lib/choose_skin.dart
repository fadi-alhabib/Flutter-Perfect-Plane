import 'package:fluppy_bird/home.dart';
import 'package:flutter/material.dart';

class Skin extends StatefulWidget {
  const Skin({Key? key}) : super(key: key);

  @override
  State<Skin> createState() => _SkinState();
}

class _SkinState extends State<Skin> {
  String? planeSkin;

  List<String> skins = [
    "assets/images/skins/plane_1/plane_1_blue.png",
    "assets/images/skins/plane_2/plane_2_blue.png",
    "assets/images/skins/plane_3/plane_3_blue.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
        ),
        child: GridView.builder(
            itemCount: skins.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, index) => buildSkinViewer(index)),
      ),
    );
  }

  String? skinColor;
  Widget buildSkinViewer(index) {
    return GestureDetector(
      onTap: () {
        skinColor = planesColorPath[index][0];

        _showDialog(index);
      },
      child: Card(
        elevation: 20,
        color: Colors.grey.shade900,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Color(0XFF24EC22), width: 6)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            child: Image.asset(
              skins[index],
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showDialog(index) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Color(0xff24EC22), width: 2)),
                title: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.clear_sharp,
                            color: Color(0xff24EC22),
                          )),
                      SizedBox(
                        width: 140,
                        height: 140,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            skinColor.toString(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ]),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  SizedBox(
                    width: 200,
                    height: 25,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index2) =>
                            buildColors(index, index2, setState),
                        separatorBuilder: (context, builder) =>
                            const SizedBox(width: 10),
                        itemCount: 4),
                  ),
                  TextButton(
                      onPressed: () {
                        planeSkin = skinColor;
                        Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      skinChanged: planeSkin,
                                    )),
                            (route) => false);
                      },
                      child: const Text(
                        "Apply Skin",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff24EC22),
                            fontFamily: "Games"),
                      ))
                ],
              );
            }));
  }

  List planesColorPath = [
    [
      "assets/images/skins/plane_1/plane_1_blue.png",
      "assets/images/skins/plane_1/plane_1_pink.png",
      "assets/images/skins/plane_1/plane_1_red.png",
      "assets/images/skins/plane_1/plane_1_yellow.png",
    ],
    [
      "assets/images/skins/plane_2/plane_2_blue.png",
      "assets/images/skins/plane_2/plane_2_green.png",
      "assets/images/skins/plane_2/plane_2_red.png",
      "assets/images/skins/plane_2/plane_2_yellow.png",
    ],
    [
      "assets/images/skins/plane_3/plane_3_blue.png",
      "assets/images/skins/plane_3/plane_3_green.png",
      "assets/images/skins/plane_3/plane_3_red.png",
      "assets/images/skins/plane_3/plane_3_yellow.png",
    ]
  ];
  List<List<dynamic>> planesColors = [
    [Colors.blue, const Color(0xffFF16D0), Colors.red, Colors.yellow],
    [Colors.blue, Colors.green, Colors.red, Colors.yellow],
    [Colors.blue, Colors.green, Colors.red, Colors.yellow]
  ];
  Widget buildColors(index, index2, setState) {
    return GestureDetector(
      onTap: () {
        setState(() {
          skinColor = planesColorPath[index][index2];
        });
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(10),
            color: planesColors[index][index2]),
      ),
    );
  }
}
