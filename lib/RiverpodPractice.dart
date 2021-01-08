import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
final counterProvider =
    ChangeNotifierProvider((ref) => _RiverpodPracticeCounter());

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class RiverpodPractice extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Example')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${watch(counterProvider).counter}'),
            RaisedButton(
              child: const Text('add data'),
              color: Colors.orange,
              textColor: Colors.white,
              onPressed: () {
                print('hoge');
                CollectionReference users =
                    FirebaseFirestore.instance.collection('addtestdesu');
                users
                    .add({
                      'hoge': 'hoge${watch(counterProvider).counter}',
                      'fuga': 'fuga',
                      'age': 1
                    })
                    .then((value) => print('hoge user added.'))
                    .catchError((error) => print('hoge failed. $error'));
              },
            )
          ],
        ),
        floatingActionButton: _RiverpodPracticePageFab(),
      ),
    );
  }
}

class _RiverpodPracticePageFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read(counterProvider).incrementCounter();
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}

class _RiverpodPracticeCounter extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    this._counter++;
    notifyListeners();
  }
}
