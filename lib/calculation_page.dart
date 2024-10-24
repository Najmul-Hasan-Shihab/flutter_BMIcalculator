import 'package:flutter/material.dart';
import 'result_page.dart';
import 'package:get/get.dart';

class BMICalculationPage extends StatefulWidget {
  @override
  _BMICalculationPageState createState() => _BMICalculationPageState();
}

class _BMICalculationPageState extends State<BMICalculationPage> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  double weight = 0.0;
  double height = 0.0;
  int age = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.lightBlueAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildGenderContainer("Male", isMaleSelected, () {
                    setState(() {
                      isMaleSelected = true;
                      isFemaleSelected = false;
                    });
                  },
                      'assets/images/male.png'
                  ),
                  SizedBox(width: 20),
                  buildGenderContainer("Female", isFemaleSelected, () {
                    setState(() {
                      isFemaleSelected = true;
                      isMaleSelected = false;
                    });
                  },
                      'assets/images/female.png'
                  ),
                ],
              ),
              SizedBox(height: 20),
              buildInputContainer("Weight (kg)", (value) {
                weight = double.tryParse(value) ?? 0.0;
              }),
              SizedBox(height: 20),
              buildInputContainer("Height (cm)", (value) {
                height = double.tryParse(value) ?? 0.0;
              }),
              SizedBox(height: 20),
              buildInputContainer("Age", (value) {
                age = int.tryParse(value) ?? 0;
              }),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (weight > 0 && height > 0) {
                    double bmi = calculateBMI(weight, height);

                    Get.to(
                      ResultPage(
                        bmiResult: bmi,
                        resultText: getResultText(bmi),
                        description: getInterpretation(bmi),
                      ),
                    );
                  } else {
                    Get.snackbar('Error', 'Please enter valid weight and height',colorText: Colors.white,);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Calculate",
                  style: TextStyle(fontSize: 18, color: Colors.cyan),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGenderContainer(
      String gender, bool isSelected, VoidCallback onTap, String imagePath) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyan : Colors.grey[200],
          border: Border.all(
            color: isSelected ? Colors.red : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 60,
              width: 60,
            ),
            SizedBox(height: 10),
            Text(
              gender,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputContainer(String label, Function(String) onChanged) {
    return Container(
      width: 300,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }

  double calculateBMI(double weight, double height) {
    return weight / ((height / 100) * (height / 100));
  }
  String getResultText(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Overweight";
    return "Obesity";
  }

  String getInterpretation(double bmi) {
    if (bmi < 18.5) return "You have a lower than normal body weight.";
    if (bmi < 25) return "You have a normal body weight. Good job!";
    if (bmi < 30) return "You have a higher than normal body weight.";
    return "You have obesity.";
  }
}
