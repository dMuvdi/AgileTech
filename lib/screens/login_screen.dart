import 'package:agile_tech/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:get/get.dart';

import '../widgets/custom_text_field.dart';

class LogInScreen  extends StatelessWidget {
  const LogInScreen ({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(LogInController());

    return Scaffold(
      backgroundColor: const Color(0xFFFFECEC),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(23, 150, 23, 30),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF670F0F),
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamilyToken.montserrat
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Row(
                    children: [
                      Text(
                        'Hola,',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFF670F0F),
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamilyToken.montserrat
                        ),
                      ),
                      Text(
                        ' Bienvenido',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFFFF5454),
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamilyToken.montserrat
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Por favor incia sesión para continuar',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF670F0F),
                      fontFamily: FontFamilyToken.montserrat
                    ),
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    hintText: 'Correo electrónico', 
                    type: TextInputType.emailAddress,
                    validator: (value) => controller.validateEmail(value),
                    isPassword: false,
                    onChanged: (value) => controller.setEmail = value,
                  ),
                  const SizedBox(height: 15,),
                  CustomTextField(
                    hintText: 'Contraseña', 
                    type: TextInputType.visiblePassword, 
                    isPassword: true,
                    validator: (value) => controller.validatePassword(value),
                    onChanged: (value) => controller.setPassword = value,
                  ),
                  const SizedBox(height: 25,),
                  TextButton(
                    onPressed: () => controller.onLogIn(),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(const Color(0xFF670F0F)),
                      backgroundColor: MaterialStateProperty.all(const Color(0xFFFF5454)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                      fixedSize: MaterialStateProperty.all(const Size(400, 54)),
                    ), 
                    child: const Text(
                      'Inciar Sesión',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: FontFamilyToken.montserrat
                      ),
                    ),
                  ),
                  const SizedBox(height: 60,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¿No tienes cuenta?',
                        style: TextStyle(
                          fontFamily: FontFamilyToken.montserrat,
                          fontSize: 14,
                          color: Color(0xFF670F0F),
                        ),
                      ),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: () => controller.goToSignUp(),
                        child: Container(
                          width: 85,
                          height: 20,
                          color: Colors.transparent,
                          child: const Text(
                            'Regístrate',
                            style: TextStyle(
                              fontFamily: FontFamilyToken.montserrat,
                              fontSize: 14,
                              color: Color(0xFFFF5454),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}