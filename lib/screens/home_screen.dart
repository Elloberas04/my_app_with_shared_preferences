import 'package:flutter/material.dart';
import 'package:my_app_with_shared_preferences/preferences/preferences.dart';
import 'package:my_app_with_shared_preferences/providers/theme_provider.dart';
import 'package:my_app_with_shared_preferences/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routerName = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final List<String> llistaTasques = Preferences.llistaTasques;
    String _nom = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks List'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                List<String> historial = Preferences.llistaTasques;
                historial.clear();
                Preferences.llistaTasques = historial;
              });
            },
            icon: const Icon(Icons.delete_forever_rounded),
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      icon: const Icon(Icons.note_add_outlined),
                      title: const Text('Add new task'),
                      content: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Create new program...',
                          labelText: 'Title',
                          helperText: '*Obligatory',
                          helperStyle: const TextStyle(color: Colors.red),
                          suffixIcon: const Icon(Icons.accessibility),
                          icon: const Icon(Icons.account_circle),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onChanged: (value) {
                          _nom = value;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              List<String> historial =
                                  Preferences.llistaTasques;
                              historial.add(_nom);
                              Preferences.llistaTasques = historial;
                            });
                            Navigator.of(context).pop();
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.save),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Save'),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.playlist_add_outlined))
        ],
      ),
      drawer: const SideMenu(),
      body: ListView.builder(
        itemCount: llistaTasques.length,
        itemBuilder: (_, index) => Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
            child: const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.delete_forever),
              ),
            ),
          ),
          onDismissed: (DismissDirection direccio) {
            setState(() {
              List<String> historial = Preferences.llistaTasques;
              historial.remove(historial[index]);
              Preferences.llistaTasques = historial;
            });
          },
          child: ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            title: Text(llistaTasques[index]),
            trailing: const Icon(
              Icons.task_outlined,
              color: Colors.grey,
            ),
            onTap: () {},
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Preferences.isDarkMode) {
            themeProvider.setLightMode();
            Preferences.isDarkMode = false;
          } else {
            themeProvider.setDarkMode();
            Preferences.isDarkMode = true;
          }
        },
        child: Preferences.isDarkMode
            ? const Icon(Icons.light_mode_outlined)
            : const Icon(Icons.dark_mode_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
