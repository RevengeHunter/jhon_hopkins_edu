import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/space_between.dart';
import '../../Modules/Authentication/login_page.dart';
import '../Constants/colors.dart';

class MyAppBarWidget extends StatelessWidget {
  String text;
  String image;

  MyAppBarWidget({
    required this.text,
    required this.image,
  });

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  final SPGlobal _prefs = SPGlobal();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBrandPrimaryColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Text(
                "Grado: ${_prefs.gradeName}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.75),
                ),
              ),
              dividerWidth10,
              Text(
                "Sección: ${_prefs.sectionName}",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.75),
                ),
              ),
            ],
          ),
        ],
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
              image,
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
                  _prefs.isLogin = false;
                  _prefs.jwt = "";
                  _prefs.idToken = "";

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
