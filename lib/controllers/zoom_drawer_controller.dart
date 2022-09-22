import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:quiz_app/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyZoomDrawerController extends  GetxController{
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toggleDrawer(){
    zoomDrawerController.toggle?.call();
    update();

  }
  void signOut(){
    Get.find<AuthController>().signOut();

  }

  void signIn(){

  }

  void website(){
    _launch("https://www.linkedin.com/in/shimul-tamo-598b47135/");

  }

  void github(){
    _launch("https://facebook.com");

  }

  void email(){
   final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'shimulmandaltamo@gmail.com'
    );
    _launch(emailLaunchUri.toString());

  }

 Future<void> _launch(String url)async{
    if( !await launch(url)){
      throw 'could not launch $url';
    }

  }

}