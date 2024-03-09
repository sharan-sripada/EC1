import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 4, 250, 156)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Rorschach test'),
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
  late AudioRecorder audioRecord;
  late AudioPlayer audioPlayer;
  late SharedPreferences prefs;
  final SpeechToText speechToText = SpeechToText();
  bool isListening = false;
  bool speechEnabled = false;
  String wordsSpoken = "";

  bool isRecording = false;
  String audioPath = '';
  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioRecord = AudioRecorder();
    initSpeech();
    loadSharedPreferences();
    super.initState();
  }

  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  loadSharedPreferences() async {
    prefs = await SharedPreferences
        .getInstance(); //Instantiating the object of SharedPreferences class.
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    audioRecord.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      await speechToText.listen(onResult: onSpeechResult);
      setState(() {
        isRecording = true;
        List<String> responses = prefs.getStringList("responses") ?? [];
        responses.add(wordsSpoken);
        prefs.setStringList("responses", responses);
        print(responses);
      });
    } catch (e) {
      print('Error Starting Recording: $e');
    }
  }

  void onSpeechResult(result) {
    setState(() {
      isRecording = true;
      wordsSpoken = "${result.recognizedWords}";
      // List<String> responses = prefs.getStringList("responses") ?? [];
      // responses.add(wordsSpoken);
      // prefs.setStringList("responses", responses);
      // print(responses);
      // print(wordsSpoken);
    });
  }

  Future<void> stopRecording() async {
    try {
      await speechToText.stop();
      setState(() {
        isRecording = false;
        // List<String> responses = prefs.getStringList("responses") ?? [];
        // responses.add(wordsSpoken);
        // prefs.setStringList("responses", responses);
        // print(responses);
      });
    } catch (e) {
      print('Error Stopping Recording: $e');
    }
  }

  Future<void> playRecording() async {
    try {
      Source sourcePath = UrlSource(audioPath);
      await audioPlayer.play(sourcePath);
    } catch (e) {
      print('Error playing recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Rorschach test'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Color.fromARGB(255, 12, 235, 123)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/images/Rorschach.jpg',
                  height: 200, // Adjust the height as needed
                  width: MediaQuery.of(context).size.width, // Take full width
                  fit: BoxFit.cover, // Adjust the image size to cover the area
                ),
              ),
              //Image.asset('assets/images/Rorschach.jpg'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'What do you see in the image above? Speak about it.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    // If listening is active show the recognized words
                    wordsSpoken != ""
                        ? '$wordsSpoken'
                        // If listening isn't active but could be tell the user
                        // how to start it, otherwise indicate that speech
                        // recognition is not yet ready or not supported on
                        // the target device
                        : speechEnabled
                            ? 'Tap the microphone icon to start speaking ...'
                            : 'Microphone access not available',
                  ),
                ),
              ),

              // if (isRecording) const Text('Recording in Progress'),
              // ElevatedButton(
              //   onPressed: isRecording ? stopRecording : startRecording,
              //   child: isRecording
              //       ? const Text('Stop Recording')
              //       : const Text('Start Recording'),
              // ),
              // if (!isRecording && audioPath != null)
              //   ElevatedButton(
              //       onPressed: playRecording,
              //       child: const Text('Play Recording')),
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.all(16),
              //     child: Text(
              //       wordsSpoken,
              //       style: const TextStyle(
              //         fontSize: 25,
              //         fontWeight: FontWeight.w300,
              //       ),
              //     ),
              //   ),
              // ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     '$wordsSpoken',
              //     style: TextStyle(fontSize: 20),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ElevatedButton(
              //     onPressed: isListening ? stopRecording : startRecording,
              //     child: Text(isListening ? 'Stop Listening' : 'Start Listening'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            speechToText.isNotListening ? startRecording : stopRecording,
        tooltip: 'Listen',
        child: Icon(speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
