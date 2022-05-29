import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MuniciPalityListPage extends StatefulWidget {
  const MuniciPalityListPage({Key? key}) : super(key: key);

  @override
  State<MuniciPalityListPage> createState() => _MuniciPalityListPageState();
}

class _MuniciPalityListPageState extends State<MuniciPalityListPage> {
  HexColor forumTheme = HexColor("#3f3d56");
  List<String> fetchedMunicipalities = [
    "Rudersdal",
    "Københavns Kommune",
    "Bornholm",
    "Ærø",
    "Aalborg",
    "Odense",
    "Skagen",
    "Odsherred",
    "Ballerup"
  ];
  List<String> _currentMunicipalities = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMunicipalities();
  }

  Future<void> fetchMunicipalities() async {
    setState(() {
      _currentMunicipalities = fetchedMunicipalities;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: forumTheme,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: image(_screenHeight, _screenWidth),
              flex: 1,
            ),
            Expanded(
              child: municipalitiesList(),
              flex: 4,
            )
          ],
        ));
  }

  Widget image(double _screenHeight, double _screenWidth) {
    return Container(
      width: _screenWidth,
      height: _screenHeight * 0.2,
      decoration: BoxDecoration(
        color: forumTheme,
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: Svg("assets/municipalities.svg",
              size: Size(_screenHeight * 1, _screenWidth)),
        ),
      ),
    );
  }

  Widget municipalitiesList() {
    var _radius = Radius.circular(16);
    print("currentmun: " + _currentMunicipalities.length.toString());
    return Container(
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.only(topLeft: _radius, topRight: _radius),
            color: HexColor("fafafa")),
        child: Column(
          children: [
            searchMunicipalitiesButton(),
            SingleChildScrollView(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: _currentMunicipalities.length,
              itemBuilder: (context, i) {
                return listItem(_currentMunicipalities[i]);
              },
            )),
          ],
        ));
  }

  Widget searchMunicipalitiesButton() {
    var buttonStyle = GoogleFonts.montserrat(
        color: HexColor("fafafa"), fontSize: 18, fontWeight: FontWeight.bold);
    String searchString = "";
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 12, bottom: 24),
      child: Container(
          alignment: Alignment.center,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              color: forumTheme, borderRadius: BorderRadius.circular(12.0)),
          child: TextField(
            cursorColor: forumTheme,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: searchString.isEmpty ? "Søg Kommune" : searchString,
                //hintText: "Søg Kommune",
                hintStyle: buttonStyle,
                labelStyle: buttonStyle),
          )),
    );
  }

  Widget listItem(String txt) {
    return InkWell(
      onTap: (){
        //Maybe we should execute the flutter appauth code after navigation pop in this ontap.
        //Or the navigator pop + code is in a callback function
        //Navigator.pop(context);
      },
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12, top: 12),
          child: Container(
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
                color: forumTheme.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.0)),
            child: Text(txt,
                style: GoogleFonts.montserrat(
                    color: forumTheme,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
