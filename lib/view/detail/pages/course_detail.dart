import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/view/detail/components/profile_description.dart';
import 'package:lettutor/view/detail/components/profile_title.dart';
import 'package:lettutor/view/detail/pages/lessons_detail.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  String remotePDFpath = "";
  int _selectedIndex = -1;

  final List<String> _titles = [
    '1. Food You Love',
    '2. Your Job',
    '3. Playing and Watching Sports',
    '4. The Best Pets',
    '5. Having Fun in Your Freetime',
  ];
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(title: const Text('Course Detail')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.asset(
                          AssetsManager.courseImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Life in the Internet Age',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Let's discuss how technology is changing the way we live",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Intermediate . 9 Lessons',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const ProfileTitle(text: "Overview"),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorsManager.circleIconColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.question_mark,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    'Why take this course?',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const ProfileDescription(
                  text:
                      "Our world is rapidly changing thanks to new technology , and the vocabulary nededed to discuss modern life is evolving almost daily. In this course you will learn the most up-tio-date terminology from experly crafted lessons as well from your native-speaking tutor."),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorsManager.circleIconColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.question_mark,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    'What will you be able to do?',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const ProfileDescription(
                text:
                    "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discuss questions, you will practise intermediate level speakking tasks such as using data to describe trends.",
              ),
              const SizedBox(
                height: 10,
              ),
              const ProfileTitle(text: "Experience Level"),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      Icons.people,
                      color: ColorsManager.circleIconColor,
                    ),
                  ),
                  const Text(
                    'Intermediate',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const ProfileTitle(text: "Course Length"),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      Icons.book,
                      color: ColorsManager.circleIconColor,
                    ),
                  ),
                  const Text(
                    '9',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const ProfileTitle(text: "List Topics"),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _titles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });

                        
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CourseTopicPDFViewer(
                                url:
                                    "https://www.nasa.gov/sites/default/files/atoms/files/journey-to-mars-next-steps-20151008_508.pdf",
                                title: "PDF VIEW"),
                          ),
                        );
                      },
                      onHover: (value) {
                        setState(() {
                          if (value) {
                            _selectedIndex = index;
                          } else {
                            _selectedIndex = -1;
                          }
                        });
                      },
                      child: Container(
                        color: _selectedIndex == index ? Colors.grey : null,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _titles[index],
                            style: TextStyle(
                              color: _selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // SfPdfViewer.network(
              //   'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
              //   key: _pdfViewerKey,
              // ),
            ],
          ),
        ),
      ),
  
    ]);
  }
}
