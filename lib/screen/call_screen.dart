import 'package:flutter/material.dart';
import 'package:flutter_company_service/setups/setup_call/entry_page.dart';

import '../component/appbar.dart';
import '../component/drawer.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: 'CallScreen', context: context),
      drawer: commonDrawer(context: context),
      drawerEnableOpenDragGesture: false,
      resizeToAvoidBottomInset: false,
      body: const EntryPage(),
    );
  }
}
