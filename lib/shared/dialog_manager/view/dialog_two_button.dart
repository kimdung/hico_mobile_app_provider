import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';

class DialogTwoButton extends StatelessWidget {
  const DialogTwoButton({
    required this.onPressedCancel,
    required this.onPressedAgree,
    required this.title,
    required this.content,
  });

  final VoidCallback onPressedCancel;
  final VoidCallback onPressedAgree;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _dialogOnButtonContent(context),
    );
  }

  Widget _dialogOnButtonContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Text(
                content,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onPressedAgree,
                      child: Card(
                        color: Colors.green,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          height: 35,
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              'yes'.tr.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: onPressedCancel,
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: AppColor.primaryColorLight, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          height: 35,
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              'no'.tr.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
