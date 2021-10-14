import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sit_eat/app/controller/profile_photo_controller.dart';
import 'package:sit_eat/app/data/services/auth_service.dart';

//Configurações da Foto do usuario
class ProfilePhoto extends StatelessWidget {
  final ProfilePhotoController _profilePhotoController =
      Get.put(ProfilePhotoController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 130,
      child: Stack(
        children: [
          Obx(
            () => Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.15),
                    offset: Offset(0, 10),
                  )
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    _profilePhotoController.userImage.value,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
