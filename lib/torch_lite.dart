import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';

class TorhLiteScreen extends StatefulWidget {
  const TorhLiteScreen({super.key});

  @override
  State<TorhLiteScreen> createState() => _TorhLiteScreenState();
}

class _TorhLiteScreenState extends State<TorhLiteScreen> {
  final bgColor = const Color(0xff2C3333);

  final textColor = const Color(0xffE7F6F2);
  bool isActive = false;

  var controller = TorchController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        isActive
                            ? Padding(
                                padding: const EdgeInsets.only(left: 120),
                                child: Container(
                                  color: Colors.yellow.withOpacity(0.8),
                                  width: 100,
                                  height: 100,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Container(
                                  color: Colors.black,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Image.asset(
                            isActive
                                ? 'assets/images/torch_off.png'
                                : 'assets/images/torch_off.png',
                            width: 150,
                            height: 150,
                            color: isActive
                                ? textColor
                                : textColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    CircleAvatar(
                      minRadius: 10,
                      maxRadius: 35,
                      child: Transform.scale(
                          scale: 1.5,
                          child: IconButton(
                            onPressed: () {
                              controller.toggle();
                              isActive = !isActive;
                              setState(() {});
                            },
                            icon: Icon(Icons.power_settings_new),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          Text(
            "Developed By Sikander",
            style: TextStyle(color: textColor, fontSize: 14),
          ),
          SizedBox(
            height: size.height * 0.1,
          )
        ],
      ),
    );
  }
}
