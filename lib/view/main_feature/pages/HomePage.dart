import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required int page,
    required GlobalKey<CurvedNavigationBarState> bottomNavigationKey,
  })  : _page = page,
        _bottomNavigationKey = bottomNavigationKey,
        super(key: key);

  final int _page;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey;

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
      ],
    );
  }
}
