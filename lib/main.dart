import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String htmlContent = r"""
<p>বল দুইটি একই রঙের পাওয়ার সম্ভাবনা</p>
<p><tex>=\mathrm{P} </tex> (বল দুইটি সাদা বা কালো)</p>
<p>= P (বল দুইটি সাদা) + P (বল দুইটি কালো)</p>
<p><tex>=\frac{{ }^3 \mathrm{C}_2}{{ }^8 \mathrm{C}_2}+\frac{{ }^5 \mathrm{C}_2}{{ }^8 \mathrm{C}_2}</tex></p>
<p><tex>=\frac{3}{28}+\frac{10}{28} </tex></p>
<p><tex>=\frac{3+10}{28}=\frac{13}{28} </tex></p>
<p>বল দুইটি ভিন্ন রঙের পাওয়ার সম্ভাবনা</p>
<p>= P (বেল দুইটির মধ্যে একটি সাদা ও একটি কালো)</p>
<p><tex>=\frac{{ }^3 \mathrm{C}_1 \times{ }^5 \mathrm{C}_1}{{ }^8 \mathrm{C}_2} </tex></p>
<p><tex>=\frac{3 \times 5}{28}=\frac{15}{28} </p>
<p>সুতরাং, বল দুইটি একই রঙের এবং ভিন্ন রঙের পাওয়ার সম্ভাবনা সমান নয়।</p>
""";

    String _ = htmlContent.replaceAllMapped(
      RegExp(r'\$(.*?)\$', dotAll: true),
      (match) {
        return '<tex>${match.group(1)}</tex>';
      },
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter TeX Example')),
        body: Column(
          children: [
            // Html(
            //   data: processedHtml, // Use the processed HTML string
            //   shrinkWrap: true,
            //   extensions: [
            //     TagExtension(
            //       tagsToExtend: {
            //         "tex",
            //       }, // This tells flutter_html to handle <tex> tags
            //       builder: (extensionContext) {
            //         return Math.tex(
            //           extensionContext
            //               .innerHtml, // The content inside the <tex> tag
            //           textStyle:
            //               extensionContext.styledElement?.style
            //                   .generateTextStyle(),
            //           onErrorFallback: (FlutterMathException e) {
            //             // Handle errors during math rendering
            //             return Text('Error rendering math: ${e.message}');
            //           },
            //         );
            //       },
            //     ),
            //   ],
            // ),
            const MedicalCard(
              title: "Physics",
              totalQuestions: 10,
              progress: 0.12,
            ),
          ],
        ),
      ),
    );
  }
}

class MedicalCard extends StatelessWidget {
  final String title;
  final int totalQuestions;
  final double progress; // 0.12 means 12%

  const MedicalCard({
    super.key,
    required this.title,
    required this.totalQuestions,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF0C0F1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                'assets/medical_bg.png', // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1D2F),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$totalQuestions Questions',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CustomPaint(
                      painter: ProgressPainter(progress: progress),
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(
                          child: Text(
                            '${(progress * 100).round()}%',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;

  ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint baseCircle =
        Paint()
          ..color = Colors.red.withOpacity(0.2)
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke;

    Paint progressCircle =
        Paint()
          ..color = Colors.red
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width / 2) - 4;

    canvas.drawCircle(center, radius, baseCircle);

    double sweepAngle = 2 * 3.1415926 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57,
      sweepAngle,
      false,
      progressCircle,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
