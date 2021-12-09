import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sit_eat/app/controller/edit_profile_controller.dart';
import 'package:sit_eat/app/ui/android/widgets/button_widget.dart';
import 'package:sit_eat/app/ui/android/widgets/input_field.dart';

class EditProfilePage extends GetView<EditProfileController> {
  final EditProfileController _editProfileController = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        elevation: 1,
        title: Text("Minha Conta"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            //Tira o foco do campo de texto quando clicar fora
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            padding: EdgeInsets.only(left: 15, right: 15),
            children: [
              Center(
                child: SizedBox(
                  width: 130,
                  height: 130,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
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
                              fit: BoxFit.fill,
                              image: _editProfileController.image.value != null
                                  ? FileImage(
                                      File(_editProfileController.image.value.path),
                                    )
                                  : NetworkImage(
                                      _editProfileController.userImage.value,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFFF5F6F9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: Colors.black12),
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => Container(
                                      height: 100,
                                      width: context.mediaQuerySize.width,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Escolha uma opção',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Source Code Pro",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextButton.icon(
                                                onPressed: () {
                                                  _editProfileController.pickImage(ImageSource.camera);
                                                },
                                                icon: Icon(
                                                  Icons.camera,
                                                  color: Colors.black,
                                                ),
                                                label: Text(
                                                  'Camera',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Source Code Pro",
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              TextButton.icon(
                                                onPressed: () {
                                                  _editProfileController.pickImage(ImageSource.gallery);
                                                },
                                                icon: Icon(
                                                  Icons.image,
                                                  color: Colors.black,
                                                ),
                                                label: Text(
                                                  'Galeria',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Source Code Pro",
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Obx(
                () => Text(
                  _editProfileController.user.value.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 25),
              InputField(
                controller: _editProfileController.nameTextController,
                labelText: "Nome Completo",
                textInputType: TextInputType.name,
                validator: (value) {
                  if (GetUtils.isNullOrBlank(value)) {
                    return "Nome é obrigatório";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              InputField(
                controller: _editProfileController.phoneNumberTextController,
                labelText: "Número de telefone",
                textInputType: TextInputType.phone,
                validator: (value) {
                  if (GetUtils.isNullOrBlank(value)) {
                    return "Número é obrigatório";
                  } else if (!GetUtils.isPhoneNumber(value)) {
                    return "Número inválido";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              InputField(
                controller: _editProfileController.passwordTextController,
                validator: (value) {
                  if (!GetUtils.isNullOrBlank(value)) {
                    if (value.length < 6) {
                      return "Senha deve conter 6 caracteres";
                    }
                  }
                  return null;
                },
                labelText: "Senha",
                obscure: true,
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 15),
              InputField(
                controller: _editProfileController.confirmPasswordTextController,
                validator: (value) {
                  if (!GetUtils.isNullOrBlank(value)) {
                    if (value.length < 6) {
                      return "Confirmação de senha deve conter 6 caracteres";
                    }
                    if (value != _editProfileController.passwordTextController.text) {
                      return "Confirmação de senha deve ser igual a senha";
                    }
                  }
                  return null;
                },
                labelText: "Confirmação de senha",
                obscure: true,
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonWidget(
                    isWhiteTheme: true,
                    onPressed: () {
                      Get.back();
                    },
                    text: "Voltar",
                    height: 60,
                    width: 150,
                  ),
                  ButtonWidget(
                    onPressed: () {
                      _editProfileController.save();
                    },
                    text: "Salvar",
                    height: 60,
                    width: 150,
                  )
                ],
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
