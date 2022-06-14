import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String text;

  const CustomDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 300, horizontal: 50),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // горизонтально по центру
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // вертикальное расположение элементов
          children: [
            Expanded(
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 100, // получаем дабл число равное ширине текущего экрана
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                  color: Colors.green,
                ),
                child: const Center(child: Text("OK", style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
