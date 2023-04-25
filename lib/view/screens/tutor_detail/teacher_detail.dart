import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/color_manager.dart';
import 'package:lettutor/constants/fake_data.dart';
import 'package:lettutor/data/network/apis/tutors/tutor_apis.dart';
import 'package:lettutor/data/provider/tutor_provider.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/models/tutor_detail.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/screens/tutor_detail/components/report_modal.dart';
import 'package:lettutor/view/widgets/view_items/buttons/custom_button.dart';
import 'package:lettutor/view/widgets/list_items/comment_card.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_description.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_title.dart';
import 'package:lettutor/view/widgets/view_items/rating/rating.dart';
import 'package:lettutor/view/screens/tutor_detail/components/video_player.dart';
import 'package:lettutor/view/widgets/list_items/custom_chip.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

class TeacherDetailPage extends StatefulWidget {
  TeacherDetailPage({super.key});

  @override
  State<TeacherDetailPage> createState() => _TeacherDetailPageState();
}

class _TeacherDetailPageState extends State<TeacherDetailPage> {
  TutorDetail? tutorDetail;
  TutorRowItem? tutorRowItem;
  bool isLoading = true;
  bool? isFavorite;
  bool isReporting = false;
  final TutorApis _tutorApi = TutorApis();

  Future<bool> reportTutor(String tutorId, String content) async {
    setState(() {
      isReporting = true;
    });
    var res = await _tutorApi.reportTutor(tutorId, content);
    print(res["message"]);
    if (res["message"] != "Report successfully") {
      setState(() {
        isReporting = false;
      });
      return false;
    }
    isReporting = false;
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    TutorRowItem tutorArgs = args['tutor'];
    if (tutorArgs.userId != null) {
      print(tutorArgs.userId!);
      _loadTutorDetail(tutorArgs.userId!).then((value) {
        setState(() {
          tutorDetail = value;
          isLoading = false;
          tutorRowItem = tutorArgs;
          isFavorite = tutorDetail!.isFavorite;
        });
      });
    } else {
      print("tutorArgs id null");
      setState(() {
        tutorDetail = null;
        isLoading = false;
        tutorRowItem = tutorArgs;
        isFavorite = false;
      });
    }
  }

  String toUpperCase(String word) {
    List<String> words = word.split('-');
    String result = words.map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
    return result;
  }

  static Future<TutorDetail?> _loadTutorDetail(String id) async {
    var res = await TutorApis().getTutorInformationById(id);
    if (res["statusCode"] != null) return null;

    return TutorDetail.fromJson(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Detail'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                backgroundColor: Colors.grey[200],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VideoPlayerWidget(
                    videoUrl: tutorDetail!.video!,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: (tutorRowItem!.avatar == null ||
                                    tutorRowItem!.avatar!
                                        .contains("icon-avatar-default.png"))
                                ? CircleAvatar(
                                    backgroundImage: AssetImage(
                                      AssetsManager.userAvatarImage,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(tutorRowItem!.avatar!),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tutorRowItem!.name!,
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  tutorRowItem!.profession!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  tutorRowItem!.country!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            tutorDetail!.rating == null
                                ? Text("No rating")
                                : RatingWidget(tutorDetail!.rating!
                                    .toStringAsFixed(1)
                                    .toString()),
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite!;
                                });
                                context
                                    .read<TutorProvider>()
                                    .updateFavorite(tutorRowItem!.userId!);
                              },
                              icon: isFavorite!
                                  ? const Icon(Icons.favorite_outlined,
                                      color: Colors.red)
                                  : const Icon(Icons.favorite_border),
                              label: Text(
                                AppLocalizations.of(context)!.like,
                                style: TextStyle(
                                  color: isFavorite! ? Colors.red : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomButton(
                      onTap: (() {
                        Navigator.pushNamed(context, Routers.Booking,
                            arguments: {
                              'tutorId': tutorRowItem!.userId!,
                            });
                      }),
                      text: AppLocalizations.of(context)!.booking),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // canh giữa dòng
                    children: [
                      InkWell(
                        onTap: () {
                          // do something when button is tapped
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.message,
                                color: ColorsManager.primaryColor),
                            const SizedBox(height: 8.0),
                            Text(
                              AppLocalizations.of(context)!.message,
                              style:
                                  TextStyle(color: ColorsManager.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // do something when button is tapped
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ReportModal(
                                  tutorName: tutorRowItem!.name!,
                                  onReport: (report) {
                                    print(report);
                                    reportTutor(tutorRowItem!.userId!, report)
                                        .then((value) {
                                      if (value) {
                                        print("sucess");
                                      } else {
                                        print("fail");
                                      }
                                    });
                                  });
                            },
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.report,
                                color: ColorsManager.primaryColor),
                            const SizedBox(height: 8.0),
                            Text(
                              AppLocalizations.of(context)!.report,
                              style:
                                  TextStyle(color: ColorsManager.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      tutorRowItem!.bio!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  ProfileTitle(text: AppLocalizations.of(context)!.languages),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Wrap(
                  //     spacing: 4.0,
                  //     children: List.generate(3, (chipIndex) {
                  //       return const Padding(
                  //         padding: EdgeInsets.only(top: 4.0),
                  //         child: CustomChip(label: "English", clickable: false),
                  //       );
                  //     }),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: tutorRowItem!.languages!.split(",").length,
                        itemBuilder: (context, subIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CustomChip(
                              label: toUpperCase(tutorRowItem!.languages!
                                  .split(",")[subIndex]),
                              clickable: false,
                              index: -1,
                              selected: true,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  ProfileTitle(text: AppLocalizations.of(context)!.education),
                  ProfileDescription(text: tutorRowItem!.education!),
                  ProfileTitle(text: AppLocalizations.of(context)!.experience),
                  ProfileDescription(text: tutorRowItem!.experience!),
                  ProfileTitle(text: AppLocalizations.of(context)!.interest),
                  ProfileDescription(text: tutorRowItem!.interests!),
                  ProfileTitle(text: AppLocalizations.of(context)!.profession),
                  ProfileDescription(text: tutorRowItem!.profession!),
                  ProfileTitle(
                      text: AppLocalizations.of(context)!.specialities),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: tutorRowItem!.specialties!.split(",").length,
                        itemBuilder: (context, subIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CustomChip(
                              label: toUpperCase(tutorRowItem!.specialties!
                                  .split(",")[subIndex]),
                              clickable: false,
                              index: -1,
                              selected: true,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  ProfileTitle(text: AppLocalizations.of(context)!.rating),
                  (tutorRowItem!.feedbacks == null ||
                          tutorRowItem!.feedbacks!.length == 0)
                      ? ProfileDescription(text: "No reviews")
                      : ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: tutorRowItem!.feedbacks!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CommentCard(
                              feedBack: tutorRowItem!.feedbacks![index],
                            );
                          },
                        ),
                ],
              ),
            ),
    );
  }
}
