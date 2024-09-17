import 'package:chat/pages/src/stepper.dart';
import 'package:chat/theme/custom_color.dart';
import 'package:flutter/material.dart';

class FormProfileView extends StatefulWidget {
  const FormProfileView({super.key});

  @override
  State<FormProfileView> createState() => _FormProfileViewState();
}

class _FormProfileViewState extends State<FormProfileView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CusStepper(
          type: CusStepperType.horizontal,
          lineColor: CustomColor.primary, // new line add for the color change
          currentStep: _index,
          onStepCancel: () {
            if (_index > 0) {
              setState(() {
                _index -= 1;
              });
            }
          },
          onStepContinue: () {
            if (_index <= 1) {
              setState(() {
                _index += 1;
              });
            }
          },
          onStepTapped: (int index) {
            setState(() {
              _index = index;
            });
          },
          steps: <CusStep>[
            CusStep(
              title: const Text('Title'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text('Content for Step 1 $_index'),
                    Text('Content for Step 1 $_index'),
                    Text('Content for Step 1 $_index'),
                  ],
                ),
              ),
              isActive: _index == 0,
            ),
            CusStep(
              title: Text(''),
              content: Text('Content for Step 2 $_index'),
              isActive: _index == 1,
            ),
            CusStep(
              title: Text(''),
              content: Text('Content for Step 3 $_index'),
              isActive: _index == 2,
            ),
          ],
        ),
      ),
    );
  }
}
