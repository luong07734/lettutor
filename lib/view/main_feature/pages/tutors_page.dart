import 'package:flutter/material.dart';
import 'package:lettutor/view/main_feature/components/teacher_card.dart';

import '../../../constants/fake_data.dart';

class TutorsPage extends StatelessWidget {
  const TutorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search Tutors",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
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
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Chip(
                  label: Text(
                    chipTitles[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: chipColors[index % chipColors.length],
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
                child: TeacherCard(index),
              );
            },
          ),
        )
      ],
    );
  }
}
