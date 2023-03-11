import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CourseTopicPDFViewer extends StatefulWidget {
  const CourseTopicPDFViewer({Key? key, required this.url, required this.title})
      : super(key: key);
  final String url;
  final String title;

  @override
  State<CourseTopicPDFViewer> createState() => _CourseTopicPDFViewerState();
}

class _CourseTopicPDFViewerState extends State<CourseTopicPDFViewer> {
  final int _selectedIndex = -1;
  final List<String> _titles = [
    '1. Food You Love',
    '2. Your Job',
    '3. Playing and Watching Sports',
    '4. The Best Pets',
    '5. Having Fun in Your Freetime',
  ];
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 20,
        centerTitle: true,
        elevation: 0,

        //iconTheme: IconThemeData(color: Colors.white),
        title: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ExpansionTile(
              title: const Text('My List'),
              leading: const Icon(Icons.list),
              trailing: isExpanded
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
              onExpansionChanged: (bool expanding) {
                setState(() {
                  isExpanded = expanding;
                });
              },
              children: _titles.map((item) {
                return GestureDetector(
                  onTap: () {
                    print(_titles.indexOf(item));
                    setState(() {
                      isExpanded = false;
                    });
                  },
                  child: ListTile(
                    title: Text(item),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: SfPdfViewer.network(
                widget.url,
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
