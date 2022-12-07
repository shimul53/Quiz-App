import 'package:get/get.dart';
import 'package:quiz_app/controllers/auth_controller.dart';
import 'package:quiz_app/firebase_ref/references.dart';
import 'package:quiz_app/models/question_paper_model.dart';
import 'package:quiz_app/screens/question/questions_screen.dart';
import 'package:quiz_app/services/firebase_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/utils/app_logger.dart';
class QuestionPaperController extends GetxController{
  final allPaperImages =<String>[].obs;
  final allPapers = <QuestionPaperModel>[].obs;
  @override
  void onReady(){
    getAllPapers();
    super.onReady();
  }
 Future<void> getAllPapers() async{
    List<String> imgName = ["biology", "chemistry", "maths", "physics"];
    try{
      QuerySnapshot<Map<String,dynamic>> data = await questionPaperRF.get();
     final paperList =  data.docs.map((paper) => QuestionPaperModel.fromSnapshot(paper)).toList();
     allPapers.assignAll(paperList);

      for(var paper in paperList){
      final imgUrl =  await Get.find<FirebaseStorageService>().getImage(paper.title);
      paper.imageUrl = imgUrl;
      }
      allPapers.assignAll(paperList);

    }catch(e){
      AppLogger.e(e);
    }
  }

  void navigateToQuestions({required QuestionPaperModel paper, bool tryAgain = false}){
    AuthController _authController = Get.find();
    if(_authController.isLoggedIn()){
      if(tryAgain){
        Get.back();
        Get.toNamed(QuestionsScreen.routeName,arguments: paper,preventDuplicates: false);
      }else{

        Get.toNamed(QuestionsScreen.routeName,arguments:paper );

      }
      }else{

      _authController.showLoginAlertDialogue();

    }
  }
}