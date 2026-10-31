import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

int fieldsCount = 4; // Number of OTP fields
late List<FocusNode> focusNodes = List.generate(fieldsCount, (index) => FocusNode());
late List<TextEditingController> controllers = List.generate(fieldsCount, (index) => TextEditingController());

}
