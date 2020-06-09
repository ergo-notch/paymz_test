part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}
class InitialState extends HomeState {
  @override
  List<Object> get props => [];
}
class LoadingState extends HomeState {
  @override
  List<Object> get props => [];
}
class LoadedState extends HomeState {
  List<VideoModel> items;
  LoadedState({@required this.items});
  @override
  List<Object> get props => null;
}
class ErrorState extends HomeState {
  String message;
  ErrorState({@required this.message});
  @override
  List<Object> get props => [message];
}