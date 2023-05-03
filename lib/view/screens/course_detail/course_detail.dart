import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/models/course.dart';
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
  CousreRowItem? course;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    CousreRowItem courseArgs = args['course'];

    setState(() {
      course = courseArgs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.courseDetail),
          centerTitle: true,
        ),
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
                        child: Image.network(
                          course!.imageUrl!,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                                AssetsManager.imageLoadFailedImage);
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          course!.name!,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              course!.description!,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Level " +
                                  course!.level! +
                                  " · " +
                                  course!.topics!.length.toString() +
                                  " lessons",
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
              ProfileDescription(text: course!.reason!),
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
              ProfileDescription(
                text: course!.purpose!,
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
                  Text(
                    "Level " + course!.level!,
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
                  Text(
                    course!.topics!.length.toString(),
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
                  itemCount: course!.topics!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });

                        Navigator.pushNamed(context, Routers.PDFView,
                            arguments: {
                              'topics': course!.topics!,
                              'index': index,
                              'title': 'PDF VIEW',
                            });
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
                        // color: _selectedIndex == index ? Colors.grey : null,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            course!.topics![index].name!,
                            style: TextStyle(
                              // color: _selectedIndex == index
                              //     ? Colors.white
                              //     : Colors.black,
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
