import 'package:flutter/material.dart';
import 'package:lettutor/models/course.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CourseTopicPDFViewer extends StatefulWidget {
  const CourseTopicPDFViewer({Key? key}) : super(key: key);

  @override
  State<CourseTopicPDFViewer> createState() => _CourseTopicPDFViewerState();
}

class _CourseTopicPDFViewerState extends State<CourseTopicPDFViewer> {
  bool isExpanded = false;
  var currentIndex = -1;
  List<Topic>? topicsList;
  late UniqueKey _pdfKey;

  @override
  void initState() {
    super.initState();
    _pdfKey = UniqueKey();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    List<Topic> topics = args["topics"]!;
    var index = args["index"]!;

    setState(() {
      currentIndex = index;
      topicsList = topics;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          topicsList![currentIndex].name!,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ExpansionTile(
                title: Text(AppLocalizations.of(context)!.topicList),
                leading: const Icon(Icons.list),
                trailing: isExpanded
                    ? const Icon(Icons.expand_less)
                    : const Icon(Icons.expand_more),
                onExpansionChanged: (bool expanding) {
                  setState(() {
                    isExpanded = expanding;
                  });
                },
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: topicsList!.map((item) {
                        return GestureDetector(
                          onTap: () {
                            print(topicsList!.indexOf(item));
                            setState(() {
                              isExpanded = false;
                              currentIndex = topicsList!.indexOf(item);
                              _pdfKey = UniqueKey();
                            });
                          },
                          child: ListTile(
                            title: Text(item.name!),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ]),
            Expanded(
              child: SfPdfViewer.network(
                topicsList![currentIndex].nameFile!,
                key: _pdfKey,
                canShowScrollHead: true,
                canShowScrollStatus: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
