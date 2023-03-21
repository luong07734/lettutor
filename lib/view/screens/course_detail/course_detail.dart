import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_description.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_title.dart';
import 'package:lettutor/view/screens/lesson_detail/lesson_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CourseDetailPage extends StatefulWidget {
  static String routeName = "/course_detail";
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
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
              ProfileTitle(text: AppLocalizations.of(context)!.overview),
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
                  Text(
                    AppLocalizations.of(context)!.courseWhy,
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
                  Text(
                    AppLocalizations.of(context)!.courseWhat,
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
              ProfileTitle(text: AppLocalizations.of(context)!.experienceLevel),
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
              ProfileTitle(text: AppLocalizations.of(context)!.courseLength),
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

              ProfileTitle(text: AppLocalizations.of(context)!.listTopics),

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

                        Navigator.pushNamed(context, Routers.PDFView,
                            arguments: {
                              'url':
                                  'https://www.nasa.gov/sites/default/files/atoms/files/journey-to-mars-next-steps-20151008_508.pdf',
                              'title': 'PDF VIEW',
                            });
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => const CourseTopicPDFViewer(
                        //         url:
                        //             "https://www.nasa.gov/sites/default/files/atoms/files/journey-to-mars-next-steps-20151008_508.pdf",
                        //         title: "PDF VIEW"),
                        //   ),
                        // );
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
