import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const AboutMeApp());

class AboutMeApp extends StatefulWidget {
  const AboutMeApp({super.key});

  @override
  State<AboutMeApp> createState() => _AboutMeAppState();
}

class _AboutMeAppState extends State<AboutMeApp> {
  bool isDarkMode = false;

  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.blueAccent,
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.grey[800]!,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: Colors.indigo,
          secondary: Colors.deepPurpleAccent,
          surface: Colors.grey[900]!,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
        ),
      );

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Me',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: AboutMePage(onToggleTheme: toggleTheme, isDarkMode: isDarkMode),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AboutMePage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;
  const AboutMePage({super.key, required this.onToggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSurface,
                    width: 4,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/profile.png'),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Angelo Landingin',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ListTile(
                    leading: Icon(Icons.circle, size: 10),
                    title: Text('Fullstack Developer.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, size: 10),
                    title: Text('Volleyball Player.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, size: 10),
                    title: Text('Floor Gang.'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('angelolandingin.dev@gmail.com'),
                  onTap: () => {copy(context, 'angelolandingin.dev@gmail.com')},
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.link),
                  title: const Text('https://github.com/ivonneschwie'),
                  onTap: () => {copy(context, 'https://github.com/ivonneschwie')},
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onToggleTheme,
        tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        child: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      ),
    );
  }

  Future<void> copy(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Copied to your clipboard !')));
    });
  }
}