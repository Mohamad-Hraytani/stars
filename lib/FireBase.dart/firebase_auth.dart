/* import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// ignore: camel_case_types

/1/ السماحيات في الفايربيزز يجب ان تتغير اي يجب تحديد من يمكنه القراءة والكتابة على قاعدة بيانات الفايربيز
{
  "rules": {
    ".read": "auth!= null", // فقط المستخدمين الذين يسجلون الدخول يسمح لهم بلقراءةوالكتابة
    ".write":"auth!= null"
  }
}

 /2/WidgetsFlutterBinding.ensureInitialized(); // يجب وضعهم في بداية التطبيق
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   /3/ try {}on FirebaseAuthException catch (e) { // الفايير بييز يوفر خدمة التاكد من جميع انواع الاخطاء ..كلمات مررو خاطئة -ايميلات خاطئة...
      print(e); // لنعرف شو هو الخطا فقط نضع  في ترايكاتش حتى نقوم بطباعة الخطأ
    
    //  ممكن هيك 
  if(e.code == 'weak-password')
    ....
    }

class auc {
  FirebaseAuth fb = FirebaseAuth.instance;

  Future<User> sing(String email, String password) async {
    var s =
        await fb.signInWithEmailAndPassword(email: email, password: password);
    return s.user;
  }

  Future<User> create(String email, String password) async {
    var r = await fb.createUserWithEmailAndPassword(
        email: email, password: password);
    return r.user;
  }

  Future<User> cure() async {
    // ignore: await_only_futures
    var n = await fb.currentUser;
    return n;
  }

  sinout() async {
    await fb.signOut();
  }
 // فحص حالة وجود تسجيل دخول او لا بشكل تلقائي
   home: StreamBuilder( //SharedPreferences يقوم الفايربيز تلقائيا بفحل اذا كان هناك مستخدم قام بتسجيل الدخول او لا وذلك بدون الحاجة الى 
                  stream: FirebaseAuth.instance
                      .authStateChanges(), // تتاكد بشكل تلقائي من وجود مستخدم قام بتسجيل الدخول اول لا
                  builder: (context, snapshot) {
                    if (snapshot.hasData) // اذا كان هناك بيانات يقوم مباشرة بلتوجه للشاشة الرئيسة داخل التطبيق
                      return Container();
                    else// اما في حال عدم وجود بيانات يقوم بلتوجه الى شاشة تسجيل الدخول
                      return Container();
                  })





/*//  بشكل مباشر حتى نتعلم كيف نتعامل مع اي موقعAPIfirebaseالتعامل مع 
 Future<void> mAPIfirebase(
      String email, String pass, String typeSing, BuildContext context) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$typeSing?key=AIzaSyD6h4f9Rt3_t7izuiKJHJQo-R5LuenKSBE');
