import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_practice_chat_flutter/data/chat/repository/firebase.dart';

class AppComponent extends Component {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final navigator = GlobalKey<NavigatorState>();

  final chatRepository = ChatRepositoryFirebase(FirebaseFirestore.instance);
}
