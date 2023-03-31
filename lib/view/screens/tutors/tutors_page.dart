import 'package:flutter/material.dart';
import 'package:lettutor/data/provider/tutor_provider.dart';
import 'package:lettutor/view/widgets/list_items/custom_chip.dart';
import 'package:lettutor/view/widgets/list_items/teacher_card.dart';
import 'package:provider/provider.dart';

import '../../../constants/fake_data.dart';

class TutorsPage extends StatefulWidget {
  // static String routeName = "/tutors";
  const TutorsPage({super.key});

  @override
  State<TutorsPage> createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
  //final bool _showOptions = false;
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _searchOptions = [
    'By Name',
    'By Country',
  ];
  String _selectedOption = '';

  // handle load data
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print("init tutors called");

    // fetch initial teacher data
    context.read<TutorProvider>().reset();
    context.read<TutorProvider>().loadTutorsInPage();

    // listen to scroll events to detect when user reaches end of list
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final provider = context.read<TutorProvider>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      // fetch next page of teacher data
      provider.loadTutorsInPage(page: provider.page + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search Tutors $_selectedOption",
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    // Display a popup menu of search options
                    String? selectedOption = await showMenu(
                      context: context,
                      position:
                          const RelativeRect.fromLTRB(1000.0, 0, 0.0, 1000.0),
                      items: _searchOptions.map((option) {
                        return PopupMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                    );

                    if (selectedOption != null) {
                      setState(() {
                        _selectedOption = selectedOption;
                      });
                    }
                  },
                  icon: const Icon(Icons.filter_list),
                )),
          ),
        ),
        Flexible(
          flex: 1,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: chipTitles.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomChip(
                  label: chipTitles[index],
                  clickable: true,
                ),
              );
            },
          ),
        ),
        Flexible(
          flex: 10,
          child: Consumer<TutorProvider>(builder: (context, tutorProvider, _) {
            if (tutorProvider.tutors.isEmpty) {
              // show loading indicator while data is being fetched
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                controller: _scrollController,
                itemCount: tutorProvider.tutors.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < tutorProvider.tutors.length) {
                    final tutor = tutorProvider.tutors[index];
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1), // Màu bóng đổ
                            spreadRadius: 1, // Bán kính của bóng đổ
                            blurRadius: 1, // Độ mờ của bóng đổ
                            offset: const Offset(
                                0, 1), // Độ dịch chuyển của bóng đổ
                          ),
                        ],
                      ),
                      child: TeacherCard(index, context, tutor),
                    );
                  } else {
                    // show loading indicator at end of list
                    if (tutorProvider.hasMoreItems) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  }
                },
              );
            }
          }),
        )
      ],
    );
  }
}
