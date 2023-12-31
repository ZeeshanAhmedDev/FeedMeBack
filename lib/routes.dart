// import 'package:flutter/material.dart';
//
// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/splash-screen':
//         return MaterialPageRoute(builder: (_) => SplashScreen());
//       case '/home':
//         return MaterialPageRoute(builder: (_) => DashboardView());
//       case '/password-login':
//         return MaterialPageRoute(builder: (_) => PasswordLoginView());
//       case '/sign-up':
//         return MaterialPageRoute(builder: (_) => SignUpView());
//       case '/verify-otp-screen':
//         return MaterialPageRoute(builder: (_) => VerifyOTPView());
//       case '/users':
//         return MaterialPageRoute(builder: (_) => UsersView());
//       case '/my-profile':
//         return MaterialPageRoute(builder: (_) => MyProfileView());
//       case '/verification-page':
//         return MaterialPageRoute(builder: (_) => VerifyProfileView());
//       case '/video-recorder':
//         return MaterialPageRoute(builder: (_) => VideoRecorder());
//       case '/hash-videos':
//         return MaterialPageRoute(builder: (_) => HashVideosView());
//       case '/conversation':
//         return MaterialPageRoute(builder: (_) => ConversationsView());
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: SafeArea(
//               child: Center(
//                 child: Text('Route Error'),
//               ),
//             ),
//           ),
//         );
//     }
//   }
// }
