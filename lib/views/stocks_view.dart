import 'package:basalt_stocks_app/views/stocks_view_widgets/stocks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/connectivity_bloc/connectivity_bloc.dart';
import '../blocs/stocks_summary_bloc/stocks_summary_bloc.dart';

/*
This is the main(and only) view of the application, if you have knowledge of
stocks, you might realize that I do not :), I did some research and this made the most sense to me.
*/
class StocksView extends StatelessWidget {
  const StocksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(75),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<StocksSummaryBloc, StocksSummaryState>(
                        builder: (context, state) {
                          return Text(
                            "${DateFormat('yyyy-mm-dd').format(state.startDateTime)} to ${DateFormat('yyyy-mm-dd').format(state.endDateTime)}",
                            style: const TextStyle(color: Colors.grey),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_month),
                        color: Colors.grey,
                        onPressed: () async {
                          await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 365)),
                                  lastDate: DateTime.now())
                              .then((value) {
                            if (value != null) {
                              context
                                  .read<StocksSummaryBloc>()
                                  .add(ChangeDateRange(
                                    startDateTime: value.start,
                                    endDateTime: value.end,
                                  ));
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: context.read<StocksSummaryBloc>().controller,
                      onChanged: (v) {
                        context
                            .read<StocksSummaryBloc>()
                            .add(FilterStocks(text: v));
                      },
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              context
                                  .read<StocksSummaryBloc>()
                                  .add(ClearFilter());
                            },
                            child: const Icon(Icons.close),
                          ),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Filter Stocks'),
                    ),
                  )
                ],
              ),
            ),
          ),
          title: const Text('Basalt stocks'),
        ),
        body: BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (context, state) {
            if (state is ConnectivityStateNoConnection) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No Internet connection")));
            }
          },
          child: BlocBuilder<StocksSummaryBloc, StocksSummaryState>(
            builder: (context, state) {
              if (state.showStocks) {
                return const StocksList();
              } else if (state.loading) {
                return const StocksLoadingWidget();
              } else {
                return const StocksErrorWidget();
              }
            },
          ),
        ));
  }
}

class StocksLoadingWidget extends StatelessWidget {
  const StocksLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class StocksErrorWidget extends StatelessWidget {
  const StocksErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StocksSummaryBloc, StocksSummaryState>(
      builder: (context, state) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning,
                color: Colors.red,
                size: 50,
              ),
              if (state.invalidApiKey)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Api key is invalid",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              if (state.offline)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Application is offline",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
