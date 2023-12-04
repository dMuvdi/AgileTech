import 'package:agile_tech/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ProfileController());

    return GetBuilder<ProfileController>(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pérfil de usuario'),
                IconButton(
                  onPressed: () { 
                     controller.logOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Nombre: ${controller.name} ${controller.lastName}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Email: ${controller.email}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rol: ${controller.role}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 25),
                TextButton(
                  onPressed: () {
                    
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(const Color.fromARGB(255, 250, 181, 181)),
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFFFE1E1)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                    fixedSize: MaterialStateProperty.all(const Size(400, 54)),
                  ), 
                  child: const Text(
                    'Editar información',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF670F0F),
                    ),
                  )
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}