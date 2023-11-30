import 'package:agile_tech/controllers/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:get/get.dart';

import '../widgets/custom_text_field.dart';

class SignUpScreen  extends StatelessWidget {
  const SignUpScreen ({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: const Color(0xFFFFECEC),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child:ListView.builder(
            padding: const EdgeInsets.fromLTRB(23, 50, 23, 30),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sing up',
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
                    'Por favor regístrate para continuar',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF670F0F),
                      fontFamily: FontFamilyToken.montserrat
                    ),
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                    hintText: 'Nombre', 
                    type: TextInputType.name,
                    validator: (value) => controller.validateNameAndLastName(value),
                    isPassword: false,
                    onChanged: (value) => controller.setName = value,
                  ),
                  const SizedBox(height: 15,),
                  CustomTextField(
                    hintText: 'Apellido',
                    type: TextInputType.name,
                    validator: (value) => controller.validateNameAndLastName(value),
                    isPassword: false,
                    onChanged: (value) => controller.setLastName = value,
                  ),
                  const SizedBox(height: 15,),
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
                  const SizedBox(height: 15,),
                  CustomTextField(
                    hintText: 'Repetir contraseña', 
                    type: TextInputType.visiblePassword, 
                    isPassword: true,
                    validator: (value) => controller.validatePasswordReType(value),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 20.0, top: 7.0, bottom: 5.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE1E1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        //color: _dropdownError == null ? Colors.transparent : Colors.red.shade700,
                        color: Colors.transparent,
                      ),
                    ),
                    child: Obx(() {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(10),
                            hint: const Text(
                              'Rol',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF670F0F),
                                fontFamily: FontFamilyToken.montserrat
                              ),
                            ),
                            onChanged: (value) => controller.updateDropdownItem(value!),
                            value: controller.currentRole.value,
                            icon: const Icon(Icons.expand_more, color: Color(0xFF670F0F), size: 35,),
                            items: controller.dropdownItems
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, 
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF670F0F),
                                    fontFamily: FontFamilyToken.montserrat
                                  ),
                                ),
                              );
                            }).toList(),
                            isExpanded: true,
                          ),
                        );
                      }
                    ),
                  ),
                  const SizedBox(height: 25,),
                  GetBuilder<SignUpController>(
                    id: 'loading',
                    builder: (context) {
                      return TextButton(
                        onPressed: () async {
                          await controller.onSignUp();
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(const Color(0xFF670F0F)),
                          backgroundColor: MaterialStateProperty.all(const Color(0xFFFF5454)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                          fixedSize: MaterialStateProperty.all(const Size(400, 54)),
                        ), 
                        child: controller.loading == false ? const Text(
                          'Registrarse',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: FontFamilyToken.montserrat
                          ),
                        ):
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Color(0xFF670F0F),
                          ),
                        ),
                      );
                    }
                  ),
                  const SizedBox(height: 60,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¿Ya tienes cuenta?',
                        style: TextStyle(
                          fontFamily: FontFamilyToken.montserrat,
                          fontSize: 14,
                          color: Color(0xFF670F0F),
                        ),
                      ),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: () => controller.goToLogIn(),
                        child: Container(
                          width: 100,
                          height: 20,
                          color: Colors.transparent,
                          child: const Text(
                            'Inicia Sesión',
                            style: TextStyle(
                              fontFamily: FontFamilyToken.montserrat,
                              fontSize: 14,
                              color: Color(0xFFFF5454),
                              fontWeight: FontWeight.bold,
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