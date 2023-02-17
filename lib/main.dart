import 'package:basalt_stocks_app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/connectivity_bloc/connectivity_bloc.dart';
import 'blocs/stocks_summary_bloc/stocks_summary_bloc.dart';

/*
      NOTE TO WHOEVER IS READING THIS :
      ---------------------------------
Since the task given to me was quite vague yet simple,I did what I thought was 
considered to be a good middle point between barebones functionality whilst still
using a concrete application structure such as state management via the bloc library, routing via gorouter,
using models and repos to interact with the api etc, some things might seem like overkill for such a small application, 
but it can very easily expanded on.Some things I wanted to implement but I deemed it to be unnecessary , for instance :
having an abstract model and repository class, building an entire theme(light and dark mode), or doing a splash screen and launcher icons.
But I can show you some of these things in other applications I have done.

I hope this project demonstrates my abilities

Thanks for considering my application

Regards - Mitchell Herbst

                        __..,,... .,,,,,.
                     ''''        ,'        ` .
                               ,'  ,.  ..      `  .
                               `.,'      ..           `
                     __..,.             .  ..     .
                            ` .       .  `.  .` `
                                ,  `.  `.  `._|,..
                                  .  `.  `..'
                                   ` -'`''

I hope we can do some great things together in the future


P.s This took 6 hours of coding (3 * 2 hour code blocks)

*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final ConnectivityBloc connectivityBloc = ConnectivityBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => connectivityBloc,
        ),
        BlocProvider(
          create: (context) => StocksSummaryBloc(
              connectivityBloc: connectivityBloc,
              controller: TextEditingController())
            ..add(LoadStocks()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Basalt Stocks Application',
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.grey,
            displayColor: Colors.blue,
          ),
          dialogTheme: const DialogTheme(
              contentTextStyle: TextStyle(color: Colors.white)),
          appBarTheme:
              const AppBarTheme(backgroundColor: Color.fromRGBO(10, 24, 47, 1)),
          cardColor: const Color.fromRGBO(23, 42, 70, 1),
          scaffoldBackgroundColor: const Color.fromRGBO(10, 24, 47, 1),
        ),
        routerConfig: router,
      ),
    );
  }
}
