import 'package:basalt_stocks_app/views/stocks_view_widgets/stocks_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/stocks_summary_bloc/stocks_summary_bloc.dart';

class StocksList extends StatelessWidget {
  const StocksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StocksSummaryBloc, StocksSummaryState>(
      builder: (context, state) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.reportsToShow?.length ??
                state.stockSummaryReports?.length ??
                0,
            itemBuilder: (context, index) {
              return StockCard(
                  stockSummaryReport: state.reportsToShow?[index] ??
                      state.stockSummaryReports![index]);
            });
      },
    );
  }
}
