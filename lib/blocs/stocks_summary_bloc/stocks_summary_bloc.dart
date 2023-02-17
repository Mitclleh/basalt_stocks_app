import 'package:basalt_stocks_app/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:basalt_stocks_app/models/end_of_day_report.dart';
import 'package:basalt_stocks_app/models/stock_report.dart';
import 'package:basalt_stocks_app/models/stock_ticker_model.dart';
import 'package:basalt_stocks_app/repositories/end_of_day_report.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../repositories/symbols_api.dart';
part 'stocks_summary_event.dart';
part 'stocks_summary_state.dart';

/*
This is the bloc that handles the business logic for the stockSummaryView,it contains 5 events,
which I hope are pretty self explanatory.
*/

class StocksSummaryBloc extends Bloc<StocksSummaryEvent, StocksSummaryState> {
  final ConnectivityBloc connectivityBloc;
  final TextEditingController controller;
  StocksSummaryBloc({required this.controller, required this.connectivityBloc})
      : super(StocksSummaryState(
            stockSummaryReports: const [],
            startDateTime: DateTime.now().subtract(const Duration(days: 5)),
            endDateTime: DateTime.now())) {
    //Listen to the state of the connectivity bloc and add events to change the state of the view accordingly
    connectivityBloc.stream.listen((connectivityState) {
      add(HandleConnectivityChange(connectivityState));
    });

    on<LoadStocks>((event, emit) => _loadStocks(event, emit));
    on<ChangeDateRange>((event, emit) => _changeDateRange(event, emit));
    on<FilterStocks>((event, emit) => _filterStocks(event, emit));
    on<ClearFilter>((event, emit) => _clearFilter(event, emit));
    on<HandleConnectivityChange>(
        (event, emit) => _handleConnectivityChange(event, emit));
  }

  void _handleConnectivityChange(
      HandleConnectivityChange event, Emitter<StocksSummaryState> emit) {
    if (event.connectivityState is ConnectivityStateConnection) {
      if (state.offline) {
        add(LoadStocks(
            startDateTime: state.startDateTime,
            endDateTime: state.endDateTime));
        emit(state.copyWith(offline: false));
      }
    } else {
      if (!state.offline) {
        emit(state.copyWith(offline: true));
      }
    }
  }

  void _clearFilter(ClearFilter event, Emitter<StocksSummaryState> emit) {
    controller.clear();
    emit(state.copyWith(reportsToShow: state.stockSummaryReports));
  }

  void _filterStocks(FilterStocks event, Emitter<StocksSummaryState> emit) {
    List<StockSummaryReport> filteredStocks = state.stockSummaryReports!
        .where((element) =>
            element.symbol.toLowerCase().contains(event.text.toLowerCase()) ||
            element.name.toLowerCase().contains(event.text.toLowerCase()))
        .toList();

    emit(state.copyWith(reportsToShow: filteredStocks));
  }

  void _changeDateRange(
      ChangeDateRange event, Emitter<StocksSummaryState> emit) {
    add(LoadStocks(
      startDateTime: event.startDateTime,
      endDateTime: event.endDateTime,
    ));
    emit(state.copyWith(
        startDateTime: event.startDateTime, endDateTime: event.endDateTime));
  }

  Future<void> _loadStocks(
      LoadStocks event, Emitter<StocksSummaryState> emit) async {
    final List<StockSummaryReport> reports = [];
    final List<StockTicker>? tickers = await SymbolsRepository.all();
    final List<StockTicker> tickersWithEod = tickers != null
        ? tickers.where((element) => element.hasEod).toList()
        : [];

    List<EndOfDayReport>? eodReports = await EndOfDayReportRepository.all(
        symbols: tickersWithEod.map((e) => e.symbol).toList(),
        startDateTime: event.startDateTime ??
            DateTime.now().subtract(const Duration(days: 5)),
        endDateTime: event.endDateTime ?? DateTime.now());
    for (int i = 10; i < tickersWithEod.length; i++) {
      StockSummaryReport? report = StockSummaryReport.fromEndOfDayReports(
          eodReports!, tickersWithEod[i]);
      if (report != null) {
        reports.add(report);
      }
    }
    if (reports.isNotEmpty) {
      emit(state.copyWith(
          stockSummaryReports: reports.sublist(0, 10),
          offline: false,
          loading: false,
          invalidApiKey: false));
    } else if (connectivityBloc.state is ConnectivityStateNoConnection) {
      emit(state.copyWith(offline: true, loading: false));
    } else {
      emit(state.copyWith(invalidApiKey: true, loading: false));
    }
  }
}
