import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //With this code we are closing the Debug Banner
      title: 'Loan Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController loanController = TextEditingController();
  TextEditingController creditController = TextEditingController();
  TextEditingController annualController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var pr, prMc, n, k;
  String result = "0.0";
  String rate = "0.0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Loan Calculator"),
      ),
      body: ListView(
        children: [
          customText("Loan Amount", 20),
          customTextField(loanController),
          customText("Credit period (month)", 20),
          customTextField(creditController),
          customText("Annual interest rate (%)", 20),
          customTextField(annualController),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFF0DDDD),
                side: BorderSide(width: 2, color: Colors.black)
              ),
              onPressed: () {
                setState(() {
                  k = double.parse(loanController.value.text);
                  n = double.parse(creditController.value.text);
                  pr = double.parse(annualController.value.text);
                });
                calculateMontlyRate(pr);
                calculateRepaidAmount(k, n, pr);
              },
              child: Text(
                "Calculate",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
          customText("Motly rate", 20),
          customResults(context, result),
          customText("Repaid amount", 20),
          customResults(context, rate),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Center(child: customText("Emirhan Serin", 30)),
              ),
            ),
          )
        ],
      ),
    );
  }

   customResults(BuildContext context, String res) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white.withOpacity(0.3),
        ),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(res),
        ),
      ),
    );
  }

  customTextField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white.withOpacity(0.3),
        child: TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2)),
          ),
        ),
      ),
    );
  }

  calculateMontlyRate(var annualRate) {
    setState(() {
      prMc = annualRate / 1200;
      String montlyRate = prMc.toString();
      result = montlyRate;
    });
  }

  calculateRepaidAmount(var loanAmount, creditPeriod, annualRate) {
    prMc = annualRate / 1200;
    var forPow = prMc + 1;
    var rateRepaid =
        (loanAmount * prMc) / (1 - (1 / (pow(forPow, creditPeriod))));
    String repaidAmount = rateRepaid.toString();
    setState(() {
      rate = repaidAmount;
    });
  }

  customText(String text, double size) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: size),
      ),
    );
  }
}
