import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gym/block/block.dart';
import 'package:flutter_gym/forms/exercise_list.dart';
import 'package:flutter_gym/forms/exercises_form.dart';
import 'package:flutter_gym/forms/register_form.dart';
import 'package:flutter_gym/forms/video_pleer_screen.dart';

import 'package:flutter_gym/widgets/landing_page.dart';

class AppRouter {
  final DataCubitChat chatCubit = DataCubitChat(KeeperChat());

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: chatCubit,
            child: LandingPage(),
          ),
        );

      case '/Register':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: chatCubit,
            child: const RegisterForm(),
          ),
        );

      case '/ExercisesForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: chatCubit,
            child: const ExercisesForm(),
          ),
        );
      case '/ExerciseListWidget':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: chatCubit,
            child: ExerciseListWidget(),
          ),
        );
      case '/FirebaseVideoPlayer':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: chatCubit,
            child: FirebaseVideoPlayer(
                videoUrl:
                    'https://firebasestorage.googleapis.com/v0/b/supergym-4a47d.appspot.com/o/fitness_-_116337%20(540p)%20(1).mp4?alt=media&token=933405ec-2f06-414d-b81b-db55aa66bfb9&_gl=1*1ddgyh9*_ga*NjA4MzAzMjU1LjE2OTYyNjgyMzY.*_ga_CW55HF8NVT*MTY5NzM3NTg1OC4xMi4xLjE2OTczNzczNzYuNTguMC4w'),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: chatCubit,
            child: LandingPage(),
          ),
        );
    }
  }
}
