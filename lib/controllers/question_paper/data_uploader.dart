import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz_app/firebase_ref/references.dart';
import 'package:quiz_app/models/question_paper_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataUploader extends GetxController{
  @override
  void onReady(){
    uploadData();
    super.onReady();
  }

  Future<void> uploadData()async{
    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!).loadString("AssetManifest.json");
   final Map<String,dynamic> manifestMap =  json.decode(manifestContent);

   //load json file and print path
   final papersInAssets = manifestMap.keys.where((path)=> path.startsWith("assets/DB/papers")&&path.contains(".json")).toList();

   List<QuestionPaperModel> questionPapers = [];
   for(var paper in papersInAssets) {
      String stringPaperContent =  await rootBundle.loadString(paper);
      questionPapers.add(QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
   }
  // print("Items number ${questionPapers[0].description}");
    var batch = fireStore.batch();

   for(var paper in questionPapers){
     batch.set(questionPaperRF.doc(paper.id
     ), {
       "title":paper.title,
       "image_url": paper.imageUrl,
       "description": paper.description,
       "time-seconds":paper.timeSeconds,
       "question_count": paper.questions==null ? 0 : paper.questions!.length,

     });
   }
   await batch.commit();

  }
}