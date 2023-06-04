import 'package:flutter/material.dart';
import 'package:products/ui/input_decorations.dart';
import 'package:products/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column( children: [
            const SizedBox( height: 250 ),
            CardContainer(child: Column(children: [
              const SizedBox(height: 10),
              Text('Login', style: Theme.of(context).textTheme.headline4,),
              const SizedBox(height: 30,),
              const _LoginForm()
            ]
            )
          ),
          const SizedBox( height: 50 ),
          const Text('Crear nueva cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          ],),
        )
        ,)
    );
  }
}


class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column( children: [

        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(hintText: 'test@gmail.com', labelText: 'Correo electrónico', prefixIcon: Icons.alternate_email_sharp),

          ),
          const SizedBox(height: 30,),

          TextFormField(
          autocorrect: false,
          obscureText: true,
          decoration: InputDecorations.authInputDecoration(
            hintText: '****', 
            labelText: 'Contraseña', 
            prefixIcon: Icons.lock_clock_outlined),
          
          ),
          const SizedBox(height: 30,),

          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: const Text(
                'Ingresar',
                style: TextStyle(color: Colors.white),
                )),
            onPressed: (){})

      ],)
      );
  }
}