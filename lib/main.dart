import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class Pokemon {
  final int id;
  final String name;
  final bool legendary;

  const Pokemon({
    this.id,
    this.name,
    this.legendary,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Legendary Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _displayLegendary = false;
  List<Pokemon> _allPokemons = [];
  List<Pokemon> _legendaryPokemons = [];

  void _loadPokedex() async {
    final pokedexData =
        (await rootBundle.loadString('assets/Pokemon.csv')).split('\n');
    final total = pokedexData.length - 1;
    List<Pokemon> importedPokemons = [];

    for (var i = 1; i < total; i++) {
      final data = pokedexData[i].split(',');

      importedPokemons.add(Pokemon(
        id: int.parse(data[0]),
        name: data[1],
        legendary: data[12] == 'True',
      ));
    }

    setState(() {
      _allPokemons = importedPokemons;
      _legendaryPokemons =
          importedPokemons.where((pokemon) => pokemon.legendary).toList();
    });
  }

  void _filterLegendary() {
    setState(() {
      _displayLegendary = !_displayLegendary;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPokedex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legendary Pokedex'),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: _displayLegendary
              ? _legendaryPokemons.length
              : _allPokemons.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_displayLegendary
                  ? _legendaryPokemons[index].name
                  : _allPokemons[index].name),
            );
          },
          separatorBuilder: (_, __) {
            return Divider();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _filterLegendary,
        tooltip: 'Only show legendary pokemons',
        child:
            Icon(_displayLegendary ? Icons.all_inclusive : Icons.auto_awesome),
      ),
    );
  }
}
