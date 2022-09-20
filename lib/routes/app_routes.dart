import 'package:quiz_app/controllers/question_paper/question_paper_controller.dart';
import 'package:quiz_app/controllers/zoom_drawer_controller.dart';
import 'package:quiz_app/screens/home/home_screen.dart';
import 'package:quiz_app/screens/introduction/introduction.dart';
import 'package:quiz_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes{
static List<GetPage> routes()=>
    [
      GetPage(name: "/",page: ()=> SplashScreen()),
      GetPage(name: "/introduction",page: ()=> AppIntroductionScreen()),
      GetPage(name: "/home",page: ()=> HomeScreen(),
        binding:BindingsBuilder((){
          Get.put(QuestionPaperController());
          Get.put(MyZoomDrawerController());
        }),
      ),
    ];
}