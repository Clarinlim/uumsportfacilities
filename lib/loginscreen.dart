
import 'package:flutter/services.dart';
//import 'package:sport_facility/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:sport_facility/registrationscreen.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

void main() => runApp(LoginScreen());
bool rememberMe = false;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  String urlLogin = "https://lilbearandlilpanda.com/uumsportfacilities/php/user_login.php";

  @override 
  void initState(){
    super.initState();
    print("Hello i'm in INITSTATE");
    loadPref();

  }
  
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body:Stack(
              children:<Widget>[
         Container(decoration: BoxDecoration(image: DecorationImage(
               image:AssetImage('assets/images/login.png'), fit: BoxFit.cover
                )),),

            Align(
              child:Container(
                child:Column(children: <Widget>[
                  SizedBox(
                height: 300,
              ),
              Card(
                elevation:10,
                  child: Container(
                      height: 260,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(20),
                      child: Column(children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text("LOGIN",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 25,
                                fontWeight: FontWeight.w900
                              )),
                        ),
                        TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(   
                              labelStyle: TextStyle( color: const Color(0xF0fd0202)),
                              labelText: 'Email',
                              icon: Icon(Icons.email),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color:Colors.red),
                              ),
                              
                            )),
                        TextField(
                          controller: _passController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: const Color(0xF0fd0202)),  
                            labelText: 'Password',
                            icon: Icon(Icons.lock),
                             enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color:Colors.red),
                              ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Checkbox(
                              value: rememberMe,
                              checkColor: Colors.white,
                              activeColor: Colors.red,
                              onChanged: (bool value) {
                                _onRememberMeChanged(value);
                              },
                            ),
                            Text('Remember Me',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(width: 70,),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Text('Login'),
                              color: Colors.red,
                              textColor: Colors.white,
                              onPressed: _userlogin,
                            ),
                  ],
                 )
                ]
              )
              )),
Container(
                child: Column(
                  children:<Widget>[
                    SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Don't have an account? ", style: TextStyle(fontSize: 16.0,color:Colors.white),),
              GestureDetector(
                onTap: _registerUser,
                child: Text(
                  "Create Account",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Forgot your password? ", style: TextStyle(fontSize: 16.0, color: Colors.white),),
              GestureDetector(
                onTap: _forgotPassword,
                child: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ],
          )
                  ]
                )
              ),

                ],)
    
              )
            ),
            

              
          
        ])
              ),
    );
      }
                                                             
                                                             
void _onRememberMeChanged(bool newValue) => setState(() {
  rememberMe = newValue;
  print(rememberMe);
  if(rememberMe){
    savepref(true);
  }else{
    savepref(false);
      }
    });

    Future<bool> _onBackPressed(){
      return showDialog(
        context: context,
        builder:(context)=>new AlertDialog(
          title:new Text('Confrim?'),
          content: new Text('Exit an App?'),
          actions: <Widget>[
            MaterialButton(
              onPressed: (){
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child:Text("Exit")),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
            },
            child: Text("Cancel")),
            ],
          ),
        )??
        false;
    }
                                                          
    void _registerUser() {
      showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title:new Text("Confirmation massage"),
                    content:new Container(
                      height: 50,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Are you sure want to create an account?",
                          ),
                          ],),
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          child:new Text ("Yes"),
                          onPressed: () {
                            Navigator.of(context).pop();
                             Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegistrationScreen()));                          
                          }
                  ),
                  new FlatButton(
                    child:new Text("No"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                  )
                  ]);

                }
                );

       
    }
                

                                         
            void _forgotPassword() {
              TextEditingController phoneController = TextEditingController();
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title:new Text("Forget Password?"),
                    content:new Container(
                      height: 100,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Key in your recovery email",
                          ),
                          TextField(
                            decoration:InputDecoration(
                              labelText:'Email',
                              icon:Icon(Icons.email), 
                            )
                      )],),
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          child:new Text ("Yes"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            print(
                              phoneController.text,
                            );
                          }
                  ),
                  new FlatButton(
                    child:new Text("No"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                  )
                  ]);

                }
                );
              }
            
     void _userlogin() {
        String email =_emailController.text;
         String password = _passController.text;

         http.post(urlLogin,body:{
           "email": email,
           "password":password,
         }).then((res){
           if (res.body == "success"){
            // Navigator.push(context,
             //MaterialPageRoute(builder:(BuildContext context)=> MainScreen()));
             Toast.show("Login Done",context,
             duration:Toast.LENGTH_LONG,gravity:Toast.BOTTOM);
           }else{
             Toast.show("Login failed", context,
             duration: Toast.LENGTH_LONG,gravity:Toast.BOTTOM);
           }
         }).catchError((err){
           print(err);

         });
         }
     void loadPref()async{
       SharedPreferences prefs = await SharedPreferences.getInstance();
       String email =(prefs.getString('email'))??'';
       String password = (prefs.getString('pass'))??'';
       if(email.length>1){
         setState((){
           _emailController.text =email;
           _passController.text = password;
           rememberMe = true;
         });
       }
     }


      void savepref(bool value) async {
        String email =_emailController.text;
        String password = _passController.text;
        SharedPreferences prefs= await SharedPreferences.getInstance();
        if(value){
          await prefs.setString('email',email);
          await prefs.setString('pass',password);
          Toast.show("Preferences have been saved",context,
           duration: Toast.LENGTH_SHORT, gravity:Toast.BOTTOM);
        }else{
          await prefs.setString('email','');
          await prefs.setString('pass','');
          setState((){
            _emailController.text = '';
            _passController.text = '';
            rememberMe = false;

          });
          Toast.show("Preferences have removed",context,
          duration:Toast.LENGTH_SHORT,gravity:Toast.BOTTOM);
        }

        }
      }
    