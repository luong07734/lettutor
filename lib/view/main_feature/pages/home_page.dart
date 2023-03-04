import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/view/main_feature/components/teacher_card.dart';

import '../../../constants/fake_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue, // màu nền của container
          width:
              double.infinity, // chiều rộng của container bằng toàn bộ màn hình
          padding: const EdgeInsets.symmetric(
              vertical: 20.0), // khoảng cách giữa các phần tử trong container
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // canh giữa các phần tử
            children: [
              const Text(
                'Welcome to LetTutor!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  height: 20.0), // khoảng cách giữa tiêu đề và nút bấm
              ElevatedButton(
                onPressed: () {},
                child: const Text('Book a lesson'),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Recommended Tutors',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Chữ in đậm
                  fontSize: 16.0, // Cỡ chữ 16
                  decoration: TextDecoration.underline, // Gạch chân
                ),
              ),
              Text(
                'See all >',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
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
