import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/space_between.dart';
import '../../Modules/Authentication/login_page.dart';
import '../Constants/colors.dart';

class MyAppBarWidget extends StatelessWidget {
  String studentFoto;

  MyAppBarWidget({
    required this.studentFoto,
  });

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  final SPGlobal _prefs = SPGlobal();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBrandPrimaryColor,
      title: Container(
        width: 152.0,
        height: 50.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/logo-toolbar.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
      titleSpacing: 15.0,
      elevation: 0,
      leading: null,
      automaticallyImplyLeading: false,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          width: 58.0,
          child: CircleAvatar(
            radius: 25,
            foregroundImage: NetworkImage(
              studentFoto,
            ),
            child: PopupMenuButton(
              onSelected: (value) {
                if (value == 1) {
                  _prefs.idPerson = 0;
                  _prefs.documentNumber = "";
                  _prefs.fullName = "";
                  _prefs.image = "";
                  _prefs.role = "";
                  _prefs.email = "";
                  _prefs.sectionName = "";
                  _prefs.gradeName = "";
                  _prefs.roomName = "";
                  _prefs.isLogin = false;
                  _prefs.jwt = "";

                  _googleSignIn.signOut();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                    (route) => false,
                  );
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.output_outlined,
                          color: kBrandPrimaryColor,
                        ),
                        dividerWidth6,
                        Text(
                          "Cerrar sesión",
                          style: TextStyle(
                            color: kBrandPrimaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
        )
      ],
    );
  }
}
