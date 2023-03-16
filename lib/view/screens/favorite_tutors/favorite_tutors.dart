import 'package:flutter/material.dart';
import 'package:lettutor/constants/fake_data.dart';
import 'package:lettutor/view/widgets/list_items/teacher_card.dart';

class FavoriteTutorsPage extends StatelessWidget {
  static String routeName = "/favorite";
  const FavoriteTutorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite Tutors')),
      body: ListView.builder(
        itemCount:
            myData.length, // myData là một mảng các đối tượng dữ liệu của bạn
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
    );
  }
}
