import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymztest/bloc/home/home_bloc.dart';
import 'package:paymztest/repository/video_respository.dart';
import 'bloc/authentication/auth_bloc.dart';
import 'bloc/delegate/bloc_delegate.dart';
import 'repository/user_repository.dart';
import 'ui/home/home_screen.dart';
import 'ui/login/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = CustomDelegate();
  final UserRepository userRepository = UserRepository();
  final VideoRespository videoRepository = VideoRespository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(userRepository: userRepository)
                ..add(AppStarted()),
        ),
        BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(repository: videoRepository))
      ],
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated || state is Uninitialized) {
            return LoginScreen(userRepository: _userRepository);
          } else {
            return HomeScreen();
          }
//          if (state is Authenticated) {
//            return HomeScreen();
//          }
        },
      ),
    );
  }
}
