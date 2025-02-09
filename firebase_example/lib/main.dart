import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/tabsPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'memoPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: MemoPage()
    );
  }
}

class FirebaseApp extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  FirebaseApp({Key? key, required this.analytics, required this.observer}) : super(key: key);

  @override
  State<FirebaseApp> createState() => _FirebaseAppState(analytics, observer);
}

class _FirebaseAppState extends State<FirebaseApp> {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  late String _message ='';

  _FirebaseAppState(this.analytics, this.observer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Firebase Example'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: _sendAnalyticsEvent,
                child: Text('테스트')
            ),
            Text(_message, style: const TextStyle(color: Colors.blueAccent),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.tab),
          onPressed: (){
        Navigator.of(context).push(MaterialPageRoute<TabsPage>(
            settings: RouteSettings(name: '/tab'),
            builder: (BuildContext context) { return TabsPage(observer);}
        ));

          },),

    );
  }


  void setMessage(String message){
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string' : 'hello flutter',
        'int' :  100,
      }
    );
    setMessage('Analytics 보내기 성공');
  }

}


