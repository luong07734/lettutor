import 'package:flutter/material.dart';
import 'package:lettutor/view/screens/course_detail/course_detail.dart';
import 'package:lettutor/view/screens/courses/course_page.dart';
import 'package:lettutor/view/screens/favorite_tutors/favorite_tutors.dart';
import 'package:lettutor/view/screens/forgot_password/forgot_password.dart';
import 'package:lettutor/view/screens/history/history.dart';
import 'package:lettutor/view/screens/home/home_page.dart';
import 'package:lettutor/view/screens/lesson_detail/lesson_detail.dart';
import 'package:lettutor/view/screens/log_in/log_in.dart';
import 'package:lettutor/view/screens/schedule/schedule.dart';
import 'package:lettutor/view/screens/sign_up/sign_up.dart';
import 'package:lettutor/view/screens/tutor_detail/teacher_detail.dart';
import 'package:lettutor/view/screens/tutor_register/stepper.dart';
import 'package:lettutor/view/screens/tutors/tutors_page.dart';
import 'package:lettutor/view/screens/video_call/video_call.dart';

final Map<String, WidgetBuilder> routes = {
  // bottom navigation
  '/': (BuildContext context) => HomePage(),
  '/schedule': (BuildContext context) => SchedulePage(),
  '/tutors': (BuildContext context) => TutorsPage(),
  '/courses': (BuildContext context) => CoursePage(),

  // drawer
  '/history': (BuildContext context) => HistoryPage(),
  '/favorite': (BuildContext context) => FavoriteTutorsPage(),
  '/become_teacher': (BuildContext context) => RegisterStepper(),

  // video call
  '/video_call': (BuildContext context) => VideoCallWidget(),

  //detail
  '/course_detail': (BuildContext context) => CourseDetail(),
  '/tutor_detail': (BuildContext context) => TeacherDetail(),
  // '/lesson_detail': (BuildContext context) => CourseTopicPDFViewer(),

  // authorization
  '/log_in': (BuildContext context) => LoginPage(),
  '/sign_up': (BuildContext context) => SignUpPage(),
  '/forgot_password': (BuildContext context) => ForgotPasswordPage(),
};
