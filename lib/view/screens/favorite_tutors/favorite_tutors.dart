import 'package:flutter/material.dart';
import 'package:lettutor/constants/fake_data.dart';
import 'package:lettutor/data/provider/tutor_provider.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/widgets/list_items/teacher_card.dart';
import 'package:lettutor/view/widgets/list_items/tutor_card.dart';
import 'package:provider/provider.dart';


// TODO: add provider for favorite tutor
class FavoriteTutorsPage extends StatefulWidget {
  const FavoriteTutorsPage({super.key});

  @override
  State<FavoriteTutorsPage> createState() => _FavoriteTutorsPageState();
}

class _FavoriteTutorsPageState extends State<FavoriteTutorsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite Tutors')),
      body: Consumer<TutorProvider>(builder: (context, tutorProvider, _) {
        return tutorProvider.favorites.length == 0
            ? Center(child: Text("No favorite tutors"))
            : ListView.builder(
                itemCount: tutorProvider.favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  final favoriteTutor = tutorProvider.favorites[index];
                  TutorRowItem? tutor;
                  for (int i = 0; i < tutorProvider.tutors.length; ++i) {
                    if (tutorProvider.tutors[i].userId ==
                        favoriteTutor.secondId) {
                      tutor = tutorProvider.tutors[i];
                    }
                  }

                  return Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1), // Màu bóng đổ
                          spreadRadius: 1, // Bán kính của bóng đổ
                          blurRadius: 1, // Độ mờ của bóng đổ
                          offset:
                              const Offset(0, 1), // Độ dịch chuyển của bóng đổ
                        ),
                      ],
                    ),
                    // child: TeacherCard(index, context, tutor),
                    child: GestureDetector(
                      onTap: () {
                        {
                          Navigator.pushNamed(context, Routers.TeacherDetail,
                              arguments: {
                                'tutor': tutor,
                              });
                        }
                        ;
                      },
                      child: TutorCard(
                        tutor: tutor!,
                        isFavorite: tutorProvider.isFavorite(tutor),
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }
}
