import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  bool pushNotifications = true;

  void togglePushNotification(bool value) {
    pushNotifications = value;

    emit(TogglePushNotifications(value: value));
  }
}
