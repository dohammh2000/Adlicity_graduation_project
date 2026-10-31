import 'package:adlicity/core/utils/assets_manager.dart';

String getAdTypeIcon(String type) {
  switch (type) {
    case 'fullVideo':
      return IconsAssets.fullVideo;
    case 'inVideo':
      return IconsAssets.inVideo;
    case 'post':
      return IconsAssets.post;
    case 'reel':
      return IconsAssets.reel;

    default:
      return IconsAssets.story;
  }
}
