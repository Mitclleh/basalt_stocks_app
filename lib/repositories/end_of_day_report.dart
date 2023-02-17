import 'dart:convert';
import 'package:basalt_stocks_app/constants.dart';
import 'package:basalt_stocks_app/models/end_of_day_report.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

/*
Repository that interacts with the end of day endpoint, there is no local database in this application since I do not see the
need for it, but ISAR wouuld be a quick, easy and super effective solution for local data storage, along with a abstract repository
class that will interact with the api, and store the data locally for each class that extends it.

I decided to use EOD since it made the most sense to me, but I could be wrong tbh.
*/

class EndOfDayReportRepository {
  static Future<List<EndOfDayReport>?> all(
      {required List<String> symbols,
      required DateTime startDateTime,
      required DateTime endDateTime}) async {
    var url = Uri.http(apiEndpoint, '/v1/eod', {
      'access_key': apiKey,
      'symbols': symbols.join(','),
      'date_from': DateFormat('yyyy-MM-dd').format(startDateTime),
      'date_to': DateFormat('yyyy-MM-dd').format(endDateTime),
      'limit': '1000'
    });
    final Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> decodedData = jsonDecode(data);
      List<EndOfDayReport> tickerList = (decodedData['data'] as List)
          .map((e) => EndOfDayReport.fromMap(e))
          .toList();

      return tickerList;
    } else {
      return null;
    }
  }
}
