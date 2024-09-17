import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double height = 100;
  bool closed = true;
  double scale = 1;
  bool apper = false;
  bool hearts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 130, 130),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: scale,
              duration: const Duration(milliseconds: 100),
              child: SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  children: [
                    Positioned(
                      top: height,
                      child: SizedBox(
                        height: 100,
                        child: Align(
                          alignment: Alignment.center,
                          child: Transform.flip(
                            flipY: closed,
                            child: CustomPaint(
                              size: Size(300, 100),
                              painter: TrianglePainter(
                                  color: Color.fromARGB(255, 206, 65, 55)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!closed)
                      AnimatedPositioned(
                        bottom: 0,
                        top: apper ? -100 : 100,
                        duration: const Duration(seconds: 1),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 300,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 134, 64, 172),
                                  Color.fromARGB(255, 244, 68, 55),
                                ],
                              ),
                            ),
                            child: Image.asset(
                              'assets/image.png',
                              height: 200,
                              width: 100,
                            ),
                          ),
                        ),
                      ),
                    if (!closed & apper)
                      for (int i = 0; i < 100; i++)
                        AnimatedPositioned(
                            left: 300 * (i / 10),
                            top: hearts
                                ? -100
                                : 120 +
                                    (i % 2 == 0
                                        ? i < 50
                                            ? 0
                                            : 60
                                        : i < 50
                                            ? 40
                                            : 20),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            duration: Duration(seconds: 1)),
                    Positioned(
                      bottom: 0,
                      child: CustomPaint(
                        painter: TrianglePainter(
                            color: const Color.fromARGB(255, 206, 65, 55)),
                        size: const Size(300, 100),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: CustomPaint(
                          painter: TrianglePainter(color: Colors.red),
                          size: const Size(200, 150),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: CustomPaint(
                          painter: TrianglePainter(color: Colors.red),
                          size: const Size(200, 150),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTapDown: (TapDownDetails) {
                setState(() {
                  scale = 0.8;
                });
              },
              onTapUp: (TapUpDetails) {
                setState(() {
                  scale = 1;
                });
              },
              onTap: () {
                if (closed) {
                  closed = false;
                  height = 0;
                  Timer(Duration(milliseconds: 100), () {
                    setState(() {
                      apper = true;
                    });
                  });
                  Timer(Duration(milliseconds: 200), () {
                    setState(() {
                      hearts = true;
                    });
                  });
                } else {
                  apper = false;
                  Timer(Duration(seconds: 1), () {
                    setState(() {
                      closed = true;
                      height = 100;
                    });
                    Timer(Duration(milliseconds: 200), () {
                      setState(() {
                        hearts = false;
                      });
                    });
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  closed ? 'open' : 'close',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return false;
  }
}
