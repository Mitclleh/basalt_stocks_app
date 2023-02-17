import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

/*
This is a bloc to handle the internet connectivity state of the device, 
it listens to a stream from the connectivity package and emits a new state in the case that it changes,
you'll see that in the stocks_vie there is a bloclistener which will show a snackbar when the device has no internet connectivity.

This bloc might seem unnecessary, but when you have multiple things depending on internet connectivity,
it makes your life a little simpler
*/

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity connectivity = Connectivity();

  late StreamSubscription _connectivityStreamSubscription;

  ConnectivityBloc() : super(ConnectivityStateNoConnection()) {
    _connectivityStreamSubscription = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) async {
      add(CheckInternetConnectivityStatus(
          updatedConnectivityResult: connectivityResult));
    });
    on<CheckInternetConnectivityStatus>(
        (event, emit) async => await _checkInternetConnectivityStatus(emit));
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();
    return super.close();
  }

  Future<void> _checkInternetConnectivityStatus(Emitter<ConnectivityState> emit,
      {ConnectivityResult? connectivityResult}) async {
    ConnectivityResult updatedConnectivityStatus =
        connectivityResult ?? await connectivity.checkConnectivity();
    if (updatedConnectivityStatus == ConnectivityResult.none) {
      emit(ConnectivityStateNoConnection());
    } else {
      emit(const ConnectivityStateConnection());
    }
  }
}
