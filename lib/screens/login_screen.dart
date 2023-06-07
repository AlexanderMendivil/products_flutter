import 'package:flutter/material.dart';
import 'package:products/providers/login_form_provider.dart';
import 'package:products/ui/input_decorations.dart';
import 'package:products/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
              Text('Login', style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: 30,),
              ChangeNotifierProvider(create: (_)=> LoginFormProvider(), child: const _LoginForm()),
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
        final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column( children: [

        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(hintText: 'test@gmail.com', labelText: 'Correo electrónico', prefixIcon: Icons.alternate_email_sharp),
          onChanged: (value) => loginForm.email = value,
          validator: ( value ){
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);
              return regExp.hasMatch(value!) ? null : 'El correo no es correcto';

              
            },
          ),
          const SizedBox(height: 30,),

          TextFormField(
          autocorrect: false,
          obscureText: true,
          decoration: InputDecorations.authInputDecoration(
            hintText: '****', 
            labelText: 'Contraseña', 
            prefixIcon: Icons.lock_clock_outlined),
            onChanged: (value) => loginForm.password = value,
            validator: ( value ){

              if(value != null && value.length >= 6) return null;
              return 'La contraseña debe de ser de minimo 6 caracteres';

              
            },
          
          ),
          const SizedBox(height: 30,),

          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,

            onPressed: loginForm.isLoading ? null : () async {

              FocusScope.of(context).unfocus();
              if(!loginForm.isValidForm()) return;
               
              loginForm.isLoading = true;
              await Future.delayed(const Duration(seconds: 2));
              loginForm.isLoading = false;
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, 'home');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text( loginForm.isLoading ? 'Espere...' : 'Ingresar',
                style: const TextStyle(color: Colors.white),
                )))

      ],)
      );
  }
}