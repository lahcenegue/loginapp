import 'package:flutter/material.dart';
import 'package:loginapp/constants/constants.dart';
import 'package:loginapp/screens/home/payment/payment_screen.dart';
import 'package:loginapp/widgets/costum_container.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  final String token;

  const HomeScreen({
    super.key,
    required this.name,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        drawer: const Drawer(),
        body: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 60, top: 10),
                height: screenHeight * 0.25,
                width: screenWidth,
                color: Constants.kMainColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'أهلا',
                      style: TextStyle(
                        color: Constants.textColor,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        color: Constants.textColor,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: screenHeight * 0.2,
                child: SizedBox(
                  width: screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      customContainer(
                        onTap: () {},
                        icon: Icons.add_circle_outline,
                        title: 'إظافة',
                      ),
                      customContainer(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PaymentScreen(token: token),
                              ));
                        },
                        icon: Icons.payment_outlined,
                        title: 'عمليات الدفع',
                      ),
                      customContainer(
                        onTap: () {},
                        icon: Icons.group,
                        title: 'المجموعات',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
