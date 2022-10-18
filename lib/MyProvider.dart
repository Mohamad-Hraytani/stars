import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ارسال بيانات بين الكلاسات بشكل مباشر
class Mypro with ChangeNotifier {
  int cout = 0;
  void inc1() {
    cout++;
    notifyListeners(); //بعد كل تعليمة يجب وضع هذه
  }
}

/* class MyApp extends StatelessWidget {
// listen فقط نعطي قيمة تروو للحدث اي عندما نستمع للمتحول يلي بدنا ياه او بدنا قيمتو
// اما اذا لنستمع لدالة ما بلزمنا نستمع الها منحطا فولس

/1/ طريقة 1 لجلبة البيانات
Text(Provider.of<Mypro>(context).cout.toString()); // عرض قيمة متحول داخل البروفايدر
Provider.of<Mypro>(context,listen: false).inc1(); //استدعاء دالة داخل البروفايدر

/2/ طريقة 2 لجلب البيانات
context.watch<Mypro>().cout.toString()// خذخ الدالة ضمنيا تستمع 
context.read<Mypro>().inc1(); // هذه الدالة ضمنياا لا تستمع

/3/ طريقة 3 لجلب الببيانات عبر Consumer
  Consumer<Mypro>(
      builder: (ctx, value, child) {
            return Text(value.cout.toString());},)

/4/Selector<Mypro,String>( // طريقة 4 تحتاج لتحديد نوغع البايانات ايضا ولا تعيد رسم الوجت
              selector: (context, val) => val.cout.toString(),
              builder: (ctx, value, child)=>Text(value),)   
                    
/5/Text(context.select<Mypro,String>((value) => value.cout.toString())) // طريقة خامسة باستخدام السليكت وتحتاج لتحديد نوع البيانات
  
  
  
  Widget build(BuildContext context) {
    /* return MaterialApp(
      home: ChangeNotifierProvider( // 
        create: (_) => Mypro(), // ابوه للتحت
         child: go4()), // ابنو للفوق
    ); */
    
return MultiProvider(providers: [ // اكثر من بروفايدر
ChangeNotifierProvider<Mypro>( // 
        create: (_) => Mypro()), // ابوه للتحت
       
ChangeNotifierProvider( // 
        create: (_) => Mypro()), // ابوه للتحت
ChangeNotifierProvider.value(value: Mypro()),

ChangeNotifierProvider.value(
value:products[i] //Mypro() جبلي البايانات من هي اللست وبلش من عند العنصر الاول عملي تصميم وجت الها  
// Gradviwe or listview هو اندكس  iطبعا ال 
child:Mypro()),

ChangeNotifierProxyProvider<Mypro,Mypro1>( //Proxy عندما يكون هناك بروفايد يعتمد على بيانات بروفايدر اخر نستخدم
   // ويجب تعريف البروفايدر الاساسي فوق وبعدا يلي بعتمد عليه
   create: (_) => Mypro1(),
   update: //update يتم تغغير الدالة الى 
    (context 
    , value // القيمة الاولى التي من خلالها نصل الى بيانات البروفايدر الاساسي 
    , pp )=> // القيمة التي نصل من خلالها الى البروفايدر الثاني
     pp..getDate(value.token,
     pp.postes==null? []:pp.postes  
     //الذي يقوم باستقبال القيمة ووضعهابمتغيرات البرفايدر عندو  getهنا رجعنا مررنا الليستاية القديمة عبر تابع 
     //لانو ما منحسن نبعت القيم عبر الباني لانو تعاملنا هلق مع بروفايدر فيجب ان يكون التعامل من خلال تابع جواتو
     //pp وذلك لانه كل مرة نستدعي هذا البروفايدر نفقد قيمة الليست القديمة لذلك نقوم باعادة ارسالها مرة اخرة بما انو عنا البيانات القديمة من
     // او لاnullويجب ان نفحصها اذا تشير الى 
     ))
getdate(String token ,List pp){ // في بروفايدير الثاني
aythtoken = token
mmh = pp ;
//   notifyListeners()
}
]) ;
   */   
         
        



  


// provider: ^4.3.2+2
//import 'package:provider/provider.dart';


