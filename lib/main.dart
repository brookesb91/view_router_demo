import 'package:flutter/material.dart';
import 'package:view_router/view_router.dart';

final Routes routes = {
  HomePage.path: HomePage.route,
  ItemsPage.path: ItemsPage.route,
  ItemPage.path: ItemPage.route
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: ViewRouter(routes: routes),
    );
  }
}

class HomePage extends StatelessWidget {
  static String get path => '/';

  static Widget route(BuildContext context) =>
      view(context, (params) => const HomePage());

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('View Items'),
          onPressed: () => Navigator.of(context).pushNamed('/items'),
        ),
      ),
    );
  }
}

class ItemsPage extends StatelessWidget {
  static String get path => '/items';

  static Widget route(BuildContext context) =>
      view(context, (params) => ItemsPage());

  final List<int> items = List.generate(10, (index) => index);

  ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (item, index) => ListTile(
          title: Text('Item ${items[index]}'),
          onTap: () =>
              Navigator.of(context).pushNamed('/items/${items[index]}'),
        ),
      ),
    );
  }
}

class ItemPage extends StatelessWidget {
  static String get path => '/items/:item_id';

  static Widget route(BuildContext context) =>
      view(context, (params) => ItemPage(id: params['item_id']!));

  final String id;

  const ItemPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Item ID: $id'),
      ),
    );
  }
}

// todo - more examples