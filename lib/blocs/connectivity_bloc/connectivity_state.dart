part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object?> get props => [];
}

class ConnectivityStateConnection extends ConnectivityState {
  const ConnectivityStateConnection();

  @override
  List<Object?> get props => [];
}

class ConnectivityStateNoConnection extends ConnectivityState {}
