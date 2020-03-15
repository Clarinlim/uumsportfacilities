import 'package:flutter/material.dart';
import 'package:sport_facility/loginscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: 'Material App',
      home: Scaffold(
        body: Container(
          child:Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image:DecorationImage(
                    image: AssetImage('assets/images/splash.png'),
                    fit:BoxFit.contain) 
                )
                ),
                ProgressIndicator(),
                ],
                ),

        ),

      ),
    );
  }
}
class ProgressIndicator extends StatefulWidget{
@override 
_ProgressIndicatorState createState() => new _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator> 
with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<double> animation;

  @override 
  void initState(){
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000), vsync: this);
      animation = Tween(begin:0.0,end:1.0).animate(controller)
      ..addListener((){
        setState(() {
          if (animation.value>0.99){
            Navigator.push( 
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
            
          }
          
        });
      });
        controller.repeat();
  }
  @override 
  void dispose(){
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: Alignment(0,0.6),
      child: new Container(
        child: CircularProgressIndicator(
          value:animation.value,
          valueColor:new AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
        )
    );
  }



}



 

 
