
import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color(0xffffffff).withOpacity(1.0);
canvas.drawRect(Rect.fromLTWH(0,0,size.width,size.height),paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}