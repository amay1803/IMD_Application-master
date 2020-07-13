import 'dart:io';
import 'package:flutter/material.dart';
import 'package:imd_weather/widgets/Animation.dart';
import '../services/ApiCall.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:imd_weather/values/MyColors.dart';

void main() => runApp(Warnings());

class Warnings extends StatefulWidget {
  @override
  _Warnings createState() => _Warnings();
}

class _Warnings extends State<Warnings> {
  String urlDfPath = ""; //url for District forecast
  String urlRfPath = ""; //url for Regional forecast
  bool rfReady = false;
  bool dfReady = false;

  @override
  void initState() {
    fetch();
    super.initState();
  }

  void fetch() async {
    PDFData urls = new PDFData();
    await urls.getURLs();

    getFromUrl(urls.districtURL, 0).then((f) {
      setState(() {
        urlDfPath = f.path;
        //print(urlDfPath);
        rfReady = true;
      });
    });

    getFromUrl(urls.regionURL, 1).then((f) {
      setState(() {
        urlRfPath = f.path;
        //print(urlRfPath);
        dfReady = true;
      });
    });
  }

  Future<File> getFromUrl(String url, int op) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file;
      switch (op) {
        case 0:
          file = File("${dir.path}/DistrictForecast.pdf"); //DF
          break;
        case 1:
          file = File("${dir.path}/RegionalForecast.pdf"); //RF
          break;
        default:
      }
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error" + e);
    }
  }
  // List<String> header=[
  //   "Regional Meteorological Centre",
  //   "Mumbai",
  //   "(Ministry of Earth Science)"
  // ];

  @override
  Widget build(BuildContext context) {
    bool flag = rfReady && dfReady ? true : false;
    return Scaffold(
      appBar: AppBar(


        
      flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0x00008b), Color(0xffB1ADE2)])),
                                                //   colors: [Color(0x00008b), Color(0xffB1ADE2)]
                                                //colors: [Color(0x00008b), Color(0xffB1ADE2)]
                                                //[Color(0x00008b), Color(0xdd74ebd5)]    0xffd7d7ff
                ),
       
           title: Text("Warnings",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
            ),
           ),
        
      ),

  
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00008b), Color(0xffB1ADE2)])),
        // colors: [Color(0xdd74ebd5), Color(0xffacb6e5)])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            flag
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Column(
                        children: <Widget>[
                          Container(
                              // padding: EdgeInsets.all(20.0),
                              margin: EdgeInsets.all(20.0),
                              width: 150,
                              height: 150,
                              child: Image.asset('assets/images/imd_logo.png')),
                          Text("Regional Meteorological Centre",
                              style: TextStyle(
                                  color: MyColors.main_black,
                                  fontFamily: 'OpenSans Light',
                                  fontSize: 20.0)),
                          Text("Mumbai",
                              style: TextStyle(
                                  color: MyColors.main_black,
                                  fontFamily: 'OpenSans Light',
                                  fontSize: 20.0)),
                          Text("(Ministry of Earth Science)",
                              style: TextStyle(
                                  color: MyColors.main_black,
                                  fontFamily: 'OpenSans Light',
                                  fontSize: 15.0)),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      ForecastButton(
                          urlDfPath: urlDfPath,
                          title: 'District Forecast & Warnings'),
                      SizedBox(height: 40.0),
                      ForecastButton(
                          urlDfPath: urlRfPath,
                          title: 'Regional Forecast & Warnings'),
                    ],
                  )
                : Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}

class ForecastButton extends StatelessWidget {
  const ForecastButton({
    Key key,
    @required this.urlDfPath,
    this.title,
  }) : super(key: key);
  final String title;
  final String urlDfPath;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(title),
      color: Color(0xffd7d7ff),
      
      
      // colors: [Color(0xdd74ebd5), Color(0xffacb6e5)]
      textColor: Colors.black,
      elevation: 5.0,
      splashColor: Colors.blue,
      highlightColor: Colors.lightBlueAccent,
      onPressed: () async {
        if (urlDfPath != null) {
          await Future.delayed(Duration(milliseconds: 150));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PdfViewPage(path: urlDfPath, title: title)));
        }
      },
      
    );

  
  }
}

class PdfViewPage extends StatefulWidget {
  final String path;
  final String title;
  const PdfViewPage({
    Key key,
    @required this.title,
    @required this.path,
  }) : super(key: key);

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;

  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xdd74ebd5),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0x00008b), Color(0xffB1ADE2)])),
                                                //   colors: [Color(0x00008b), Color(0xffB1ADE2)]
                                                //colors: [Color(0x00008b), Color(0xffB1ADE2)]
                                                //[Color(0x00008b), Color(0xdd74ebd5)]
                ),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
       // backgroundColor: Color(0xdd74ebd5),
      ),
      body: Stack(
        children: <Widget>[
          FadeAnimation(
            delay: 1.5,
            child: PDFView(
              filePath: widget.path,
              autoSpacing: false,
              enableSwipe: true,
              pageSnap: true,
              onError: (e) {
                print(e);
              },
              onRender: (_pages) {
                setState(() {
                  _totalPages = _pages;
                  pdfReady = true;
                });
              },
              onViewCreated: (PDFViewController vc) {
                _pdfViewController = vc;
              },
              onPageChanged: (int page, int total) {
                setState(() {});
              },
              onPageError: (page, e) {
                print(e);
              },
            ),
          ),

          // !pdfReady
          //     ? Center(
          //         child: FutureBuilder(
          //           future: Future.delayed(Duration(seconds: 2)),
          //           builder: (context, snapshot) {
          //             return CircularProgressIndicator();
          //           },
          //         ),
          //       )
          //     : Offstage() // to check if the url is empty
        ],
      ),
    );
  }
}