try {//لمعالجة اخطاء الايملات وكلمات السر لانو هون مافي معالجة اتوماتيكية
var u = await http.post(url,body: jsonEncode( {'email': email, 'password': pass, 'returnSecureToken': true}));
var err = jsonDecode(u.body);
      if (err['error'] != null) { //error لانو المفتاح يلي بجي فيو الخطأ اسمو 
        throw err['error']['message'];} // catchثم ارميه بشكل يديوي لل error يلي بقلب المفتاح'message استخراج رسالة الخطامن قلب المفتاح
 // للتاكد ان المستخدم سجل دخول
  setState(() {
        t = err['idToken'];
        us = err['localId'];
        ex = DateTime.now().add(Duration(seconds: int.parse(err['expiresIn'])));

     autolongout()// نقوم باستدعاء تابع تسجيل الخروج التلقائي هنا
     
     //SharedPreferences مشان التطبيق يضل يتذكر بيانات الدخول ويدخل لحالو رح نستعمل ال
      final per = await SharedPreferences.getInstance(); // هنا نريد ان نحفظ بيانات الدخول حتى يتم تسجيل الدخول التلقائي في المرة القادمة
      final userdate = jsonEncode( // مشان نحطن بلمفتاح ونرسلن لانو عنا اكتر من قيمةString نحول البيانات الى 
          {'token': t, 'userId': us, 'expiresIn': ex.toIso8601String()});
      per.setString('userdate', userdate); //String نرسلهم ك 
     //tryautlogin ثم نستلمهم بتابع ال
      
Future<bool> tryautlogin() async { // تابع استقبال القيمة ليحفظها
    final pre = await SharedPreferences.getInstance();
    if (!pre.containsKey('userdate')) return false; // نفحص اذا المفتاح فيو بيانات او لا

    final extract =
        jsonDecode(pre.getString('userdate')) as Map<String, Object>; // Mapثم نستقبلهم ونحولهم الى جيسون وثم نحزنها ك
    final ex1 = DateTime.parse(extract['expiresIn']); // نستقبل القيم يلي بداخل المفتاح..ثم نحولها الى نوع وقت
    if (ex1.isBefore(DateTime.now())){// نفحص اذا الوقت المتبقي قبل هلق يعني انتهى
      return false; //false ارجع 
    }

    t = extract['token']; // نستقبل البيانات
    us = extract['userId'];
    ex = ex1;
    // provider notifyListeners();
    //autolongout()
    return true; //true بعد استلام البيانات بشكل صحيصح ارجع 
  }

      
      
      
      });
// برا التابع 
 String t;
  String us;
  DateTime ex;
String get tok {
    if (ex != null && ex.isAfter(DateTime.now()) && t != null) {
      return t;
    }
    return null;}
 bool get Auth {
    return tok != null; } 
  
     Auth ? go4() : FutureBuilder(  // حتى احدد اذا FutureBuilderاستلم قيمة التابع عبر ال
      future: tryautlogin(),
      //طبعا هون الدالة ترجع فقط ترو او فولس ولكن بداخل الدالة مجرد يصير في قيمة للتوكن رح يطلع من الشرط لالاساسي ويروح على الصفحة الداخلية
      builder: (ctx , snapshot)
      {return
       snapshot.connectionState == 
        ConnectionState.waiting ? SplashScreen() : Authpage(); // اذا في انتظار طالع شاشة انتظاراو روح على الشاشة الرئيسية
      } );// ينتقل على الشاشة المطلوبة Authحسب قيمة ال mainتنفيذ بل
 
//مهممممممة
//حتى نتاكد ان المستخدم قام بتسجيل الدخول post/get/delete/patch ويجب تمرريره الى الدوالة token حصلنا على ال

 } catch (e) {
      tot(e.toString(), context); // مررت الى تابع  وحصرا مع كونتكسToast حتى يطبعلي الخطا
    }
  }
// استدعاء الدوال حسب نوع الدخول اما حساب جديد او تسجيل دخول  
  await mAPIfirebase(co.text, co2.text, 'signUp', context)
  await mAPIfirebase(co.text, co2.text, 'signInWithPassword', context)

// nullلتسجيل الخروج فقط ننشأ تابع << ونقوم بوضع المتغيرات الثلاثة بحالة longout
longout(){
 t = null;
 us = null;
 ex = null;
Timer ti;
if (ti != null) { //تصفير التاميرات اذا كان في شي بقيان من قبل
ti.cancel();
ti = null;}
//   notifyListeners()

final pre = await SharedPreferences.getInstance(); // لازم لما نعمل تسجيل خروج من نمسح البيانات من الشيردبرفرينسس حتى ما يضل متذكرن ويرجع يسجل دخول
pre.clear(); // 
}
//وبذلك يتم تسجيل الخروج Authيذهب الى شاشة تسجيل الدخول حسب التابع  nullقيمته  tوذلك لانه عندما يصبح ال
  

autolongout(){ // لتجسيل الخروج بشكل تلقائي 
 Timer ti;
      if (ti != null) {
        ti.cancel();
      }  
      var timelate = ex.difference(DateTime.now()).inSeconds; // من هنا نحسب الفرق بين الوقت الحالي والوقت المتبقي لانتهاء مهلة الدخول
      Time(Duration(seconds: timelate), logout);

}






   */





}
 */