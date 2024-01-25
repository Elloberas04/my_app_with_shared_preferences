import 'package:flutter/material.dart';
import 'package:my_app_with_shared_preferences/preferences/preferences.dart';
import 'package:my_app_with_shared_preferences/providers/theme_provider.dart';
import 'package:my_app_with_shared_preferences/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static const String routerName = 'settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Configuració',
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.w300)),
              const Divider(),
              SwitchListTile(
                  value: Preferences.isDarkMode,
                  title: const Text('Dark Mode'),
                  onChanged: (value) {
                    Preferences.isDarkMode = value;
                    final themeProvider =
                        Provider.of<ThemeProvider>(context, listen: false);
                    value
                        ? themeProvider.setDarkMode()
                        : themeProvider.setLightMode();
                    setState(() {});
                  }),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  initialValue: Preferences.nom,
                  onChanged: (value) {
                    Preferences.nom = value;
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                      labelText: 'Nom', helperText: 'Nom de l\'usuari'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
