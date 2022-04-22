import 'package:flutter/material.dart';
import 'package:huflit_flutter/screen/login.dart';
class LogoutFragmentWidget extends StatefulWidget {
  const LogoutFragmentWidget({Key? key}) : super(key: key);

  @override
  _LogoutFragmentWidgetState createState() => _LogoutFragmentWidgetState();
}

class _LogoutFragmentWidgetState extends State<LogoutFragmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Are you sure logout?',
        style: TextStyle(
          color: Colors.orange,
          fontWeight: FontWeight.w500,
          fontSize: 40
        ),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           ElevatedButton.icon(
               style: ElevatedButton.styleFrom(
                 primary: Colors.green,
                 onPrimary: Colors.black,
                 onSurface: Colors.grey,
                 minimumSize: Size(50,40),
                 elevation: 20
               ),

               label:const Text('YES'),
               icon:const Icon(Icons.check),
               onPressed:() {
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                   LoginScreen()

                 ));
               }),
            const SizedBox(width: 10,),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onSurface: Colors.grey,
                ),
                label:const Text('NO'),
                icon:const Icon(Icons.cancel_outlined),
                onPressed:() {})

                 ],
        )

      ],




    );
  }
}
