import 'package:flutter/material.dart';
import 'package:tp1/components.dart';
import 'package:tp1/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();
  late String _name;

  _sayHello(BuildContext context) {
    if(!_formkey.currentState!.validate()) return;
    _formkey.currentState?.save();
    showDialog(context: context, builder: (context) => AlertDialog(
        content: MyText("Bonjour, ${_name.trim()}"),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const MyText("Merci!"))
        ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Votre Nom",
                ),
                onSaved: (value) => _name = value.toString(),
                validator: (value) {
                  if(value == null || value.trim().isEmpty) return "Veuillez saisir un nom.";
                  return null;
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () { 
                      _sayHello(context);
                    },
                    child: const MyText("Dire bonjour !")
                ),
              )
            ],
      ))
    );
  }
}