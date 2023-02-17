import 'package:basalt_stocks_app/views/stocks_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*GoRouter is a very simple yet powerful navigation system with redirection capabilities for things like authentication,
in some cases it would be better to implement custom navigation via a bloc/riverpod/provider, especially if there is 
a lot of business logic associated with moving between screens
*/
GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const StocksView();
      },
    ),
  ],
);
