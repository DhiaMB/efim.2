import 'package:efim/view/invatory/members_list.dart';
import 'package:flutter/material.dart';
import 'package:efim/services/auth/auth_service.dart';
import 'package:efim/view/login_view.dart';
import 'package:efim/view/invatory/reuseble_widget.dart';

import 'package:efim/view/register_view.dart';
import 'package:efim/view/verify_email_view.dart';
import 'dart:developer' as devtools show log;
import 'package:efim/constants/router.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // Wrap the MaterialApp with the UserList provider
    ChangeNotifierProvider(
      create: (context) => MachinesList([]), // Pass initial user list here
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        mainPageRoute: (context) => const MainPageView(),
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyRote: (context) => const VerifyEmailView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            devtools.log(user.toString());
            if (user != null) {
              if (user.isEmailVerified) {
                return const MainPageView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}














// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(ChangeNotifierProvider(
//       create: (context) => UserList([]), // Pass initial user list here
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//           primarySwatch: Colors.blue,
//         ),
//     home: const HomePage(),
//     routes: {
//       mainPageRoute: (context) => const MainPageView(),
//       loginRoute: (context) => const LoginView(),
//       registerRoute: (context) => const RegisterView(),
//       // notesRoute: (context) => const NotesView(),
//       verifyRote: (context) => const VerifyEmailView(),
//       //invatoryRote: (context) => const InvatoryView(),
//       //NewInvatoryViewRote: (context) => const NewInvatoryView(),
//     },
//   )));
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: AuthService.firebase().initialize(),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               final user = AuthService.firebase().currentUser;
//               devtools.log(user.toString());
//               if (user != null) {
//                 if (user.isEmailVerified) {
//                   return const MainPageView();
//                 } else {
//                   return const VerifyEmailView();
//                 }
//               } else {
//                 return const LoginView();
//               }

//             default:
//               return const CircularProgressIndicator();
//           }
//         });
//   }
// }
