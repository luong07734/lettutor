import 'package:flutter/material.dart';
import 'package:lettutor/view/screens/booking/booking_page.dart';
import 'package:lettutor/view/screens/components/drawer-navigation-bar.dart';
import 'package:lettutor/view/screens/course_detail/course_detail.dart';
import 'package:lettutor/view/screens/courses/course_page.dart';
import 'package:lettutor/view/screens/favorite_tutors/favorite_tutors.dart';
import 'package:lettutor/view/screens/forgot_password/forgot_password.dart';
import 'package:lettutor/view/screens/history/history.dart';
import 'package:lettutor/view/screens/home/home_page.dart';
import 'package:lettutor/view/screens/lesson_detail/lesson_detail.dart';
import 'package:lettutor/view/screens/log_in/log_in.dart';
import 'package:lettutor/view/screens/not_found/not_found.dart';
import 'package:lettutor/view/screens/profile/profile.dart';
import 'package:lettutor/view/screens/schedule/schedule.dart';
import 'package:lettutor/view/screens/settings/settings.dart';
import 'package:lettutor/view/screens/sign_up/sign_up.dart';
import 'package:lettutor/view/screens/tutor_detail/teacher_detail.dart';
import 'package:lettutor/view/screens/tutor_register/stepper.dart';
import 'package:lettutor/view/screens/tutors/tutors_page.dart';
import 'package:lettutor/view/screens/video_call/video_call.dart';

// final Map<String, WidgetBuilder> routes = {
//   // bottom navigation
//   // HomePage.routeName: (BuildContext context) => HomePage(),
//   // SchedulePage.routeName: (BuildContext context) => SchedulePage(),
//   // TutorsPage.routeName: (BuildContext context) => TutorsPage(),
//   // CoursePage.routeName: (BuildContext context) => CoursePage(),

//   // drawer
//   HistoryPage.routeName: (BuildContext context) => HistoryPage(),
//   FavoriteTutorsPage.routeName: (BuildContext context) => FavoriteTutorsPage(),
//   RegisterStepper.routeName: (BuildContext context) => RegisterStepper(),

//   // video call
//   VideoCallWidget.routeName: (BuildContext context) => VideoCallWidget(),

//   //detail
//   CourseDetailPage.routeName: (BuildContext context) => CourseDetailPage(),
//   TeacherDetailPage.routeName: (BuildContext context) => TeacherDetailPage(),
//   // '/lesson_detail': (BuildContext context) => CourseTopicPDFViewer(),

//   // authorization
//   LoginPage.routeName: (BuildContext context) => LoginPage(),
//   SignUpPage.routeName: (BuildContext context) => SignUpPage(),
//   ForgotPasswordPage.routeName: (BuildContext context) => ForgotPasswordPage(),
// };

class Routers {
  static const String Default = "/";
  static const String Home = '/home';
  static const String Schedule = '/schedule';
  static const String Tutors = '/tutors';
  static const String Courses = '/courses';

  static const String History = '/history';
  static const String Favorite = '/favorite';
  static const String BecomeTutor = '/become_tutor';

  static const String VideoCall = '/video_call';

  static const String CourseDetail = '/courses/course_detail';
  static const String TeacherDetail = '/tutors/teacher-detail';
  static const String PDFView = '/pdf_view';

  static const String LogIn = '/log_in';
  static const String SignUp = '/sign_up';
  static const String ForgotPassword = '/forgot_password';

  static const String Settings = '/settings';

  static const String Profile = '/profile';
  static const String Booking = '/booking';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SettingsPage(),
        );
      case Home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeDrawerAndNavigationBar(),
        );
      case LogIn:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginPage(),
        );
      case SignUp:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SignUpPage(),
        );
      case ForgotPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ForgotPasswordPage(),
        );
      case Schedule:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SchedulePage(),
        );
      case Tutors:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const TutorsPage(),
        );
      case Courses:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CoursePage(),
        );
      case Tutors:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const TutorsPage(),
        );
      case History:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HistoryPage(),
        );
      case Favorite:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const FavoriteTutorsPage(),
        );
      case BecomeTutor:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RegisterStepper(),
        );
      case VideoCall:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => VideoCallPage(),
            fullscreenDialog: true);
      case CourseDetail:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CourseDetailPage(),
        );
      case TeacherDetail:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => TeacherDetailPage(),
        );
      case PDFView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CourseTopicPDFViewer(),
        );

      case Settings:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SettingsPage(),
        );

      case Profile:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProfileScreen(),
        );
      case Booking:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BookingPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundPage(),
        );
    }
  }
}
