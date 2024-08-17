import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evacuaid/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpDialog extends StatefulWidget {
  @override
  _HelpDialogState createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> with TickerProviderStateMixin {
  bool _showMessage = false;
  String _message = '';
  AnimationController? _controller;
  int _timeLeft = 10;

  Future<String?> getUserUID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userUID');
  }

  void startHelpTimer() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..addListener(() {
      if (mounted) {
        setState(() {
          _timeLeft = 10 - (_controller!.value * 10).toInt();
        });
      }
    });

    _controller!.forward().whenComplete(() async {
      final uid = await getUserUID();
      if (!_showMessage && mounted) {
        setState(() {
          _message = 'Help is on its way';
          _showMessage = true;
        });
        await FirebaseFirestore.instance.collection('families').doc(uid).update({'needHelp': 'yes'});
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure the controller is initialized when the dialog is built
    if (_controller == null) {
      startHelpTimer();
    }

    return AlertDialog(
      backgroundColor: EvacPrimaryColor,
      content: _showMessage
          ? Text(
        _message,
        style: TextStyle(fontSize: 24),
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Do you need help?',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(
            value: _controller?.value,
            semanticsLabel: 'Linear progress indicator',
          ),
          SizedBox(height: 20),
          Text(
            'Time left: $_timeLeft seconds',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: StadiumBorder(),
                side: BorderSide.none),
            child: Text('Yes'),
            onPressed: () async {
              final uid = await getUserUID();
              setState(() {
                _message = 'Help is on its way';
                _showMessage = true;
                _controller?.stop();
              });
              await FirebaseFirestore.instance.collection('families').doc(uid).update({'needHelp': 'yes',});
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: StadiumBorder(),
                  side: BorderSide.none),
              child: Text('No'),
              onPressed: () {
                setState(() {
                  _message = "Glad to know you're safe!\nConsider helping";
                  _showMessage = true;
                  _controller?.stop();
                });
              }
          )
        ],
      ),
    );
  }
}