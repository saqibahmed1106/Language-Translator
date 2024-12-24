import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final outputController = TextEditingController(text: 'Result here...');
  final translator = GoogleTranslator();

  String inputText = '';
  String inputLanguage = 'en';
  String outputLanguage = 'fr';

  Future<void> translateText() async {
    final translated = await translator.translate(inputText,
    from: inputLanguage, to: outputLanguage
    );
    setState(() {
      outputController.text = translated.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(16),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("images/translator_logo3.png",
              fit: BoxFit.contain,
                height: 170,
              ),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter text to translate",
                ),
                onChanged: (value){
                  setState(() {
                    inputText = value;
                  });
                },
              ),
              SizedBox(height: 16,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: inputLanguage,
                  onChanged: (newValue){
                    setState(() {
                      inputLanguage = newValue!;
                    });
                  },
                  items: <String>[
                    'en',
                    'fr',
                    'es',
                    'de',
                    'ur',
                    'hi',
                  ].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Icon(Icons.arrow_forward_ios_rounded),
                DropdownButton<String>(
                  value: outputLanguage,
                  onChanged: (newValue){
                    setState(() {
                      outputLanguage = newValue!;
                    });
                  },
                  items: <String>[
                    'en',
                    'fr',
                    'es',
                    'de',
                    'ur',
                    'hi',
                  ].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],),
              SizedBox(height: 16,),
              ElevatedButton(
                  onPressed: translateText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    minimumSize: Size.fromHeight(55)
                  ),
                  child: Text("Translate")
              ),
              SizedBox(height: 30,),
              TextField(
                controller: outputController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                  setState(() {
                    inputText = value;
                  });
                },
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}

