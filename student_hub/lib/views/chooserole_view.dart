import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

enum Role { student, company }

class ChooseRole extends StatefulWidget {
  const ChooseRole({super.key});

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Student Hub',
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      backgroundColor: const Color(0xFFBEEEF7),
      actions: <Widget>[
        IconButton(
          icon: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset('assets/icons/user_ic.png'),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ChooseRoleState extends State<ChooseRole>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  Role? _role;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          activeIndex++;

          if (activeIndex == 4) {
            activeIndex = 0;
          }
        });
      }
    });

    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.3, // Start fading in at 50% of the animation duration
          0.8, // Fully faded in at 100% of the animation duration
          curve: Curves.easeIn,
        ),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const _AppBar(),
        backgroundColor: const Color(0xFFBEEEF7),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 0,
                ),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0, -0.5), end: const Offset(0, 0))
                      .animate(CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(
                      0.3,
                      1,
                      curve: Curves.fastOutSlowIn,
                    ),
                  )),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Join as company or Student',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // creta collum with cross axis alignment center and main axis sapce even
                Column(
                  children: [
                    // create row with main axis space even and black border
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // create container with width 150 and height 150
                        Container(
                          width: 600,
                          height: 120,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // create icon with size 50 and color blue
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Đặt nút ở phía bên phải
                                children: [
                                  const Icon(
                                    Iconsax.user,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Radio<Role>(
                                    value: Role.student,
                                    groupValue: _role,
                                    onChanged: (val) {
                                      setState(() {
                                        _role = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // create text with text student and color blue
                              const Text(
                                'I am a student, find a project',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // create container with width 150 and height 150
                        Container(
                          width: 600,
                          height: 120,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // create icon with size 50 and color blue
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Đặt nút ở phía bên phải
                                children: [
                                  const Icon(
                                    Iconsax.user,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Radio<Role>(
                                    value: Role.company,
                                    groupValue: _role,
                                    onChanged: (val) {
                                      setState(() {
                                        _role = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // create text with text student and color blue
                              const Text(
                                'I am a company, find engineer for project',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Đặt nút ở phía bên phải
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(0, -0.5),
                                  end: const Offset(0, 0))
                              .animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(
                                0.6,
                                1,
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: MaterialButton(
                              onPressed: () {
                                // Xử lý khi nút được nhấn
                              },
                              height: 45,
                              color: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Text(
                                "Create account",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Xử lý khi nút được nhấn
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}