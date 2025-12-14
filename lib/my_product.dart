import 'package:flutter/material.dart';
import 'api.dart';
class myproduct extends StatefulWidget {
  const myproduct({super.key});

  @override
  State<myproduct> createState() => _myproduct();
}

class _myproduct extends State<myproduct> {
  @override
  Future<void> initState() async {
    // TODO: implement initState
    super.initState();
    var api = API();
   await api.getALLProduct();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
Widget myBody(){
    return ListView(
      
    )
  }
}