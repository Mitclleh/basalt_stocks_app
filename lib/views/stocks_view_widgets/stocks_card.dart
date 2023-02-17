import 'package:flutter/material.dart';
import '../../models/stock_report.dart';

/*
Widget that displays the stock report of a symbol, notice that I styled each Text individually, this is because building out a theme
will require a little more time and seems redundant for this small application
*/

class StockCard extends StatelessWidget {
  final StockSummaryReport stockSummaryReport;
  const StockCard({required this.stockSummaryReport, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      stockSummaryReport.symbol,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'high : ${stockSummaryReport.high.toString()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'low : ${stockSummaryReport.low.toString()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          stockSummaryReport.percentageChange > 0
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: stockSummaryReport.percentageChange > 0
                              ? Colors.green
                              : Colors.red,
                        ),
                        Text(
                          '${stockSummaryReport.percentageChange.toStringAsFixed(2)}%',
                          style: TextStyle(
                              color: stockSummaryReport.percentageChange > 0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                    Text(
                      'Vol : ${stockSummaryReport.volume}',
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  stockSummaryReport.name,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
