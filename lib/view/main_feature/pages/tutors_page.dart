import 'package:flutter/material.dart';
import 'package:lettutor/view/main_feature/components/custom_chip.dart';
import 'package:lettutor/view/main_feature/components/teacher_card.dart';

import '../../../constants/fake_data.dart';

class TutorsPage extends StatefulWidget {
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
          child: ListView.builder(
            itemCount: myData
                .length, // myData là một mảng các đối tượng dữ liệu của bạn
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1), // Màu bóng đổ
                      spreadRadius: 1, // Bán kính của bóng đổ
                      blurRadius: 1, // Độ mờ của bóng đổ
                      offset: const Offset(0, 1), // Độ dịch chuyển của bóng đổ
                    ),
                  ],
                ),
                child: TeacherCard(index, context),
              );
            },
          ),
        )
      ],
    );
  }
}
