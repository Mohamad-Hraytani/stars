/* import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';

//import 'firebase_options.dart';
  
  

 /*  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); */

  var ref = FirebaseDatabase.instance
      . // عملنا اوبجكت جديد
      reference()
      . // وحطيناه بلرفرينسس يلي عنا بلفاير بيز
      child('jjj'); // انشانا فئة جديدة حتى نسند بقلبا شغلات بدالة الست

  ref.push(). //افتراضي  idيعطي القيمة المضافة
      set({
    "name": 8
  }). // هنا اسند القيم اما ماب يضعها داخل الفئة الجديدة او ابعت قيمة بس فيعتبر الفئة هي المفتاح وياخذ القيمة التي ارسلتها كقيمة للمفتاح
      then((value) => print('object')); // عند الانتهاء من الارسال



/*post لارسال مجموعة من البيانات الى الفايربيز
  final n = Uri.parse(
      "https://mmh1-969e3-default-rtdb.firebaseio.com/jjj.json"); //  اسم الفئة.جيسون jjj.jsonنقوم بنسخ رابط الداتا بيز ونضع باخرو
  http
      .post( //API كتابة على ال
          n, // ثم بلاعتماد على دالة البوست سوف نرسل البيانات الى رابط قاعدة البيانات
          body: jsonEncode({
            "id": 1,
            "name": "mmh"
          }) //لانو بدنا نكتب على القاعدة String الى jsonحتى يقوم بلتحويل من jsonEncodeهنا استعمل

          )
      .then((value) => json.decode(value
          .body) //وقيمة nameالمولد تلقائيا ولكن على شكل مفتاح اسمه  idبعد الانتهاء تعيد ال
  var r = json.decode(value.body)[name]; // داخل التطبيق في المشاريع الكبيرةidالمولد يمكن اسناده للidال
 )
 */
  
/* // getوتكون على شكل ماب API جلب بيانات من 
final n =  Uri.parse("https://mmh1-969e3-default-rtdb.firebaseio.com/jjj.json");
    var res = await http.get(n);
    var res1 = jsonDecode(res.body) as Map<String, dynamic>;

    res1.forEach((key, value) {
      var h = mmh.firstWhere((elm) => elm.id == key, orElse: () => null);
      if (h == null) {
        setState(() {
          mmh.add(post(id: key, name: value['name']));
        });
      }
    }); */  

/* // patchتعديل محتويات البياينات الموجودة في الفاير بييز
// وعند التعديل في تطبيقنا يجب استبدال الاوبجكت كامل
  Future mUbdate(String id1, String key, String value) async {
    //تغديل القيم داخل الاوبجت كلو
    var url =
        Uri.parse('https://mmh1-969e3-default-rtdb.firebaseio.com/$id1.json');

    var nn = mmh.indexWhere((element) => element.id == id1 ,);
if(nn > 0){
   await   http.patch(url, body: jsonEncode({'id': key, 'name': value}));
}
  mmh[nn] = post(id: '',name: ''); //هيك بعدل الاوبجكت كامل
  }   
  
 // تعديل قيمة واحدة فقط وليس قيم الاوبجكت كلو 
  var url =
        Uri.parse('https://mmh1-969e3-default-rtdb.firebaseio.com/userfavorite/&userId/$id1.json?auth=$token');
  await   http.put(url, body: jsonEncode(isfavorite)); // بمرربو قيمة وحدة بس وهو حسب الرابط بيعدلا


  */
  

/* // deleteحذف عنصر 
// يجب الحذف بطريقة امساك الاندكس
  Future mDelet(String id1) async {
    var url =
        Uri.parse('https://mmh1-969e3-default-rtdb.firebaseio.com/$id1.json');
    final nnindx = mmh.indexWhere((element) => element.id == id1);
    var nnitem = mmh[nnindx];
    mmh.removeAt(
        nnindx); // قمنا بحذف بهذه الطريقة حتى يتم حذف العنصر من التطبيق بشكل كامل واذا صار شي مشكلة بلحذفة بلنت يكون عندي اندكس العنصر حتى احسن ارجع اضيفو
    var res = await http.delete(url); // يقوم بلحذف حسب اندكس العنصر الممرر
    if (res.statusCode >= 400) // اذا حصل مشكلة بلاتصال
{
      mmh.insert(nnindx, nnitem); // اعيد اضافة العنصر لانو حصل خطا
}
nnitem = null; //offlineمشان ما يبقى بلتطبيق وانا بحالة ال null اذا مافي غلط بلاتصال يبقى العنصر محذوف واسند له قيمة 
  } */


/* الFirebaseجلب بيانات مفلترة في  
fetch(bool filter)
{//وحسب قيمة البرامتر المرر تتحقق ما اذا كان مطلوب الفلترة ام لا Apiتقوم بجلب البيانات من  fetchدالة ال
 myfilter = filter? "orderBy='creatorId'&equalTo='$userId'":"" 
// لFirebaseفي حال كان هناك فلترة يتم كتابة تعليمة الفلترة الخاصة بل
//creatorId هو رقم داخل كل منتج يمثل ان هذا المنتج تابع لهذا الذبون
//userId هو رقم المستخدم الذي يريد الفلترة بلنسبة الو هلق
//فلما بقلو جبلي المنتجات التي تتبع لهذا الذبون هنا تكون الفلترة
final n = Uri.parse(
"https://mmh1-969e3-default-rtdb.firebaseio.com/jjj.json?auth=$authtoken&$myfilter");
// اضيف للرابط الفلترة التي اريدها

}
*/
//مهممممة
// يجب تمريره الى كل دالة (اضافة او حذف او تعديل ) السابقات حتى يتم التاكد من ان المستخدم قام بتسجيل دخول ليتم السماح له بلقيام بلعمليات السابقة  tokenوبعد الحصول على ال
// في رابط البيانات التي نتعامل معهاjson بعد ال?auth=$authtokenحيث نقوم باضافة هذه الجملة

final n = Uri.parse(
      "https://mmh1-969e3-default-rtdb.firebaseio.com/jjj.json?auth=$authtoken");


//  firebase_core: 
// firebase_database:   
  
   */