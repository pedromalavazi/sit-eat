
import 'package:flutter/material.dart';


//Configurações da Foto do usuario
class ProfileFoto extends StatelessWidget {
  const ProfileFoto({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 130,
      child: Stack(
        //fit: StackFit.expand,
        //overflow: Overflow.visible,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: Theme.of(context).scaffoldBackgroundColor
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius:2, blurRadius:10,
                  color: Colors.black.withOpacity(0.15),
                  offset: Offset(0,10),
                )
              ],
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/logo5.png"),
              ),
            ),
          ),
          
          /*CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage("assets/profile.png"),
          ),
          //Botão para trocar foto, se for implementar
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white)
                  ),
                  color: Color(0xFFF5F6F9),
                  onPressed: (){},
                  child: Icon(Icons.photo_camera, color: Colors.black,),
                  ),
                ),
              ),*/
        ],
      ),
    );
  }
}